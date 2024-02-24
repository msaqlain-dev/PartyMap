import "package:flutter/material.dart";
import "package:get/get.dart";
import "message_controller.dart";

class MessageScreen extends GetView<MessageController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Message"),
      ),
      body: Center(
        child: Text("Message Screen"),
      ),
    );
  }
}
