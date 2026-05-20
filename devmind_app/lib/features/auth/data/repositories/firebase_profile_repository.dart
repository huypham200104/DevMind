import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/profile_data.dart';
import '../../domain/repositories/profile_repository.dart';

class FirebaseProfileRepository implements ProfileRepository {
  FirebaseProfileRepository({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  @override
  Future<ProfileData> getProfile(String uid) async {
    final userRef = _firestore.collection('users').doc(uid);
    final results = await Future.wait([
      userRef.get(),
      userRef
          .collection('quiz_results')
          .orderBy('createdAt', descending: true)
          .limit(10)
          .get(),
      _firestore
          .collection('transactions')
          .where('userId', isEqualTo: uid)
          .limit(20)
          .get(),
    ]);

    final userSnapshot = results[0] as DocumentSnapshot<Map<String, dynamic>>;
    final quizSnapshot = results[1] as QuerySnapshot<Map<String, dynamic>>;
    final transactionSnapshot =
        results[2] as QuerySnapshot<Map<String, dynamic>>;

    final userData = userSnapshot.data() ?? <String, dynamic>{};
    final transactions = transactionSnapshot.docs.toList()
      ..sort(
        (a, b) => _readDateTime(
          b.data(),
          'createdAt',
        ).compareTo(_readDateTime(a.data(), 'createdAt')),
      );

    return ProfileData(
      wallet: _mapWallet(userData),
      learningStats: _mapLearningStats(userData),
      questionHistory: quizSnapshot.docs.map(_mapQuestionHistory).toList(),
      paymentHistory: transactions.map(_mapPaymentHistory).toList(),
    );
  }

  ProfileWalletData _mapWallet(Map<String, dynamic> data) {
    final freeExplainCount = _readInt(data, 'freeExplainCount');
    final paidCredits = _readInt(data, 'paidCredits');
    final freeCvScanCount = _readInt(data, 'freeCvScanCount');
    final paidCvScanCredits = _readInt(data, 'paidCvScanCredits');

    return ProfileWalletData(
      explainCredits: _sumNullable(freeExplainCount, paidCredits),
      cvScanCredits: _sumNullable(freeCvScanCount, paidCvScanCredits),
    );
  }

  ProfileLearningStatsData _mapLearningStats(Map<String, dynamic> data) {
    return ProfileLearningStatsData(
      totalQuizzesTaken: _readInt(data, 'totalQuizzesTaken'),
      totalCorrectAnswers: _readInt(data, 'totalCorrectAnswers'),
      totalQuestionsAnswered: _readInt(data, 'totalQuestionsAnswered'),
      currentStreak: _readInt(data, 'currentStreak'),
    );
  }

  ProfileQuestionHistoryItem _mapQuestionHistory(
    QueryDocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data();
    final quizType = _readString(data, 'quizType') ?? 'quiz';
    final category = _readString(data, 'category') ?? 'unknown';
    final correctAnswers = _readInt(data, 'correctAnswers');
    final totalQuestions = _readInt(data, 'totalQuestions');
    final score = _readInt(data, 'score');

    return ProfileQuestionHistoryItem(
      title: '${_formatQuizType(quizType)}: ${_formatCategory(category)}',
      dateLabel: _formatDateTime(_readDateTime(data, 'createdAt')),
      score: correctAnswers ?? _scoreToCorrectAnswers(score, totalQuestions),
      totalQuestions: totalQuestions ?? 10,
      accentColor: _accentColorForQuizType(quizType),
    );
  }

  ProfilePaymentHistoryItem _mapPaymentHistory(
    QueryDocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data();
    final status = _readString(data, 'status') ?? '';
    final isCompleted = status == 'completed';
    final creditAmount = _readInt(data, 'creditAmount');

    return ProfilePaymentHistoryItem(
      title: _readString(data, 'packageName') ?? 'Giao dịch',
      dateLabel: _formatDateTime(_readDateTime(data, 'createdAt')),
      amountLabel: isCompleted && creditAmount != null
          ? '+$creditAmount lượt'
          : 'Thất bại',
      isCompleted: isCompleted,
    );
  }

  int? _sumNullable(int? first, int? second) {
    if (first == null && second == null) {
      return null;
    }

    return (first ?? 0) + (second ?? 0);
  }

  int _scoreToCorrectAnswers(int? score, int? totalQuestions) {
    final normalizedTotal = totalQuestions ?? 10;
    if (score == null) {
      return 0;
    }

    return (score * normalizedTotal / 100).round();
  }

  String? _readString(Map<String, dynamic> data, String key) {
    final value = data[key];
    if (value is String && value.trim().isNotEmpty) {
      return value.trim();
    }

    return null;
  }

  int? _readInt(Map<String, dynamic> data, String key) {
    final value = data[key];
    if (value is int) {
      return value;
    }

    if (value is double) {
      return value.round();
    }

    return null;
  }

  DateTime _readDateTime(Map<String, dynamic> data, String key) {
    final value = data[key];
    if (value is Timestamp) {
      return value.toDate();
    }

    if (value is DateTime) {
      return value;
    }

    if (value is String) {
      return DateTime.tryParse(value) ?? DateTime.fromMillisecondsSinceEpoch(0);
    }

    return DateTime.fromMillisecondsSinceEpoch(0);
  }

  String _formatQuizType(String quizType) {
    return switch (quizType) {
      'technical' => 'Kỹ thuật',
      'iq' => 'IQ',
      _ => 'Bài luyện tập',
    };
  }

  String _formatCategory(String category) {
    return category
        .split('_')
        .where((part) => part.isNotEmpty)
        .map((part) => '${part[0].toUpperCase()}${part.substring(1)}')
        .join(' ');
  }

  int _accentColorForQuizType(String quizType) {
    return switch (quizType) {
      'technical' => 0xFF2ACDC1,
      'iq' => 0xFF4285F4,
      _ => 0xFFF59E0B,
    };
  }

  String _formatDateTime(DateTime dateTime) {
    if (dateTime.millisecondsSinceEpoch == 0) {
      return 'Không có thời gian';
    }

    final day = dateTime.day.toString().padLeft(2, '0');
    final hour = dateTime.hour.toString().padLeft(2, '0');
    final minute = dateTime.minute.toString().padLeft(2, '0');
    return '$day ${_monthName(dateTime.month)}, ${dateTime.year} • $hour:$minute';
  }

  String _monthName(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];

    return months[month.clamp(1, 12) - 1];
  }
}
