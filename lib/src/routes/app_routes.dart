import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:quiz/src/pages/auth/components/login/common_auth_login_screen.dart';
import 'package:quiz/src/pages/auth/components/signup/common_auth_sign_up_screen.dart';
import 'package:quiz/src/pages/auth/components/otp/otp_screen.dart';
import 'package:quiz/src/pages/home/student/drawer/components/notification/notification_view.dart';
import 'package:quiz/src/pages/home/student/drawer/components/p&h/privacy_help.dart';
import 'package:quiz/src/pages/home/student/home/student_home.dart';
import 'package:quiz/src/pages/home/teacher/home/components/create/create_quiz.dart';
import 'package:quiz/src/pages/home/teacher/home/components/quiz_add/quiz_confirm_view_screen.dart';
import 'package:quiz/src/pages/home/teacher/teacher_home.dart';
import 'package:quiz/src/pages/splash/splash.dart';

import '../pages/home/student/home/components/joinQuiz/join_quiz_view.dart';
import '../pages/home/student/home/components/result/quiz_result_view.dart';
import '../pages/home/teacher/home/components/quiz_add/quiz_additon_view_screen.dart';

class AppRoute {
  static List<GetPage> pages() => [
        GetPage(name: SplashScreen.routeName, page: () => const SplashScreen()),
        GetPage(
            name: CommmonAuthLogInRoute.routeName,
            page: () => const CommmonAuthLogInRoute()),
        GetPage(
            name: CommonAuthSignUpScreen.routeName,
            page: () => const CommonAuthSignUpScreen()),
        GetPage(name: OTPScreen.routeName, page: () => const OTPScreen()),
        GetPage(name: TeacherHome.routeName, page: () => const TeacherHome()),
        GetPage(name: StudentHome.routeName, page: () => const StudentHome()),
        GetPage(name: JoinQuizView.routeName, page: () => const JoinQuizView()),
        GetPage(
            name: QuizResultView.routeName, page: () => const QuizResultView()),
        GetPage(
            name: PrivacyAndHelp.routeName, page: () => const PrivacyAndHelp()),
        GetPage(
            name: NotificationView.routeName,
            page: () => const NotificationView()),
        GetPage(name: CreateQuiz.routeName, page: () => const CreateQuiz()),
        GetPage(
            name: QuizAdditionScreen.routeName,
            page: () => const QuizAdditionScreen()),
        GetPage(
            name: QuizAdditionView.routeName,
            page: () => const QuizAdditionView()),
      ];
}
