import "package:flutter/material.dart";
import "package:get/get.dart";
import "home_controller.dart";

class HomeScreen extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Center(
        child: Text("Home Screen"),
      ),
    );
  }
}
