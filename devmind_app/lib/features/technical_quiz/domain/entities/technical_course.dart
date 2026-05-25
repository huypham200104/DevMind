class TechnicalCourse {
  const TechnicalCourse({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.questionCount,
    this.isMine = false,
  });

  final String id;
  final String title;
  final String description;
  final String category;
  final int questionCount;
  final bool isMine;
}
