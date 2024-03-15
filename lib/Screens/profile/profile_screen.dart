import "package:flutter/material.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import "package:get/get.dart";
import "package:partymap/res/colors/app_color.dart";
import "package:partymap/res/components/custom_text.dart";
import "package:partymap/utils/responsive_size_util.dart";
import "profile_controller.dart";

class ProfileScreen extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.secondaryColor,
      appBar: AppBar(
        title: CustomText(
          text: "",
          color: AppColor.whiteColor,
          fontSize: ResponsiveSizeUtil.size16,
          fontWeight: FontWeight.w600,
        ),
        backgroundColor: AppColor.secondaryColor,
        foregroundColor: AppColor.whiteColor,
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
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            ResponsiveSizeUtil.scaleFactorWidth * 20,
            ResponsiveSizeUtil.scaleFactorHeight * 20,
            ResponsiveSizeUtil.scaleFactorHeight * 20,
            ResponsiveSizeUtil.scaleFactorWidth * 20,
          ),
          child: Column(
            children: [
              Center(
                child: CircleAvatar(
                  backgroundColor: AppColor.whiteColor,
                  radius: ResponsiveSizeUtil.size80,
                  child: const Icon(
                    Icons.person,
                    color: AppColor.blackColor,
                    size: 80,
                  ),
                ),
              ),
              SizedBox(
                height: ResponsiveSizeUtil.scaleFactorHeight * 30,
              ),
              Row(
                children: [
                  const Icon(
                    Icons.person_outline_rounded,
                    color: AppColor.whiteColor,
                    size: 24,
                  ),
                  SizedBox(
                    width: ResponsiveSizeUtil.scaleFactorWidth * 20,
                  ),
                  CustomText(
                    text: "Muhammad Saqlain",
                    color: AppColor.whiteColor,
                    fontSize: ResponsiveSizeUtil.size16,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
              const Divider(
                color: AppColor.whiteColor,
                thickness: 1,
              ),
              SizedBox(
                height: ResponsiveSizeUtil.scaleFactorHeight * 30,
              ),
              Row(
                children: [
                  const Icon(
                    Icons.email_outlined,
                    color: AppColor.whiteColor,
                    size: 24,
                  ),
                  SizedBox(
                    width: ResponsiveSizeUtil.scaleFactorWidth * 20,
                  ),
                  CustomText(
                    text: "muhammadsaqlain@gmail.com",
                    color: AppColor.whiteColor,
                    fontSize: ResponsiveSizeUtil.size16,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
              const Divider(
                color: AppColor.whiteColor,
                thickness: 1,
              ),
              SizedBox(
                height: ResponsiveSizeUtil.scaleFactorHeight * 30,
              ),
              Row(
                children: [
                  const Icon(
                    Icons.phone_in_talk_rounded,
                    color: AppColor.whiteColor,
                    size: 24,
                  ),
                  SizedBox(
                    width: ResponsiveSizeUtil.scaleFactorWidth * 20,
                  ),
                  CustomText(
                    text: "+923153438373",
                    color: AppColor.whiteColor,
                    fontSize: ResponsiveSizeUtil.size16,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
              const Divider(
                color: AppColor.whiteColor,
                thickness: 1,
              ),
              SizedBox(
                height: ResponsiveSizeUtil.scaleFactorHeight * 30,
              ),
              Row(
                children: [
                  const FaIcon(
                    FontAwesomeIcons.instagram,
                    color: AppColor.whiteColor,
                    size: 24,
                  ),
                  SizedBox(
                    width: ResponsiveSizeUtil.scaleFactorWidth * 20,
                  ),
                  CustomText(
                    text: "Instagram",
                    color: AppColor.whiteColor,
                    fontSize: ResponsiveSizeUtil.size16,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
              const Divider(
                color: AppColor.whiteColor,
                thickness: 1,
              ),
              SizedBox(
                height: ResponsiveSizeUtil.scaleFactorHeight * 30,
              ),
              Row(
                children: [
                  const FaIcon(
                    FontAwesomeIcons.snapchat,
                    color: AppColor.whiteColor,
                    size: 24,
                  ),
                  SizedBox(
                    width: ResponsiveSizeUtil.scaleFactorWidth * 20,
                  ),
                  CustomText(
                    text: "Snap",
                    color: AppColor.whiteColor,
                    fontSize: ResponsiveSizeUtil.size16,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
              const Divider(
                color: AppColor.whiteColor,
                thickness: 1,
              ),
              SizedBox(
                height: ResponsiveSizeUtil.scaleFactorHeight * 30,
              ),
              Row(
                children: [
                  const Icon(
                    Icons.settings_outlined,
                    color: AppColor.whiteColor,
                    size: 24,
                  ),
                  SizedBox(
                    width: ResponsiveSizeUtil.scaleFactorWidth * 20,
                  ),
                  CustomText(
                    text: "Setting",
                    color: AppColor.whiteColor,
                    fontSize: ResponsiveSizeUtil.size16,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
              const Divider(
                color: AppColor.whiteColor,
                thickness: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
