import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:partymap/res/getx_localization/languages.dart';
import 'package:partymap/res/navigators/routes.dart';
import 'package:partymap/utils/responsive_size_util.dart'; // Import your ResponsiveSizeUtil

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Initialize ScreenUtil package
    ScreenUtil.init(context,
        designSize: const Size(375, 812), minTextAdapt: true);

    // Initialize your custom ResponsiveSizeUtil
    ResponsiveSizeUtil.init(context);

    return GetMaterialApp(
      title: 'Party Map',
      translations: Languages(),
      locale: const Locale('en', 'US'),
      fallbackLocale: const Locale('en', 'US'),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      getPages: AppRoutes.appRoutes(),
    );
  }
}
