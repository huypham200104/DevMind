import 'package:flutter/material.dart';

import '../../domain/entities/technical_course.dart';
import '../models/technical_quiz_ui.dart';
import 'technical_course_list.dart';
import 'technical_course_loading_list.dart';
import 'technical_quiz_state_card.dart';

class AllCoursesSection extends StatelessWidget {
  const AllCoursesSection({
    super.key,
    required this.courses,
    required this.isLoading,
    required this.errorMessage,
    required this.selectedCategory,
    required this.searchQuery,
    required this.onStart,
  });

  final List<TechnicalCourse> courses;
  final bool isLoading;
  final String? errorMessage;
  final String selectedCategory;
  final String searchQuery;
  final ValueChanged<TechnicalCourse> onStart;

  @override
  Widget build(BuildContext context) {
    if (errorMessage != null) {
      return TechnicalQuizStateCard(
        icon: Icons.cloud_off_outlined,
        title: 'Không thể tải khóa học',
        description: errorMessage!,
      );
    }

    if (isLoading) {
      return const TechnicalCourseLoadingList();
    }

    final visibleCourses = filterTechnicalCourses(
      courses,
      selectedCategory,
      searchQuery,
    );

    if (visibleCourses.isEmpty) {
      return const TechnicalQuizStateCard(
        icon: Icons.search_off_outlined,
        title: 'Không có khóa học',
        description: 'Không tìm thấy khóa học phù hợp với bộ lọc hiện tại.',
      );
    }

    return TechnicalCourseList(courses: visibleCourses, onStart: onStart);
  }
}
