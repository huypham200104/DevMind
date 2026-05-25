import 'package:flutter/material.dart';

import '../../domain/entities/technical_course.dart';
import 'technical_course_card.dart';

class TechnicalCourseList extends StatelessWidget {
  const TechnicalCourseList({
    super.key,
    required this.courses,
    required this.onStart,
    this.onDelete,
  });

  final List<TechnicalCourse> courses;
  final ValueChanged<TechnicalCourse> onStart;
  final ValueChanged<TechnicalCourse>? onDelete;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (final course in courses) ...[
          TechnicalCourseCard(
            course: course,
            onStart: () => onStart(course),
            onDelete: course.isMine && onDelete != null
                ? () => onDelete!(course)
                : null,
          ),
          if (course != courses.last) const SizedBox(height: 14),
        ],
      ],
    );
  }
}
