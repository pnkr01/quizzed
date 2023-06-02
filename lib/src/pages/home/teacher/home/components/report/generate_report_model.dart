class GenerateReport {
  int? statusCode;
  String? message;
  List<Data>? data;

  GenerateReport({this.statusCode, this.message, this.data});

  GenerateReport.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];

    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }
}

class Data {
  String? studentRegdNo;
  int? attemptedQuestionIds;
  int? correctQuestionIds;
  int? incorrectQuestionIds;
  int? unattemptedQuestionIds;

  Data(
      {this.studentRegdNo,
      this.attemptedQuestionIds,
      this.correctQuestionIds,
      this.incorrectQuestionIds,
      this.unattemptedQuestionIds});

  Data.fromJson(Map<String, dynamic> json) {
    studentRegdNo = json['student_regdNo'];
    attemptedQuestionIds = json['attemptedQuestionIds'] != null
        ? json['attemptedQuestionIds'].length
        : 0;
    correctQuestionIds = json['correctQuestionIds'] != null
        ? json['correctQuestionIds'].length
        : 0;
    incorrectQuestionIds = json['incorrectQuestionIds'] != null
        ? json['incorrectQuestionIds'].length
        : 0;
    unattemptedQuestionIds = json['unattemptedQuestionIds'] != null
        ? json['unattemptedQuestionIds'].length
        : 0;
  }
}
