class QuestionOption {
  final String questionID;
  final int optionValue; // Change variable name to optionValue

  QuestionOption({required this.questionID, required this.optionValue});

  Map<String, dynamic> toMap() {
    return {
      'questionID': questionID,
      'optionValue': optionValue, // Change variable name to optionValue
    };
  }

  factory QuestionOption.fromMap(Map<String, dynamic> map) {
    return QuestionOption(
      questionID: map['questionID'],
      optionValue: map['optionValue'], // Change variable name to optionValue
    );
  }
}
