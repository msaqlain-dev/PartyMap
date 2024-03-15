import 'package:get/get.dart';
import 'package:partymap/Screens/dashboard/dashboard_controller.dart';
import 'package:partymap/Screens/dashboard/dashboard_screen.dart';
import 'package:partymap/Screens/home/home_screen.dart';
import 'package:partymap/Screens/login_screen/login_screen.dart';
import 'package:partymap/Screens/pin/pin_screen.dart';
import 'package:partymap/Screens/profile/profile_screen.dart';
import 'package:partymap/Screens/signup_screen/signup_screen.dart';
import 'package:partymap/Screens/splash_screen/splash_screen.dart';
import 'package:partymap/res/navigators/routes_name.dart';

class AppRoutes {
  static appRoutes() => [
        GetPage(
          name: RouteName.splashScreen,
          page: () => const SplashScreen(),
          transitionDuration: const Duration(milliseconds: 250),
          transition: Transition.noTransition,
        ),
        GetPage(
          name: RouteName.dashboardScreen,
          page: () {
            Get.put(DashboardController()); // Instantiate DashboardController
            return const DashboardScreen();
          },
          transitionDuration: const Duration(milliseconds: 250),
          transition: Transition.noTransition,
        ),
        GetPage(
          name: RouteName.loginScreen,
          page: () => LoginScreen(),
          transitionDuration: const Duration(milliseconds: 250),
          transition: Transition.noTransition,
        ),
        GetPage(
          name: RouteName.signupScreen,
          page: () => SignupScreen(),
          transitionDuration: const Duration(milliseconds: 250),
          transition: Transition.noTransition,
        ),
        GetPage(
          name: RouteName.homeScreen,
          page: () => HomeScreen(),
          transitionDuration: const Duration(milliseconds: 250),
          transition: Transition.noTransition,
        ),
        GetPage(
          name: RouteName.profileScreen,
          page: () => ProfileScreen(),
          transitionDuration: const Duration(milliseconds: 250),
          transition: Transition.noTransition,
        ),
      ];
}
