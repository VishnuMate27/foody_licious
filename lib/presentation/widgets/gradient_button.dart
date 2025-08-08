import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foody_licious/core/constant/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class GradientButton extends StatelessWidget {
  final String buttonText;
  final Function()? onTap;

  const GradientButton({
    super.key,
    required this.buttonText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(
              colors: [kGradientStart, kGradientEnd],
              stops: [0.0, 1.0],
            )),
        width: 157.w,
        height: 57.h,
        child: Center(
            child: Text(
          buttonText,
          style: GoogleFonts.yeonSung(color: kWhite, fontSize: 20),
        )),
      ),
    );
  }
}
