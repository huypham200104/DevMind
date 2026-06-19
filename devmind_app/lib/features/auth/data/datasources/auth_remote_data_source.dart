import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRemoteDataSource {
  static const _googleServerClientId =
      '209608465249-n0mfq8hubkbmndne3bgr8tqclr3rr4se.apps.googleusercontent.com';

  AuthRemoteDataSource({
    FirebaseAuth? firebaseAuth,
    FirebaseFirestore? firestore,
  }) : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
       _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;
  Future<void>? _googleSignInInitialization;

  Stream<User?> watchAuthState() => _firebaseAuth.authStateChanges();

  User? get currentUser => _firebaseAuth.currentUser;

  Future<UserCredential> signInWithEmail({
    required String email,
    required String password,
  }) {
    return _firebaseAuth.signInWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );
  }

  Future<UserCredential> signUpWithEmail({
    required String displayName,
    required String email,
    required String password,
  }) async {
    final credential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );

    final user = credential.user;
    if (user == null) {
      return credential;
    }

    final normalizedDisplayName = displayName.trim();
    if (normalizedDisplayName.isNotEmpty) {
      await user.updateDisplayName(normalizedDisplayName);
    }

    await _upsertUserProfile(
      user: user,
      displayName: normalizedDisplayName,
      provider: 'password',
    );

    return credential;
  }

  Future<UserCredential> signInWithGoogle() async {
    await _ensureGoogleSignInInitialized();

    if (!GoogleSignIn.instance.supportsAuthenticate()) {
      throw UnsupportedError(
        'Google Sign-In is not supported by this platform button.',
      );
    }

    final googleUser = await GoogleSignIn.instance.authenticate();
    final googleAuth = googleUser.authentication;
    final idToken = googleAuth.idToken;

    if (idToken == null || idToken.isEmpty) {
      throw const GoogleSignInException(
        code: GoogleSignInExceptionCode.providerConfigurationError,
        description: 'Google Sign-In did not return an idToken.',
      );
    }

    final credential = GoogleAuthProvider.credential(idToken: idToken);

    final userCredential = await _firebaseAuth.signInWithCredential(credential);
    final user = userCredential.user;

    if (user != null) {
      await _upsertUserProfile(
        user: user,
        displayName: user.displayName ?? googleUser.displayName,
        provider: 'google.com',
      );
    }

    return userCredential;
  }

  Future<void> updatePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    final user = _firebaseAuth.currentUser;
    if (user == null) {
      throw FirebaseAuthException(code: 'user-not-found', message: 'No user');
    }
    
    final email = user.email;
    if (email == null) {
      throw FirebaseAuthException(code: 'invalid-email', message: 'No email');
    }

    final credential = EmailAuthProvider.credential(
      email: email,
      password: currentPassword,
    );
    
    await user.reauthenticateWithCredential(credential);
    await user.updatePassword(newPassword);
  }

  Future<void> signOut() async {
    await Future.wait([
      _firebaseAuth.signOut(),
      _ensureGoogleSignInInitialized().then(
        (_) => GoogleSignIn.instance.signOut(),
      ),
    ]);
  }

  Future<void> _ensureGoogleSignInInitialized() {
    return _googleSignInInitialization ??= GoogleSignIn.instance.initialize(
      serverClientId: _googleServerClientId,
    );
  }

  Future<void> _upsertUserProfile({
    required User user,
    required String? displayName,
    required String provider,
  }) async {
    final now = FieldValue.serverTimestamp();
    final userRef = _firestore.collection('users').doc(user.uid);
    final counterRef = _firestore.collection('metadata').doc('users');

    try {
      await _firestore.runTransaction((transaction) async {
        final userSnapshot = await transaction.get(userRef);
        final userData = userSnapshot.data();
        final needsAccountOrder = !userSnapshot.exists;

        DocumentSnapshot<Map<String, dynamic>>? counterSnapshot;
        if (needsAccountOrder) {
          counterSnapshot = await transaction.get(counterRef);
        }

        final updateData = _buildUserProfileUpdate(
          user: user,
          displayName: displayName,
          provider: provider,
          existingData: userData,
          isNewUserDoc: !userSnapshot.exists,
          updatedAt: now,
        );

        if (needsAccountOrder) {
          final nextAccountOrder =
              (_readInt(counterSnapshot?.data(), 'totalUsers') ?? 0) + 1;
          updateData['accountOrder'] = nextAccountOrder;
          updateData['rankingOrder'] = nextAccountOrder;
          updateData['ranking'] = nextAccountOrder;
          transaction.set(counterRef, {
            'totalUsers': nextAccountOrder,
            'updatedAt': now,
          }, SetOptions(merge: true));
        }

        transaction.set(userRef, updateData, SetOptions(merge: true));
      });
    } on FirebaseException catch (error) {
      if (error.code != 'permission-denied') {
        rethrow;
      }

      await _upsertUserProfileWithoutAccountOrder(
        user: user,
        displayName: displayName,
        provider: provider,
        updatedAt: now,
      );
    }
  }

  Future<void> _upsertUserProfileWithoutAccountOrder({
    required User user,
    required String? displayName,
    required String provider,
    required Object updatedAt,
  }) async {
    final userRef = _firestore.collection('users').doc(user.uid);
    final userSnapshot = await userRef.get();
    final updateData = _buildUserProfileUpdate(
      user: user,
      displayName: displayName,
      provider: provider,
      existingData: userSnapshot.data(),
      isNewUserDoc: !userSnapshot.exists,
      updatedAt: updatedAt,
    );

    await userRef.set(updateData, SetOptions(merge: true));
  }

  Map<String, dynamic> _buildUserProfileUpdate({
    required User user,
    required String? displayName,
    required String provider,
    required Map<String, dynamic>? existingData,
    required bool isNewUserDoc,
    required Object updatedAt,
  }) {
    final updateData = <String, dynamic>{
      'email': user.email,
      'displayName': displayName?.trim() ?? '',
      'photoUrl': user.photoURL,
      'provider': provider,
      'updatedAt': updatedAt,
    };

    if (isNewUserDoc || existingData?['createdAt'] == null) {
      updateData['createdAt'] = updatedAt;
    }

    _setDefaultIfMissing(
      updateData,
      existingData,
      'freeExplainCount',
      0,
      force: isNewUserDoc,
    );
    _setDefaultIfMissing(
      updateData,
      existingData,
      'paidCredits',
      0,
      force: isNewUserDoc,
    );
    _setDefaultIfMissing(
      updateData,
      existingData,
      'rankingPoints',
      0,
      force: isNewUserDoc,
    );
    _setDefaultIfMissing(
      updateData,
      existingData,
      'totalQuizzesTaken',
      0,
      force: isNewUserDoc,
    );
    _setDefaultIfMissing(
      updateData,
      existingData,
      'totalCorrectAnswers',
      0,
      force: isNewUserDoc,
    );
    _setDefaultIfMissing(
      updateData,
      existingData,
      'totalQuestionsAnswered',
      0,
      force: isNewUserDoc,
    );
    _setDefaultIfMissing(
      updateData,
      existingData,
      'rankingOrder',
      _readInt(existingData, 'accountOrder') ?? 0,
      force: false,
    );
    _setDefaultIfMissing(
      updateData,
      existingData,
      'ranking',
      _readInt(existingData, 'rankingOrder') ??
          _readInt(existingData, 'accountOrder') ??
          0,
      force: false,
    );

    return updateData;
  }

  void _setDefaultIfMissing(
    Map<String, dynamic> updateData,
    Map<String, dynamic>? existingData,
    String key,
    Object value, {
    bool force = false,
  }) {
    if (force || existingData?[key] == null) {
      updateData[key] = value;
    }
  }

  int? _readInt(Map<String, dynamic>? data, String key) {
    final value = data?[key];
    if (value is int) {
      return value;
    }

    if (value is double) {
      return value.round();
    }

    return null;
  }
}
