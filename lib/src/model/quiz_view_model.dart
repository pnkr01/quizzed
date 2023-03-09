class QuizViewModel {
  String? quizId;
  String? title;
  String? description;
  String? subject;
  String? section;
  String? branch;
  String? startTime;
  int? semester;
  int? totalQuestions;
  int? totalMarks;
  int? duration;

  QuizViewModel({
    required this.quizId,
    required this.title,
    required this.description,
    required this.subject,
    required this.section,
    required this.branch,
    required this.semester,
    required this.totalQuestions,
    required this.totalMarks,
    required this.duration,
    this.startTime,
  });
  QuizViewModel.fromJson(Map<String, dynamic> json) {
    quizId = json['quiz_id'];
    title = json['title'];
    description = json['description'];
    subject = json['subject'];
    section = json['section'];
    branch = json['branch'];
    semester = json['semester'];
    totalQuestions = json['total_questions'];
    totalMarks = json['total_marks'];
    duration = json['duration'];
    startTime = json['startTime'] ?? "";
  }
}
