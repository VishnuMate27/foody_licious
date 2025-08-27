import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foody_licious/core/constant/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class GradientButton extends StatelessWidget {
  final String buttonText;
  final Function()? onTap;
  final double width;
  final double height;
  final double borderRadius;
  final double fontSize;
  final bool isActive;

  const GradientButton({
    super.key,
    required this.buttonText,
    required this.onTap,
    this.width = 157,
    this.height = 57,
    this.borderRadius = 15,
    this.fontSize = 20,
    this.isActive = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isActive ? onTap : () {},
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            gradient: LinearGradient(
              colors: isActive ? [kGradientStart, kGradientEnd]:[kInActiveGradientStart,kInActiveGradientEnd] ,
              stops: [0.0, 1.0],
            )),
        width: width.w,
        height: height.h,
        child: Center(
            child: Text(
          buttonText,
          style: GoogleFonts.yeonSung(color: kWhite, fontSize: fontSize),
        )),
      ),
    );
  }
}
