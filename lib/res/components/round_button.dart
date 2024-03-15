import 'package:flutter/material.dart';
import 'package:partymap/res/colors/app_color.dart';

class RoundButton extends StatelessWidget {
  const RoundButton({
    super.key,
    required this.title,
    this.height,
    this.width,
    required this.onPress,
    this.textColor,
    this.buttonColor,
    this.buttonRadius = 10,
    this.fontSize,
    this.fontWeight,
    this.loading = false,
  });

  final bool loading;
  final String title;
  final double? height, width;
  final double? fontSize;
  final FontWeight? fontWeight;
  final double buttonRadius;
  final VoidCallback? onPress;
  final Color? textColor, buttonColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(buttonRadius),
        ),
        child: loading
            ? Center(child: CircularProgressIndicator())
            : Center(
                child: Text(
                  title,
                  style: TextStyle(
                    color: textColor,
                    fontSize: fontSize,
                    fontWeight: fontWeight,
                    fontFamily: "Nunito",
                  ),
                ),
              ),
      ),
    );
  }
}
