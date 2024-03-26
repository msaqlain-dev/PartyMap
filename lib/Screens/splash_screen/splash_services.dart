import 'dart:async';

import 'package:get/get.dart';
import 'package:partymap/res/navigators/routes_name.dart';
import 'package:partymap/user_preference/user_preference_controller.dart';

class SplashServices {
  UserPreference userPreference = UserPreference();

  void isLogin() {
    userPreference.getUser().then(
      (value) {
        print(value.token);
        print(value.isLogin);
        // if (value.isLogin == false || value.isLogin.toString() == 'null') {
        //   Timer(
        //     const Duration(seconds: 3),
        //     () {
        //       Get.toNamed(RouteName.loginScreen);
        //     },
        //   );
        // } else {
        //   Timer(
        //     const Duration(seconds: 3),
        //     () {
        //       Get.toNamed(RouteName.dashboardScreen);
        //     },
        //   );
        // }
        Timer(
          const Duration(seconds: 3),
          () {
            Get.toNamed(RouteName.dashboardScreen);
          },
        );
      },
    );
  }
}
