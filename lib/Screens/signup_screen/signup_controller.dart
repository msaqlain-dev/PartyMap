import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:partymap/repository/login_repository/login_repository.dart';
import 'package:partymap/utils/utils.dart';

class SignupController extends GetxController {
  final _api = LoginRepository();

  RxBool loading = false.obs;

  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;
  final confirmPasswordController = TextEditingController().obs;

  final emailFocusNode = FocusNode().obs;
  final passwordFocusNode = FocusNode().obs;
  final confirmPasswordFocusNode = FocusNode().obs;

  void signupApi() {
    loading.value = true;
    Map data = {
      'email': emailController.value.text,
      'password': emailController.value.text,
    };
    _api.loginApi(data).then((value) {
      loading.value = false;
      Utils.snakBar('Login', 'Login Successfully');
    }).onError((error, stackTrace) {
      loading.value = false;
      Utils.snakBar('Error', error.toString());
    });
  }
}
