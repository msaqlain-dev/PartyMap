import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:partymap/Screens/dashboard/widgets/bottom_navbar.dart";
import "package:partymap/Screens/home/home_screen.dart";
import "package:partymap/Screens/message/message_screen.dart";
import "package:partymap/Screens/pin/pin_screen.dart";
import "package:partymap/Screens/profile/profile_screen.dart";
import "package:partymap/res/colors/app_color.dart";
import "dashboard_controller.dart";

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
      builder: (controller) {
        return Scaffold(
          body: SafeArea(
            child: IndexedStack(
              index: controller.tabIndex.value,
              children: [
                HomeScreen(),
                MessageScreen(),
                PinScreen(),
              ],
            ),
          ),
          bottomNavigationBar: BottomNavBar(
            controller: controller,
          ),
          // BottomNavigationBar(
          //   items: [
          //     _bottomNavItems(Icons.party_mode, 'partys'),
          //     // _bottomNavItems(Icons.local_bar, 'bars'),
          //     // _bottomNavItems(Icons.restaurant, 'restaurants'),
          //     _bottomNavItems(Icons.message, 'messages'),
          //     _bottomNavItems(Icons.pin_drop, 'Pin'),
          //     _bottomNavItems(Icons.person, 'Pin'),
          //   ],
          //   unselectedItemColor: AppColor.grayColor,
          //   selectedItemColor: AppColor.primaryColor,
          //   showSelectedLabels: true,
          //   currentIndex: controller.tabIndex.value,
          //   onTap: controller.changeTabIndex,
          // ),
        );
      },
    );
  }

  _bottomNavItems(IconData icon, String label) {
    return BottomNavigationBarItem(
      icon: Icon(icon),
      label: label,
    );
  }
}
