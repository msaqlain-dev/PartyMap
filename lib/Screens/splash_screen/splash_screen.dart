import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:partymap/Screens/splash_screen/splash_services.dart';
import 'package:partymap/res/assets/image_assets.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashServices splashServices = SplashServices();

  @override
  void initState() {
    super.initState();
    splashServices.isLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      // child: SvgPicture.asset(
      //   ImageAssets.wolf2Icon,
      //   width: 200,
      //   height: 200,
      // ),
      child: Image.asset(
        ImageAssets.partyMapLogo,
        width: 250,
      ),
    );
  }
}
