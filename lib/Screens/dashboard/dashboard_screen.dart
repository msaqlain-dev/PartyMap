import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:partymap/Screens/home/home_screen.dart";
import "package:partymap/Screens/message/message_screen.dart";
import "package:partymap/Screens/profile/profile_screen.dart";
import "dashboard_controller.dart";

class DashboardScreen extends GetView<DashboardController> {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Dashboard"),
          ),
          body: SafeArea(
            child: IndexedStack(
              index: controller.tabIndex.value,
              children: [
                HomeScreen(),
                MessageScreen(),
                ProfileScreen(),
              ],
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            unselectedItemColor: Colors.grey,
            selectedItemColor: Colors.pink,
            onTap: controller.changeTabIndex,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            currentIndex: controller.tabIndex.value,
            items: [
              _bottomNavItems(Icons.home_rounded, "Parties"),
              _bottomNavItems(Icons.bar_chart, "Bars"),
              _bottomNavItems(Icons.restaurant_menu_rounded, "Restaurants"),
              _bottomNavItems(Icons.message, "Messages"),
              _bottomNavItems(Icons.person, "Profile"),
            ],
          ),
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
