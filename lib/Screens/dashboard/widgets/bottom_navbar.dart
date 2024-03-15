import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:partymap/Screens/dashboard/dashboard_controller.dart';
import 'package:partymap/res/colors/app_color.dart';

class BottomNavBar extends StatelessWidget {
  final DashboardController controller;

  const BottomNavBar({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => BottomAppBar(
        color: AppColor.secondaryColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                controller.selectMarker(MarkerType.parties);
                controller.navigateToHome();
              },
              child: FaIcon(
                FontAwesomeIcons.champagneGlasses,
                color: controller.selectedMarkers.contains(MarkerType.parties)
                    ? Colors.pink
                    : AppColor.whiteColor,
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
            IconButton(
              icon: Icon(Icons.local_bar_rounded,
                  color: controller.selectedMarkers.contains(MarkerType.bars)
                      ? Colors.pink
                      : AppColor.whiteColor),
              onPressed: () {
                controller.selectMarker(MarkerType.bars);
                controller.navigateToHome();
              },
            ),
            IconButton(
              icon: Icon(Icons.local_dining_rounded,
                  color: controller.selectedMarkers
                          .contains(MarkerType.restaurants)
                      ? Colors.pink
                      : AppColor.whiteColor),
              onPressed: () {
                controller.selectMarker(MarkerType.restaurants);
                controller.navigateToHome();
              },
            ),
            IconButton(
              icon: Icon(
                Icons.message,
                color: controller.tabIndex.value == 1
                    ? Colors.pink
                    : AppColor.whiteColor,
              ),
              onPressed: controller.navigateToMessages,
            ),
            IconButton(
              icon: Icon(
                Icons.location_pin,
                // Icons.person_pin_circle_rounded,
                color: controller.tabIndex.value == 2
                    ? Colors.pink
                    : AppColor.whiteColor,
              ),
              onPressed: controller.navigateToPin,
            ),
          ],
        ),
      ),
    );
  }
}
