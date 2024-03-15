import 'package:flutter/material.dart';
import 'package:partymap/res/colors/app_color.dart';

class InternetExceptionWidget extends StatefulWidget {
  final VoidCallback onPress;
  const InternetExceptionWidget({super.key, required this.onPress});

  @override
  State<InternetExceptionWidget> createState() =>
      _InternetExceptionWidgetState();
}

class _InternetExceptionWidgetState extends State<InternetExceptionWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Icon(
            Icons.cloud_off,
            color: AppColor.primaryColor,
            size: 50,
          ),
          Padding(
            padding: EdgeInsets.only(top: 30),
            child: Center(
              child: Text(
                  'We are unable to show results.\nPlease check your internet\nconnection'),
            ),
          ),
          InkWell(
            onTap: widget.onPress,
            child: Container(
              height: 44,
              width: 160,
              decoration: BoxDecoration(
                color: AppColor.primaryColor,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Center(
                child: Text(
                  'Retry',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: AppColor.whiteColor),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
