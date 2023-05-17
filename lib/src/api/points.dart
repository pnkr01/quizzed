bool isProd = false;

class ApiConfig {
  String kAuthPort = '8001';
  String kQuizPort = '8000';
  //auth req routes starts
  String klogin = 'auth/login';
  String kUserReg = 'auth/users';
  String kTeacherReg = 'auth/teachers';
  String kVerifyTeachers = 'auth/teachers/verify';
  String kReqRegdNo = 'auth/request-regd-no';
  String kLogOut = 'auth/logout';
  //auth req routes ends

  //host selection

  //quiz req route starts here
  String createNewQuiz = 'quiz/create';
  String createNewQuestion = 'quiz/questions';
  String addQuestionToQuiz = 'quiz/add-question/';

  static getEndPointsUrl(String endPoint) {
    return isProd
        ? "http://k8s-default-quizzedi-13e146b328-660271321.ap-south-1.elb.amazonaws.com/$endPoint"
        : "http://10.0.2.2:8001/$endPoint";
  }

  static getEndPointsNextUrl(String endPoint) {
    return isProd
        ? "http://k8s-default-quizzedi-13e146b328-660271321.ap-south-1.elb.amazonaws.com/$endPoint"
        : "http://10.0.2.2:8000/$endPoint";
  }
}
