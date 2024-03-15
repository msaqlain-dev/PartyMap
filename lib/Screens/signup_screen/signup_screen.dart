import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partymap/Screens/signup_screen/signup_controller.dart';
import 'package:partymap/res/assets/image_assets.dart';
import 'package:partymap/res/colors/app_color.dart';
import 'package:partymap/res/components/custom_text.dart';
import 'package:partymap/res/components/round_button.dart';
import 'package:partymap/utils/responsive_size_util.dart';
import 'package:partymap/utils/utils.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final signupController = Get.put(SignupController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.blackColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Image.asset(
                    ImageAssets.partyMapLogo,
                    width: 250,
                  ),
                  SizedBox(
                    height: ResponsiveSizeUtil.scaleFactorHeight * 50,
                  ),
                  CustomText(
                    text: 'Signup',
                    color: AppColor.primaryColor,
                    fontSize: 42,
                    fontWeight: FontWeight.w700,
                  ),
                  SizedBox(
                    height: ResponsiveSizeUtil.scaleFactorHeight * 50,
                  ),
                  Container(
                    height: ResponsiveSizeUtil.size60,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(ResponsiveSizeUtil.size10),
                      color: const Color(0xFFF0F0F0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: ResponsiveSizeUtil.size3,
                      ),
                      child: TextFormField(
                        controller: signupController.emailController.value,
                        focusNode: signupController.emailFocusNode.value,
                        validator: (value) {
                          if (value!.isEmpty) {
                            Utils.snakBar('Email', 'Enter Email');
                          }
                        },
                        onFieldSubmitted: (value) => {
                          Utils.fieldFocusChange(
                              context,
                              signupController.emailFocusNode.value,
                              signupController.passwordFocusNode.value)
                        },
                        style: TextStyle(
                          fontSize: ResponsiveSizeUtil.size15,
                          color: AppColor.blackColor,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.email_rounded,
                            color: AppColor.primaryColor,
                          ),
                          labelText: 'Email',
                          labelStyle: TextStyle(
                            fontSize: ResponsiveSizeUtil.size15,
                            color: AppColor.grayColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: ResponsiveSizeUtil.size60,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(ResponsiveSizeUtil.size10),
                      color: const Color(0xFFF0F0F0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: ResponsiveSizeUtil.size3,
                      ),
                      child: TextFormField(
                        controller: signupController.passwordController.value,
                        focusNode: signupController.passwordFocusNode.value,
                        validator: (value) {
                          if (value!.isEmpty) {
                            Utils.snakBar('Password', 'Enter Password');
                          }
                        },
                        onFieldSubmitted: (value) {},
                        obscureText: true,
                        obscuringCharacter: '●',
                        style: TextStyle(
                          fontSize: ResponsiveSizeUtil.size15,
                          color: AppColor.blackColor,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.lock,
                            color: AppColor.primaryColor,
                          ),
                          labelText: 'Password',
                          labelStyle: TextStyle(
                            fontSize: ResponsiveSizeUtil.size15,
                            color: AppColor.grayColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: ResponsiveSizeUtil.size60,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(ResponsiveSizeUtil.size10),
                      color: const Color(0xFFF0F0F0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: ResponsiveSizeUtil.size3,
                      ),
                      child: TextFormField(
                        controller:
                            signupController.confirmPasswordController.value,
                        focusNode:
                            signupController.confirmPasswordFocusNode.value,
                        validator: (value) {
                          if (value!.isEmpty) {
                            Utils.snakBar(
                                'Confirm Password', 'Enter Confirm Password');
                          }
                        },
                        onFieldSubmitted: (value) {},
                        obscureText: true,
                        obscuringCharacter: '●',
                        style: TextStyle(
                          fontSize: ResponsiveSizeUtil.size15,
                          color: AppColor.blackColor,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.lock,
                            color: AppColor.primaryColor,
                          ),
                          labelText: 'Confirm Password',
                          labelStyle: TextStyle(
                            fontSize: ResponsiveSizeUtil.size15,
                            color: AppColor.grayColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: ResponsiveSizeUtil.scaleFactorHeight * 40,
            ),
            Obx(
              () => RoundButton(
                title: 'Signup',
                width: double.infinity,
                height: ResponsiveSizeUtil.size60,
                fontSize: 22,
                fontWeight: FontWeight.w700,
                textColor: AppColor.primaryColor,
                buttonColor: AppColor.whiteColor,
                loading: signupController.loading.value,
                onPress: () {
                  if (_formKey.currentState!.validate()) {
                    signupController.signupApi();
                  }
                },
              ),
            ),
            SizedBox(
              height: ResponsiveSizeUtil.scaleFactorHeight * 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                  text: "already have an account? ",
                  color: AppColor.whiteColor,
                  fontSize: ResponsiveSizeUtil.size16,
                  fontWeight: FontWeight.w500,
                ),
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: CustomText(
                    text: "Login",
                    color: AppColor.primaryColor,
                    fontSize: ResponsiveSizeUtil.size16,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
