import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foody_licious/core/constant/colors.dart';
import 'package:foody_licious/core/constant/images.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kFullWhite,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              kLogo,
              width: 185.w,
              height: 189.h,
            ),
          ),
          SizedBox(
            height: 42.h,
          ),
          Text(
            "Foody Licious",
            style: GoogleFonts.yeonSung(color: kRedFont, fontSize: 40),
          ),
          SizedBox(
            height: 40.h,
          ),
          Text(
            "Deliever Favorite Food",
            style: GoogleFonts.lato(
                color: kRedFont, fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
