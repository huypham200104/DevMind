import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/technical_course.dart';
import '../../domain/entities/technical_question.dart';
import '../../domain/repositories/technical_course_repository.dart';

class FirebaseTechnicalCourseRepository implements TechnicalCourseRepository {
  FirebaseTechnicalCourseRepository({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  @override
  Stream<List<TechnicalCourse>> watchAllCourses() {
    return _firestore
        .collection('technical_questions')
        .snapshots()
        .map((snapshot) => _mapQuestionCourses(snapshot.docs));
  }

  @override
  Stream<List<TechnicalCourse>> watchMyCourses(String uid) {
    return _firestore
        .collection('technical_courses')
        .where('createdBy', isEqualTo: uid)
        .snapshots()
        .map((snapshot) => _mapCustomCourses(snapshot.docs));
  }

  @override
  Future<void> deleteMyCourse(String courseId) {
    return _firestore.collection('technical_courses').doc(courseId).delete();
  }

  @override
  Future<void> createCustomCourse(
    String uid,
    String title,
    List<String> questionIds,
  ) async {
    await _firestore.collection('technical_courses').add({
      'title': title,
      'category': 'custom',
      'createdBy': uid,
      'questionCount': questionIds.length,
      'questionIds': questionIds,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  @override
  Future<void> removeQuestionFromCustomCourse(
    String courseId,
    String questionId,
  ) async {
    final docRef = _firestore.collection('technical_courses').doc(courseId);
    await docRef.update({
      'questionIds': FieldValue.arrayRemove([questionId]),
      'questionCount': FieldValue.increment(-1),
    });
  }

  @override
  Future<List<TechnicalQuestion>> loadQuestionsForCourse(
    TechnicalCourse course,
  ) async {
    if (course.isMine) {
      final customQuestions = await _loadCustomCourseQuestions(course);
      if (customQuestions.isNotEmpty) {
        return customQuestions;
      }
    }

    final snapshot = await _firestore
        .collection('technical_questions')
        .where('category', isEqualTo: course.category)
        .get();

    final questions = snapshot.docs.map(_mapTechnicalQuestion).toList();
    questions.sort((first, second) => first.id.compareTo(second.id));
    return questions;
  }

  @override
  Stream<int> watchExplainCredits(String uid) {
    return _firestore.collection('users').doc(uid).snapshots().map((snapshot) {
      final data = snapshot.data() ?? const <String, dynamic>{};
      return (_readSingleInt(data, 'freeExplainCount') ?? 0) +
          (_readSingleInt(data, 'paidCredits') ?? 0);
    });
  }

  @override
  Future<bool> consumeExplainCredit(String uid) async {
    final userRef = _firestore.collection('users').doc(uid);

    return _firestore.runTransaction((transaction) async {
      final snapshot = await transaction.get(userRef);
      final data = snapshot.data() ?? const <String, dynamic>{};
      final freeExplainCount = _readSingleInt(data, 'freeExplainCount') ?? 0;
      final paidCredits = _readSingleInt(data, 'paidCredits') ?? 0;

      if (freeExplainCount <= 0 && paidCredits <= 0) {
        return false;
      }

      if (freeExplainCount > 0) {
        transaction.update(userRef, {
          'freeExplainCount': freeExplainCount - 1,
          'updatedAt': FieldValue.serverTimestamp(),
        });
      } else {
        transaction.update(userRef, {
          'paidCredits': paidCredits - 1,
          'updatedAt': FieldValue.serverTimestamp(),
        });
      }

      return true;
    });
  }

  Future<List<TechnicalQuestion>> _loadCustomCourseQuestions(
    TechnicalCourse course,
  ) async {
    final courseSnapshot = await _firestore
        .collection('technical_courses')
        .doc(course.id)
        .get();
    final data = courseSnapshot.data();
    if (data == null) {
      return const [];
    }

    final inlineQuestions = data['questions'];
    if (inlineQuestions is List) {
      return inlineQuestions
          .whereType<Map<Object?, Object?>>()
          .map((questionData) => _mapInlineQuestion(questionData, course))
          .whereType<TechnicalQuestion>()
          .toList();
    }

    final questionIds = data['questionIds'];
    if (questionIds is List) {
      return _loadQuestionsByIds(questionIds.whereType<String>().toList());
    }

    return const [];
  }

  Future<List<TechnicalQuestion>> _loadQuestionsByIds(
    List<String> questionIds,
  ) async {
    if (questionIds.isEmpty) {
      return const [];
    }

    final questionsById = <String, TechnicalQuestion>{};
    for (var index = 0; index < questionIds.length; index += 10) {
      final chunk = questionIds.sublist(
        index,
        (index + 10).clamp(0, questionIds.length),
      );
      final snapshot = await _firestore
          .collection('technical_questions')
          .where(FieldPath.documentId, whereIn: chunk)
          .get();

      for (final doc in snapshot.docs) {
        questionsById[doc.id] = _mapTechnicalQuestion(doc);
      }
    }

    return [
      for (final id in questionIds)
        if (questionsById[id] != null) questionsById[id]!,
    ];
  }

  List<TechnicalCourse> _mapQuestionCourses(
    List<QueryDocumentSnapshot<Map<String, dynamic>>> docs,
  ) {
    final grouped = <String, _QuestionCategoryAccumulator>{};

    for (final doc in docs) {
      final data = doc.data();
      final category = _readString(data, const ['category']) ?? 'general';
      final accumulator = grouped.putIfAbsent(
        category,
        () => _QuestionCategoryAccumulator(category),
      );

      accumulator.addQuestion();
    }

    final courses = grouped.values.map((category) {
      final title = _categoryTitle(category.id);
      return TechnicalCourse(
        id: category.id,
        title: title,
        description: _categoryDescription(category.id),
        category: category.id,
        questionCount: category.count,
      );
    }).toList();

    courses.sort((a, b) => a.title.compareTo(b.title));
    return courses;
  }

  List<TechnicalCourse> _mapCustomCourses(
    List<QueryDocumentSnapshot<Map<String, dynamic>>> docs,
  ) {
    final courses = docs.map((doc) {
      final data = doc.data();
      final category = _readString(data, const ['category']) ?? 'custom';
      final title =
          _readString(data, const ['title', 'name', 'courseName']) ??
          _categoryTitle(category);

      return TechnicalCourse(
        id: doc.id,
        title: title,
        description:
            _readString(data, const ['description', 'subtitle', 'prompt']) ??
            'Bộ câu hỏi cá nhân từ DevMind AI.',
        category: category,
        questionCount: _readQuestionCount(data),
        isMine: true,
      );
    }).toList();

    courses.sort((a, b) => a.title.compareTo(b.title));
    return courses;
  }

  String? _readString(Map<String, dynamic> data, List<String> keys) {
    for (final key in keys) {
      final value = data[key];
      if (value is String && value.trim().isNotEmpty) {
        return value.trim();
      }
    }

    return null;
  }

  int _readQuestionCount(Map<String, dynamic> data) {
    final directCount = _readInt(data, const [
      'questionCount',
      'totalQuestions',
      'questionsCount',
    ]);
    if (directCount != null) {
      return directCount;
    }

    final questions = data['questions'];
    if (questions is List) {
      return questions.length;
    }

    final questionIds = data['questionIds'];
    if (questionIds is List) {
      return questionIds.length;
    }

    return 0;
  }

  int? _readInt(Map<String, dynamic> data, List<String> keys) {
    for (final key in keys) {
      final value = data[key];
      if (value is int) {
        return value;
      }

      if (value is double) {
        return value.round();
      }

      if (value is String) {
        final parsed = int.tryParse(value);
        if (parsed != null) {
          return parsed;
        }
      }
    }

    return null;
  }

  int? _readSingleInt(Map<String, dynamic> data, String key) {
    final value = data[key];
    if (value is int) {
      return value;
    }

    if (value is double) {
      return value.round();
    }

    if (value is String) {
      return int.tryParse(value);
    }

    return null;
  }

  TechnicalQuestion _mapTechnicalQuestion(
    QueryDocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data();
    final category = _readString(data, const ['category']) ?? 'general';

    return TechnicalQuestion(
      id: doc.id,
      question: _readString(data, const ['question', 'title']) ?? 'Câu hỏi',
      options: _readStringList(data['options']),
      correctAnswerIndex:
          _readInt(data, const ['correctAnswer', 'correctAnswerIndex']) ?? 0,
      explanation:
          _readString(data, const ['explanation', 'answerExplanation']) ??
          'Chưa có giải thích cho câu hỏi này.',
      category: category,
    );
  }

  TechnicalQuestion? _mapInlineQuestion(
    Map<Object?, Object?> data,
    TechnicalCourse course,
  ) {
    final normalizedData = <String, dynamic>{
      for (final entry in data.entries)
        if (entry.key is String) entry.key as String: entry.value,
    };
    final options = _readStringList(normalizedData['options']);
    if (options.isEmpty) {
      return null;
    }

    return TechnicalQuestion(
      id:
          _readString(normalizedData, const ['id']) ??
          '${course.id}_${normalizedData.hashCode}',
      question:
          _readString(normalizedData, const ['question', 'title']) ?? 'Câu hỏi',
      options: options,
      correctAnswerIndex:
          _readInt(normalizedData, const [
            'correctAnswer',
            'correctAnswerIndex',
          ]) ??
          0,
      explanation:
          _readString(normalizedData, const [
            'explanation',
            'answerExplanation',
          ]) ??
          'Chưa có giải thích cho câu hỏi này.',
      category: course.category,
    );
  }

  List<String> _readStringList(Object? value) {
    if (value is! List) {
      return const [];
    }

    return value.map((item) => item?.toString().trim() ?? '').where((item) {
      return item.isNotEmpty;
    }).toList();
  }

  String _categoryTitle(String category) {
    return switch (category) {
      'flutter_dart' => 'Flutter & Dart',
      'javascript' => 'JavaScript',
      'react' => 'React',
      'python' => 'Python',
      'data_structures' => 'Data Structures',
      'algorithms' => 'Algorithms',
      'sql_database' => 'SQL & Database',
      'system_design' => 'System Design',
      'oop' => 'OOP',
      'networking' => 'Networking',
      'custom' => 'Khóa học tùy chỉnh',
      'general' => 'Kỹ thuật tổng hợp',
      _ =>
        category
            .split('_')
            .where((part) => part.isNotEmpty)
            .map((part) => '${part[0].toUpperCase()}${part.substring(1)}')
            .join(' '),
    };
  }

  String _categoryDescription(String category) {
    return switch (category) {
      'flutter_dart' =>
        'Kiểm tra kiến thức về Dart, widget tree, state, lifecycle và các pattern phổ biến trong Flutter.',
      'javascript' =>
        'Ôn tập event loop, scope, closure, async, DOM và những nền tảng quan trọng của JavaScript.',
      'react' =>
        'Kiểm tra kiến thức về component, props, state, hooks và cách tối ưu giao diện React.',
      'python' =>
        'Ôn tập cú pháp, kiểu dữ liệu, hàm, module và những kỹ thuật xử lý phổ biến trong Python.',
      'data_structures' =>
        'Kiểm tra kiến thức cơ bản về mảng, danh sách liên kết, cây và các cấu trúc dữ liệu thường gặp.',
      'algorithms' =>
        'Ôn tập thuật toán tìm kiếm, sắp xếp, độ phức tạp và tư duy giải quyết bài toán.',
      'sql_database' =>
        'Kiểm tra kiến thức về SQL, quan hệ dữ liệu, truy vấn, index và thiết kế cơ sở dữ liệu.',
      'system_design' =>
        'Ôn tập kiến trúc hệ thống, scalability, caching, queue và các trade-off khi thiết kế sản phẩm.',
      'oop' =>
        'Kiểm tra kiến thức về class, object, kế thừa, đa hình, đóng gói và nguyên lý thiết kế hướng đối tượng.',
      'networking' =>
        'Ôn tập HTTP, TCP/IP, DNS, API, bảo mật và các khái niệm mạng nền tảng.',
      _ => 'Bộ câu hỏi kỹ thuật giúp bạn kiểm tra và củng cố kiến thức.',
    };
  }
}

class _QuestionCategoryAccumulator {
  _QuestionCategoryAccumulator(this.id);

  final String id;
  int count = 0;

  void addQuestion() {
    count += 1;
  }
}
