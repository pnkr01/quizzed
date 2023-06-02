// ignore_for_file: prefer_null_aware_operators

class PastQuizModel {
  String? sId;
  String? studentRegdNo;
  String? quizId;
  bool? completed;
  String? startTime;
  String? finishTime;
  String? createdAt;
  String? updatedAt;
  int? questionsAttemptedDetails;

  PastQuizModel(
      {this.sId,
      this.studentRegdNo,
      this.quizId,
      this.completed,
      this.startTime,
      this.finishTime,
      this.createdAt,
      this.updatedAt,
      this.questionsAttemptedDetails});

  PastQuizModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    studentRegdNo = json['student_regdNo'];
    quizId = json['quiz_id'];
    completed = json['completed'];
    startTime = json['start_time'];
    finishTime = json['finish_time'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    questionsAttemptedDetails = json['questions_attempted_details'] != null
        ? json['questions_attempted_details'].length
        : 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['student_regdNo'] = studentRegdNo;
    data['quiz_id'] = quizId;
    data['completed'] = completed;
    data['start_time'] = startTime;
    data['finish_time'] = finishTime;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
