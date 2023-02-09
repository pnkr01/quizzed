import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:quiz/src/pages/auth/common/components/login/common_auth_login_screen.dart';
import 'package:quiz/src/pages/auth/common/components/signup/common_auth_sign_up_screen.dart';
import 'package:quiz/src/pages/splash/splash.dart';

class AppRoute {
  static List<GetPage> pages() => [
        GetPage(name: SplashScreen.routeName, page: () => const SplashScreen()),
        GetPage(
            name: CommmonAuthLogInRoute.routeName,
            page: () => const CommmonAuthLogInRoute()),
        GetPage(
            name: CommonAuthSignUpScreen.routeName,
            page: () => const CommonAuthSignUpScreen()),
      ];
}
