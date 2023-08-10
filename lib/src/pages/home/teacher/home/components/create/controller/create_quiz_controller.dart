import 'dart:convert';
import 'package:http/http.dart' as https;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizzed/src/api/points.dart';
import 'package:quizzed/src/db/local/local_db.dart';
import 'package:quizzed/src/global/global.dart';
import 'package:quizzed/src/global/shared.dart';
import 'package:quizzed/src/pages/auth/components/login/common_auth_login_screen.dart';
import 'package:quizzed/theme/app_color.dart';
import 'package:quizzed/theme/gradient_theme.dart';
import '../../../../../../../../utils/errordialog.dart';
import '../../quiz_add/quiz_confirm_view_screen.dart';

class CreateQuizController extends GetxController {
  RxString selectedDuration = 'Select Duration'.obs;
  RxBool isSelectedDuration = false.obs;
  RxInt selectedMin = 0.obs;
  RxString selectedSection = 'general'.obs;
  RxString selectedSemester = '1 Sem'.obs;
  String code = '';

  late final TextEditingController title = TextEditingController();
  late final TextEditingController description = TextEditingController();
  late final TextEditingController section = TextEditingController();
  late final TextEditingController semester = TextEditingController();
  late final TextEditingController totalQs = TextEditingController();
  late final TextEditingController marksPerQs = TextEditingController();
  late final TextEditingController duration = TextEditingController();
  late final TextEditingController search = TextEditingController();

  final FocusNode focusNodeTitle = FocusNode();
  final FocusNode focusNodesection = FocusNode();
  final FocusNode focusNodeDescription = FocusNode();
  final FocusNode focusNodesemester = FocusNode();
  final FocusNode focusNodeDtotalQs = FocusNode();
  final FocusNode focusNodemarksPerQs = FocusNode();
  final FocusNode focusNodeduration = FocusNode();

  RxBool isFetching = true.obs;
  RxBool isCreating = true.obs;

