import 'package:flutter/material.dart';

import '../../domain/entities/technical_course.dart';
import '../models/technical_quiz_ui.dart';
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
    required this.selectedCategory,
    required this.searchQuery,
    required this.onCreate,
    required this.onStart,
    required this.onDelete,
  });

  final String? userId;
  final List<TechnicalCourse> courses;
  final bool isLoading;
  final String? errorMessage;
  final String selectedCategory;
  final String searchQuery;
  final VoidCallback onCreate;
  final ValueChanged<TechnicalCourse> onStart;
  final ValueChanged<TechnicalCourse> onDelete;

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
      return TechnicalQuizStateCard(
        icon: Icons.cloud_off_outlined,
        title: 'Không thể tải khóa học của tôi',
        description: errorMessage!,
      );
    }

    if (isLoading) {
      return const TechnicalCourseLoadingList(itemCount: 1);
    }

    final visibleCourses = filterTechnicalCourses(
      courses,
      selectedCategory,
      searchQuery,
    );

    if (visibleCourses.isEmpty) {
      return const TechnicalQuizStateCard(
        icon: Icons.menu_book_outlined,
        title: 'Không có khóa học',
        description: 'Bạn chưa tạo khóa học nào trong danh mục này.',
      );
    }

    return TechnicalCourseList(
      courses: visibleCourses,
      onStart: onStart,
      onDelete: onDelete,
    );
  }
}
