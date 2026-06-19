import 'package:flutter/material.dart';

import '../../domain/entities/technical_course.dart';
import 'create_course_card.dart';
import 'technical_course_list.dart';
import 'technical_course_loading_list.dart';
import 'technical_quiz_state_card.dart';

class MyCoursesSection extends StatelessWidget {
  const MyCoursesSection({
    super.key,
    required this.userId,
    required this.courses,
    required this.isLoading,
    required this.errorMessage,
    required this.onCreate,
    required this.onStart,
    required this.onManage,
  });

  final String? userId;
  final List<TechnicalCourse> courses;
  final bool isLoading;
  final String? errorMessage;
  final VoidCallback onCreate;
  final ValueChanged<TechnicalCourse> onStart;
  final ValueChanged<TechnicalCourse> onManage;

  @override
  Widget build(BuildContext context) {
    if (userId == null) {
      return const TechnicalQuizStateCard(
        icon: Icons.lock_outline,
        title: 'Bạn chưa đăng nhập',
        description: 'Đăng nhập để xem các khóa học do bạn tạo.',
      );
    }

    return Column(
      children: [
        CreateCourseCard(onTap: onCreate),
        const SizedBox(height: 18),
        _buildCourseState(),
      ],
    );
  }

  Widget _buildCourseState() {
    if (errorMessage != null) {
      return const TechnicalQuizStateCard(
        icon: Icons.menu_book_outlined,
        title: 'Chưa tạo khóa học nào',
        description: 'Vui lòng nhấn "Tạo khóa học" để xây dựng bộ câu hỏi của riêng bạn.',
      );
    }

    if (isLoading) {
      return const TechnicalCourseLoadingList(itemCount: 1);
    }

    if (courses.isEmpty) {
      return const TechnicalQuizStateCard(
        icon: Icons.menu_book_outlined,
        title: 'Chưa có khóa học',
        description: 'Bạn chưa tạo khóa học nào.',
      );
    }

    return TechnicalCourseList(
      courses: courses,
      onStart: onStart,
      onManage: onManage,
    );
  }
}
