import 'package:get/get.dart';
import 'package:partymap/Screens/splash_screen.dart';
import 'package:partymap/res/navigators/routes_name.dart';

class AppRoutes {
  static appRoutes() => [
        GetPage(
          name: RouteName.splashScreen,
          page: () => SplashScreen(),
          transitionDuration: const Duration(milliseconds: 250),
          transition: Transition.leftToRightWithFade,
        )
      ];
}