  Map<String, String> subject = {
    "Discrete Mathematics": "CSE1002",
    "Calculus A": "MTH1101",
    "Introduction to Computer Programming": "CSE1001",
    "University Physics : Mechanics": "PHY1001",
    "Communication and Critical Thinking": "HSS1010",
    "Data Structure and Algorithm": "CSE2001",
    "Introductory Graph Theory": "CSE1004",
    "Calculus B": "MTH2101",
    "University Physics: Electricity and Magnetism": "PHY2001",
    "Principle of Microeconomics ": "HSS1021",
    "Computer Science Workshop1 ": "CSE2141",
    "Digital Logic Design": "EET1211",
    "Algorithm Design 1": "CSE3131",
    "Probability and Statistics": "MTH2002",
    "Principle of Macroeconomics": "HSS2021",
    "Computer Science Workshop 2": "CSE3141",
    "Computer Organisation and Architecture": "EET2211",
    "Algorithm Design 2": "CSE4131",
    "Applied Linear Algebra": "MTH3003",
    "Universal Human Values": "GEN1972",
    "Operating Systems Workshop": "CSE3541",
    "Design of Operating System": "CSE4049",
    "Computer Networking": "CSE3034",
    "Programming in Python": "CSE3142",
    "Introduction to the Theory of Computation": "CSE3731",
    "Intermediate Discrete Mathematics": "CSE2733",
    "Computer Networking Workshop": "CSE4541",
    "Introduction to Databases": "CSE3151",
    "Cryptography and Network Security": "CSE3035",
    "Introduction to Data Science using Python": "CSE3054",
    "Study and Design of Compilers": "CSE4732",
    "Introduction to Blockchain": "CSE3734",
    "Internet of Things Projects using Python": "CSE4110",
    "Topics in Environmental Studies": "HSS3011",
    "Senior Design Project-CSE4101": "CSE4101",
    "Web Technology Workshop 1": "CSE4947",
    "Problem Solving and Problem Design using C": "CSE3942",
    "Web Technology Workshop 2": "CSE4948",
    "Web Application Development": "CSE4937",
    "Web Development Project": "CSE4103",
    "Civil Engineering Workshop Practice": "CVL1013",
    "Computer Aided Drawing for Civil Engineering": "CVL1114",
    "Engineering Mechanics": "CVL1011",
    "Materials. Materials Testing and Evaluation": "CVL2013",
    "Introductory Solid Mechanics-CVL2211": "CVL2211",
    "Surveying and Geomatics Engineering": "CVL1209",
    "Computer Aided Analysis for Civil Engineering": "CVL1115",
    "Partial Differential Equation": "MTH3009",
    "Structural Analysis": "CVL3011",
    "Transportation Engineering Design": "CVL3171",
    "Introduction to Geotechnical Engineering": "CVL3231",
    "Fluid Mechanics": "MEL3211",
    "Numerical Methods": "MTH4002",
    "Water Resource Engineering": "CVL3241",
    "Reinforced COncrete Design": "CVL4121",
    "Foundation Engineering": "CVL4232",
    "Construction Management Fundamentals": "CVL3162",
    "Principle of Environmental Engineering": "CVL3054",
    "Steel Structures Design Project": "CVL4123",
    "Engineering Drawing and Workshop Practice": "MEL1104",
    "Computer Aided Drawing and Manufacturing": "MEL1105",
    "Introductory Thermodynamics": "MEL2011",
    "Engineering Mechanics: Statistics and Dynamics": "MEL1012",
    "Applied Thermodynamics": "MEL4013",
    "Introductory Solid Mechanics-MEL2021": "MEL2021",
    "Complex Variables and Vibration Theory": "MEL4022",
    "Design and Dynamics 1": "MEL3031",
    "Advanced Solid Mechancis": "MEL4026",
    "Mechanical Engineering Materials": "MEL3043",
    "Electrical and Electronics Workshop": "EET1100",
    "Embeeded Systems Project using Ardunio": "EET4109",
    "Heat Transfer": "MEL3212",
    "Design and Dynamics 2": "MEL3032",
    "Integrated Design and Manufacturing Project": "MEL3101",
    "Operations Research and Production Engineering": "MLE4038",
    "Senior Design Project-MEL4101": "MEL4101",
    "Senior Design Project-CVL4101": "CVL4101",
    "Logic Design": "EET1021",
    "Introduction to Electrical and Electronic Circuits": "EET1102",
    "Microelectronic Devices and Circuits": "EET2131",
    "Circuit Theory": "EET2111",
    "Signals and Systems": "EET2051",
    "Design with Analog Integrated Circuits": "EET3131",
    "Electromagnetic Waves I": "EET3041",
    "Communication Systems I": "EET3061",
    "Digital Signal Processing": "EET3051",
    "Communication Systems II": "EET3062",
    "Control Systems": "EET3071",
    "Electromagnetic Waves II": "EET4041",
    "Electrical and Electronic Measurments": "EET3001",
    "Internet of Things Project using Raspberry Pi": "EET4110",
    "Elements of Information Theory": "EET4564",
    "Senior Design Project-EET4101": "EET4101",
    "Electrical Machines 1": "EET3081",
    "Electromagnetic Field Theory": "EET3043",
    "Power System Analysis and Design 1": "EET3083",
    "Power Electronics, Devices and Circuits": "EET3113",
    "Electrical Machines 2": "EET3082",
    "Power System Protection: Analysis and Design ": "EET4089",
    "Power System Analysis and Design 2": "EET3084",
    "Mathematical Foundation for Computer Science": "MA501T",
    "Advanced Computer Architecture": "CS502T",
    "Advanced Design and Analysis of Algorithm": "CS501T",
    "Algorithm Lab": "CS501P",
    "Simulation Lab": "CS502P",
    "Advanced Operating System": "CS507T",
    "Advanced Computer Network": "CS059T",
    "Operating System Lab": "CS503P",
    "Computational Lab": "CS504P",
    "Seminar-I-CS505P": "CS505P",
    "Comprehensive Viva-I": "CS506P",
    "Database Engineering": "CS601T",
    "Project-I-CS601P": "CS601P",
    "Seminar-II-CS602": "CS602",
    "Comprehensive Viva-II-CS603P": "CS603P",
    "Project-II": "CS604P",
    "Advanced Structural Analysis": "CE501T",
    "Theory of Elasticity & Plasticity": "CE502T",
    "Advanced Design of COncrete Structures": "CE503T",
    "COncrete/ Structural Lab": "CE501P",
    "Structural Dynamics": "CE507T",
    "Theeory of Plates and Shells": "CE508T",
    "Advanced Steel Structures": "CE509T",
    "Design & Detailing of Structures": "CE503P",
    "Mini Design Project": "CE504P",
    "Finite Element Method": "CE601T",
    "Project-I-CE601P": "CE601P",
    "Comprehensive Viva-Voce-II": "CE603P",
    "Project-II-CE604P": "CE604P",
    "Power Electronics Converter": "EE501T",
    "Control and Operation Of Electronic Power Systems": "EE522T",
    "Power Quality": "EE523T",
    "Power System Lab": "EE521P",
    "Power Electronics Lab": "EE501P",
    "Advanced Power Electronics Converter": "EE525T",
    "Modeling and Simulation of Power Electronic Devices": "EE521T",
    "Electric Drives": "EE504T",
    "Power System Simulation Lab": "EE523P",
    "Drives Lab": "EE504P",
    "Seminar-I-EE525P": "EE525P",
    "Comprehensive Viva-I-EE526": "EE526",
    "HVDC Power Transmission and FACTS": "EE601T",
    "Project-I-EE621P": "EE621P",
    "Comprehensive Viva-II": "EE623P",
    "Project-II-EE624P": "EE624P",
    "Department Core-I": "EC561T",
    "Department Core-II": "EC564T",
    "Department Core-III": "EC562T",
    "Core Lab-I-EC561P": "EC561P",
    "Department Core-IV": "EC563T",
    "Department Core-V": "ECG5GT",
    "Core Lab-I-EC563P": "EC563P",
    "Department Core-VI": "EC661T",
    "Project-I-EC661P": "EC661P",
    "Seminar-II-EC662P": "EC662P",
    "Comprehensive Viva Voce-II-EC663P": "EC663P",
    "Project and Dessertation": "EC664P",
    "Advanced Fluid Mechancis": "ME501T",
    "Advanced Engineering Thermodynamics": "ME502T",
    "Conduction and Radiation Heat Transfer": "ME503T",
    "Experimental Methods in Thermal Engineering": "ME501P",
    "Computational Fluid Dynamics and Heat Transfer": "ME508T",
    "Convective Heat and Mass Transfer": "ME509T",
    "Computational Fluid Dynamics Lab": "ME503P",
    "IC Engine & Renewable Energy Lab": "ME504P",
    "Seminar-I-ME505P": "ME505P",
    "Comprehensive Viva-I-ME506P": "ME506P",
    "Heat Exchanger Analysis & Design": "ME601T",
    "Project-I-ME601P": "ME601P",
    "Seminar-II-ME602P": "ME602P",
    "Comprehensive Viva Voce-II-ME603P": "ME603P",
    "Project-II-ME604P": "ME604P"
  };
  List showSubjectList = [];
  @override
  void onInit() {
    fillMySubject();
    super.onInit();
  }

