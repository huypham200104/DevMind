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
  }) {
    final now = FieldValue.serverTimestamp();

    return _firestore.collection('users').doc(user.uid).set({
      'email': user.email,
      'displayName': displayName?.trim() ?? '',
      'photoUrl': user.photoURL,
      'provider': provider,
      'freeExplainCount': 0,
      'paidCredits': 0,
      'createdAt': now,
      'updatedAt': now,
    }, SetOptions(merge: true));
  }
}
