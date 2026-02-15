class Course {
  const Course({
    required this.id,
    required this.title,
    required this.category,
    required this.durationHours,
    required this.price,
  });

  final String id;
  final String title;
  final String category;
  final int durationHours;
  final double price;
}

class ExamQuestion {
  const ExamQuestion({
    required this.id,
    required this.text,
    required this.choices,
    required this.correctIndex,
  });

  final String id;
  final String text;
  final List<String> choices;
  final int correctIndex;
}

class Certificate {
  const Certificate({
    required this.id,
    required this.courseTitle,
    required this.issueDate,
    required this.verificationCode,
  });

  final String id;
  final String courseTitle;
  final DateTime issueDate;
  final String verificationCode;
}
