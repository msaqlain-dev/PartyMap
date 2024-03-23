import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partymap/Screens/home/home_controller.dart';
import 'package:partymap/res/colors/app_color.dart';
import 'package:partymap/res/components/custom_text.dart';

class MapTypeDropdown extends StatelessWidget {
  const MapTypeDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) => Container(
        decoration: BoxDecoration(
            // border: Border.all(color: Colors.white),
            color: AppColor.lightColor,
            borderRadius: BorderRadius.circular(10)),
        child: DropdownButton<String>(
          elevation: 0,
          isDense: true,
          underline: Container(),
          items: ["Dark", "Satellite"].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: CustomText(
                text: '   $value',
                fontSize: 16,
                fontWeight: FontWeight.w800,
              ),
            );
          }).toList(),
          onChanged: (value) {
            controller.updateMapType(value!);
          },
          value: controller.mapType.value,
        ),
      ),
    );
  }
}