  fillMySubject() {
    subject.forEach((key, value) {
      showSubjectList.add(key);
    });
    isFetching.value = false;
  }

  handleSemesterChanged(String value) {
    selectedSemester.value = value;
  }

  navigateToQuizAdditionPage() {}

  String? getEquivalentCode(String key) {
    quizDebugPrint(subject.toString());
    quizDebugPrint(subject[key]);
    return subject[key]!;
  }

  handleSectionChanged(String value) {
    selectedSection.value = value;
  }

  checkThisCreateQuizTap() {
    if (title.value.text.isNotEmpty &&
        description.value.text.isNotEmpty &&
        section.value.text.isNotEmpty &&
        semester.value.text.isNotEmpty &&
        totalQs.value.text.isNotEmpty &&
        marksPerQs.value.text.isNotEmpty &&
        search.value.text.isNotEmpty) {
      quizDebugPrint('create quiz is in process =>>>>>>>>>>>>>>');

      try {
        if (section.value.text.contains('-')) {
          quizDebugPrint('261');
          quizDebugPrint('eq is ${subject[search.value.text]!}');
          if (selectedMin.value != 0) {
            quizDebugPrint('263');
            startProcessingCreateQuiz(
              title.value.text.trimRight(),
              description.value.text.trimRight(),
              getEquivalentCode(search.value.text)!,
              selectedSection.value == 'general'
                  ? "general"
                  : section.value.text.toUpperCase().trimRight(),
              semester.value.text.trimRight(),
              totalQs.value.text.trimRight(),
              marksPerQs.value.text.trimRight(),
              selectedMin.value.toString(),
            );
          } else {
            isCreating.value = true;
            showSnackBar(
              'Please choose Quiz duration to continue',
              redColor,
              whiteColor,
            );
          }
        } else {
          isCreating.value = true;
          showSnackBar(
            'Enter correct section format. e.g CSE-K',
            redColor,
            whiteColor,
          );
        }
      } catch (e) {
        isCreating.value = true;
        Get.back();
        quizDebugPrint('ERROR');
        showSnackBar(e.toString(), redColor, whiteColor);
      }
    } else {
      isCreating.value = true;
      showDialog(
          context: Get.context!,
          builder: ((context) => const ErrorDialog(
              color: kTeacherPrimaryColor, message: 'fill all blanks')));
    }
  }

