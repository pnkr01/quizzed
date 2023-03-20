class JoinedQuizModel {
  int? statusCode;
  String? message;
  Data? data;

  JoinedQuizModel({this.statusCode, this.message, this.data});

  JoinedQuizModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<Questions>? questions;
  QuizStats? quizStats;
  Data({this.questions, this.quizStats});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['questions'] != null) {
      questions = <Questions>[];
      json['questions'].forEach((v) {
        questions!.add(Questions.fromJson(v));
      });
    }
    quizStats = json['quizStats'] != null
        ? QuizStats.fromJson(json['quizStats'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (questions != null) {
      data['questions'] = questions!.map((v) => v.toJson()).toList();
    }
    if (quizStats != null) {
      data['quizStats'] = quizStats!.toJson();
    }
    return data;
  }
}

class Questions {
  String? sId;
  String? questionId;
  String? questionStr;
  List<String>? options;
  String? subject;
  String? createdBy;
  String? createdAt;
  String? updatedAt;

  Questions(
      {this.sId,
      this.questionId,
      this.questionStr,
      this.options,
      this.subject,
      this.createdBy,
      this.createdAt,
      this.updatedAt});

  Questions.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    questionId = json['question_id'];
    questionStr = json['question_str'];
    options = json['options'].cast<String>();
    subject = json['subject'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['question_id'] = questionId;
    data['question_str'] = questionStr;
    data['options'] = options;
    data['subject'] = subject;
    data['created_by'] = createdBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class QuizStats {
  String? sId;
  String? studentRegdNo;
  String? quizId;
  bool? completed;
  String? startTime;
  String? finishTime;
  List<void>? questionsAttemptedDetails;
  String? createdAt;
  String? updatedAt;

  QuizStats({
    this.sId,
    this.studentRegdNo,
    this.quizId,
    this.completed,
    this.startTime,
    this.finishTime,
    this.questionsAttemptedDetails,
    this.createdAt,
    this.updatedAt,
  });

  QuizStats.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    studentRegdNo = json['student_regdNo'];
    quizId = json['quiz_id'];
    completed = json['completed'];
    startTime = json['start_time'];
    finishTime = json['finish_time'];

    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
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
