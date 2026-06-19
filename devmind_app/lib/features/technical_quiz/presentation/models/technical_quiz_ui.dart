

import '../../domain/entities/technical_course.dart';

enum TechnicalQuizTab { allCourses, myCourses }

class TechnicalQuizCategory {
  const TechnicalQuizCategory({required this.id, required this.title});

  final String id;
  final String title;
}

const technicalAllCategory = 'all';

const technicalQuizCategories = [
  TechnicalQuizCategory(id: technicalAllCategory, title: 'Tất cả'),
  TechnicalQuizCategory(id: 'flutter_dart', title: 'Flutter & Dart'),
  TechnicalQuizCategory(id: 'javascript', title: 'JavaScript'),
  TechnicalQuizCategory(id: 'react', title: 'React'),
  TechnicalQuizCategory(id: 'python', title: 'Python'),
  TechnicalQuizCategory(id: 'data_structures', title: 'Data Structures'),
  TechnicalQuizCategory(id: 'algorithms', title: 'Algorithms'),
  TechnicalQuizCategory(id: 'sql_database', title: 'SQL & Database'),
  TechnicalQuizCategory(id: 'system_design', title: 'System Design'),
  TechnicalQuizCategory(id: 'oop', title: 'OOP'),
  TechnicalQuizCategory(id: 'networking', title: 'Networking'),
];

String technicalCategoryTitle(String category) {
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

String technicalCategoryLogoUrl(String category) {
  return switch (category) {
    'flutter_dart' => 'https://cdn.jsdelivr.net/gh/devicons/devicon@latest/icons/flutter/flutter-original.svg',
    'javascript' => 'https://cdn.jsdelivr.net/gh/devicons/devicon@latest/icons/javascript/javascript-original.svg',
    'react' => 'https://cdn.jsdelivr.net/gh/devicons/devicon@latest/icons/react/react-original.svg',
    'python' => 'https://cdn.jsdelivr.net/gh/devicons/devicon@latest/icons/python/python-original.svg',
    'data_structures' => 'https://cdn.jsdelivr.net/gh/devicons/devicon@latest/icons/azuresqldatabase/azuresqldatabase-original.svg',
    'algorithms' => 'https://cdn.jsdelivr.net/gh/devicons/devicon@latest/icons/thealgorithms/thealgorithms-original.svg',
    'sql_database' => 'https://cdn.jsdelivr.net/gh/devicons/devicon@latest/icons/mysql/mysql-original.svg',
    'system_design' => 'https://cdn.jsdelivr.net/gh/devicons/devicon@latest/icons/amazonwebservices/amazonwebservices-original-wordmark.svg',
    'oop' => 'https://cdn.jsdelivr.net/gh/devicons/devicon@latest/icons/java/java-original.svg',
    'networking' => 'https://cdn.jsdelivr.net/gh/devicons/devicon@latest/icons/networkx/networkx-original.svg',
    _ => 'https://cdn.jsdelivr.net/gh/devicons/devicon@latest/icons/devicon/devicon-original.svg',
  };
}

List<TechnicalCourse> filterTechnicalCourses(
  List<TechnicalCourse> courses,
  String selectedCategory,
  String searchQuery,
) {
  final normalizedQuery = searchQuery.toLowerCase();

  return courses.where((course) {
    final matchesCategory =
        selectedCategory == technicalAllCategory ||
        course.category == selectedCategory;

    if (!matchesCategory) {
      return false;
    }

    if (normalizedQuery.isEmpty) {
      return true;
    }

    final searchable =
        '${course.title} ${course.description} ${technicalCategoryTitle(course.category)}'
            .toLowerCase();
    return searchable.contains(normalizedQuery);
  }).toList();
}
