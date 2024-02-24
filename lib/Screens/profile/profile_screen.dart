import "package:flutter/material.dart";
import "package:get/get.dart";
import "profile_controller.dart";

class ProfileScreen extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: Center(
        child: Text("Profile Screen"),
      ),
    );
  }
}
