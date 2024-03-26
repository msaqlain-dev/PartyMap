import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import "package:get/get.dart";
import "package:partymap/Screens/pin/pin_controller.dart";
import "package:partymap/res/colors/app_color.dart";
import "package:partymap/res/components/custom_text.dart";
import "package:partymap/res/components/round_button.dart";
import "package:partymap/res/navigators/routes_name.dart";
import "package:partymap/utils/responsive_size_util.dart";

class PinScreen extends GetView<PinController> {
  const PinScreen({super.key});

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
        actions: [
          IconButton(
            onPressed: () => Get.toNamed("/profile_screen"),
            icon: Icon(Icons.person_outline_rounded),
            iconSize: 24,
          )
        ],
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
          child: RoundButton(
            title: 'Login',
            buttonColor: AppColor.primaryColor,
            height: ResponsiveSizeUtil.scaleFactorHeight * 50,
            width: ResponsiveSizeUtil.scaleFactorWidth * 100,
            buttonRadius: 100,
            textColor: AppColor.whiteColor,
            fontSize: ResponsiveSizeUtil.size16,
            fontWeight: FontWeight.w700,
            onPress: () => Get.toNamed(RouteName.loginScreen),
          ),
        ),
      ),
    );
  }
}