  //-------------------------------------------------//

  startProcessingCreateQuiz(
      String title,
      String desc,
      String sub,
      String section,
      String semester,
      String tQS,
      String eachQsmarks,
      String duration) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Cookie': 'Authentication=${sharedPreferences.getString('Tcookie')}'
    };
    final msg = json.encode({
      "title": title,
      "description": desc,
      "subject": sub,
      "section": section,
      "semester": int.parse(semester),
      "total_questions": int.parse(tQS),
      "per_question_marks": int.parse(eachQsmarks),
      "duration": int.parse(duration)
    });
    quizDebugPrint('start hitting create api ==============================>');

    try {
      var response = await https.post(
        Uri.parse(ApiConfig.getEndPointsNextUrl('quiz/create')),
        headers: headers,
        body: msg,
      );
      var myjson = await jsonDecode(response.body);
      quizDebugPrint(myjson);
      if (myjson["message"] == "Unauthorized") {
        quizDebugPrint(
            'Teacher JWT Expired ====> Sending to login screen to login again');
        quizDebugPrint('clearning local DB========================>');
        LocalDB.removeLoacalDb();
        Get.offAllNamed(CommmonAuthLogInRoute.routeName);
        showSnackBar('Your session expired :)', greenColor, whiteColor);
      } else if (myjson["quiz_id"] != null) {
        quizDebugPrint(myjson.toString());
        quizDebugPrint(
            'sending to add question page---------------------------------------->');
        isCreating.value = true;
        Get.offNamed(
          QuizAdditionScreen.routeName,
          arguments: [
            {"subject": search.value.text.trimRight()},
            {"quiz_id": myjson["quiz_id"]},
            {"conducted_by": myjson["conducted_by"]},
            {"title": myjson["title"]},
            {"section": myjson["section"]},
            {"semester": myjson["semester"]},
            {"duration": myjson["duration"]},
            {"created_at": myjson["created_at"]},
            {"updated_at": myjson["updated_at"]},
            {"status": myjson["status"]},
            {"description": myjson["description"]},
            {"total_questions": myjson["total_questions"]},
            {"per_question_marks": myjson["per_question_marks"]},
            {"subjectCode": myjson["subject"]},
          ],
        );
      } else {
        isCreating.value = true;
        showSnackBar(myjson["message"], redColor, whiteColor);
      }
    } on FormatException {
      quizDebugPrint('inside format exception');
      throw Exception("Enter integer value to Semester");
    } catch (e) {
      isCreating.value = true;
      quizDebugPrint('inside catch');
      showSnackBar(e.toString(), redColor, whiteColor);
    }
  }

  //send to krishna subject[key]
}
