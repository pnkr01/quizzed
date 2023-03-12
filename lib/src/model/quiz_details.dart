class QuizDeatilsModel {
  String? sId;
  String? questionId;
  String? questionStr;
  String? questionImg;
  List<String>? options;
  int? correctOption;
  String? subject;
  String? createdBy;
  String? createdAt;
  String? updatedAt;

  QuizDeatilsModel(
      {this.sId,
      this.questionId,
      this.questionStr,
      this.questionImg,
      this.options,
      this.correctOption,
      this.subject,
      this.createdBy,
      this.createdAt,
      this.updatedAt});

  QuizDeatilsModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    questionId = json['question_id'];
    questionStr = json['question_str'];
    questionImg = json['question_img'];
    options = json['options'].cast<String>();
    correctOption = json['correct_option'];
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
    data['question_img'] = questionImg;
    data['options'] = options;
    data['correct_option'] = correctOption;
    data['subject'] = subject;
    data['created_by'] = createdBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
