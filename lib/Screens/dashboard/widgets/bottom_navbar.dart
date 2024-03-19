import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:partymap/Screens/dashboard/dashboard_controller.dart';
import 'package:partymap/res/colors/app_color.dart';
import 'package:partymap/res/components/custom_text.dart';

class BottomNavBar extends StatelessWidget {
  final DashboardController controller;

  const BottomNavBar({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => BottomAppBar(
        color: AppColor.secondaryColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                controller.selectMarker(MarkerType.parties);
                controller.navigateToHome();
              },
              child: Column(
                children: [
                  FaIcon(
                    FontAwesomeIcons.champagneGlasses,
                    color:
                        controller.selectedMarkers.contains(MarkerType.parties)
                            ? AppColor.primaryColor
                            : AppColor.whiteColor,
                  ),
                  CustomText(
                    text: 'party',
                    color:
                        controller.selectedMarkers.contains(MarkerType.parties)
                            ? AppColor.primaryColor
                            : AppColor.whiteColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ],
              ),
            ),
            // IconButton(
            //   icon: Icon(Icons.party_mode,
            //       color: controller.selectedMarkers.contains(MarkerType.parties)
            //           ? Colors.pink
            //           : AppColor.whiteColor),
            //   onPressed: () {
            //     controller.selectMarker(MarkerType.parties);
            //     controller.navigateToHome();
            //   },
            // ),
            GestureDetector(
              onTap: () {
                controller.selectMarker(MarkerType.bars);
                controller.navigateToHome();
              },
              child: Column(
                children: [
                  // IconButton(
                  //   icon: Icon(
                  //     Icons.local_bar_rounded,
                  //     color:
                  //         controller.selectedMarkers.contains(MarkerType.bars)
                  //             ? Colors.pink
                  //             : AppColor.whiteColor,
                  //   ),
                  //   onPressed: () {
                  //     controller.selectMarker(MarkerType.bars);
                  //     controller.navigateToHome();
                  //   },
                  // ),
                  Icon(
                    Icons.local_bar_rounded,
                    color: controller.selectedMarkers.contains(MarkerType.bars)
                        ? AppColor.primaryColor
                        : AppColor.whiteColor,
                  ),
                  CustomText(
                    text: 'bar',
                    color: controller.selectedMarkers.contains(MarkerType.bars)
                        ? AppColor.primaryColor
                        : AppColor.whiteColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                controller.selectMarker(MarkerType.restaurants);
                controller.navigateToHome();
              },
              child: Column(
                children: [
                  // IconButton(
                  //   icon: Icon(
                  //     Icons.local_dining_rounded,
                  //     color: controller.selectedMarkers
                  //             .contains(MarkerType.restaurants)
                  //         ? Colors.pink
                  //         : AppColor.whiteColor,
                  //   ),
                  //   onPressed: () {
                  //     controller.selectMarker(MarkerType.restaurants);
                  //     controller.navigateToHome();
                  //   },
                  // ),
                  Icon(
                    Icons.local_dining_rounded,
                    color: controller.selectedMarkers
                            .contains(MarkerType.restaurants)
                        ? AppColor.primaryColor
                        : AppColor.whiteColor,
                  ),
                  CustomText(
                    text: 'restaurant',
                    color: controller.selectedMarkers
                            .contains(MarkerType.restaurants)
                        ? AppColor.primaryColor
                        : AppColor.whiteColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: controller.navigateToMessages,
              child: Column(
                children: [
                  // IconButton(
                  //   icon: Icon(
                  //     Icons.message,
                  //     color: controller.tabIndex.value == 1
                  //         ? Colors.pink
                  //         : AppColor.whiteColor,
                  //   ),
                  //   onPressed: controller.navigateToMessages,
                  // ),
                  Icon(
                    Icons.message,
                    color: controller.tabIndex.value == 1
                        ? AppColor.primaryColor
                        : AppColor.whiteColor,
                  ),
                  CustomText(
                    text: 'message',
                    color: controller.tabIndex.value == 1
                        ? AppColor.primaryColor
                        : AppColor.whiteColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: controller.navigateToPin,
              child: Column(
                children: [
                  // IconButton(
                  //   icon: Icon(
                  //     Icons.location_pin,
                  //     // Icons.person_pin_circle_rounded,
                  //     color: controller.tabIndex.value == 2
                  //         ? Colors.pink
                  //         : AppColor.whiteColor,
                  //   ),
                  //   onPressed: controller.navigateToPin,
                  // ),
                  Icon(
                    Icons.location_pin,
                    // Icons.person_pin_circle_rounded,
                    color: controller.tabIndex.value == 2
                        ? AppColor.primaryColor
                        : AppColor.whiteColor,
                  ),
                  CustomText(
                    text: 'pin',
                    color: controller.tabIndex.value == 2
                        ? AppColor.primaryColor
                        : AppColor.whiteColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
