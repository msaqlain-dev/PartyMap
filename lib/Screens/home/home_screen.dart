import "package:flutter/material.dart";
// import "package:flutter_map/flutter_map.dart";
import "package:get/get.dart";
// import "package:mapbox_gl/mapbox_gl.dart";
import "package:partymap/Screens/dashboard/dashboard_controller.dart";
import "package:partymap/res/colors/app_color.dart";
import "package:partymap/res/components/custom_text.dart";
import "package:partymap/res/navigators/routes_name.dart";
import "package:partymap/user_preference/user_preference_controller.dart";
import "package:partymap/utils/responsive_size_util.dart";
import "home_controller.dart";

class HomeScreen extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.secondaryColor,
      appBar: AppBar(
        backgroundColor: AppColor.secondaryColor,
        foregroundColor: AppColor.whiteColor,
        title: CustomText(
          text: "",
          color: AppColor.whiteColor,
          fontSize: ResponsiveSizeUtil.size16,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: AppColor.secondaryColor,
          border: const Border(
            bottom: BorderSide(color: AppColor.whiteColor),
          ),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(ResponsiveSizeUtil.size40),
            bottomRight: Radius.circular(ResponsiveSizeUtil.size40),
          ),
        ),
        child: Center(
          child: CustomText(
            text: "Map will be shown here",
            color: AppColor.whiteColor,
            fontSize: ResponsiveSizeUtil.size16,
            fontWeight: FontWeight.w600,
          ),
        ),
        // child: FlutterMap(
        //   options: MapOptions(
        //       // center: const new LatLatLng(-115.281497,36.346908),

        //       ),
        //   children: [],
        // ),
        // child: ElevatedButton(
        //   onPressed: () {
        //     UserPreference up = UserPreference();
        //     up.removeUser();
        //     Get.offAllNamed(RouteName.loginScreen);
        //   },
        //   style: ElevatedButton.styleFrom(
        //     backgroundColor: Colors.red,
        //   ),
        //   child: const Text(
        //     'Logout',
        //     style: TextStyle(color: Colors.white),
        //   ),
        // ),
      ),
    );
  }
}
