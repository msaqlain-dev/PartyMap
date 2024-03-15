import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:partymap/res/colors/app_color.dart";
import "package:partymap/res/components/custom_text.dart";
import "package:partymap/utils/responsive_size_util.dart";
import "message_controller.dart";

class MessageScreen extends GetView<MessageController> {
  const MessageScreen({super.key});

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
          child: CustomText(
            text: "Messages will be shown here",
            color: AppColor.whiteColor,
            fontSize: ResponsiveSizeUtil.size16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
