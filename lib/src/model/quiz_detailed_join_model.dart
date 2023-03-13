class DetailedQuizJoinModel {
  String? sId;
  String? quizID;
  String? conductedBy;
  String? title;
  String? description;
  String? subjectCode;
  String? forSection;
  String? forBranch;
  int? forSemester;
  int? totalQuestion;
  int? perQsMarks;
  int? totalMarks;
  int? quizDuration;
  int? totalAppearedStudent;
  String? quizStatus;

  DetailedQuizJoinModel({
    this.sId,
    this.quizID,
    this.conductedBy,
    this.title,
    this.description,
    this.subjectCode,
    this.forSection,
    this.forBranch,
    this.forSemester,
    this.totalQuestion,
    this.perQsMarks,
    this.totalMarks,
    this.quizDuration,
    this.totalAppearedStudent,
    this.quizStatus,
  });

  DetailedQuizJoinModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    quizID = json['quiz_id'];
    conductedBy = json['conducted_by'];
    title = json['title'];
    description = json['description'];
    subjectCode = json['subject'];
    forSection = json['section'];
    forBranch = json['branch'];
    forSemester = json['semester'];
    totalQuestion = json['total_questions'];
    perQsMarks = json['per_question_marks'];
    totalMarks = json['total_marks'];
    quizDuration = json['duration'];
    totalAppearedStudent = json['appeared_student_details'].length ?? 0;
    quizStatus = json['status'];
  }
}
