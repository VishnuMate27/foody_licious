import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 98.h,
          ),
          Center(
            child: Image.asset(
              "assets/images/burger.png",
              width: 333.w,
              height: 312.h,
            ),
          ),
          SizedBox(
            height: 42.h,
          ),
          Text("Enjoy Restaurant Quality Meals at Home",style: GoogleFonts.yeonSung(color: Color(0xFFBB0C24),fontSize: 20),),
          SizedBox(
            height: 160.h,
          ),
          GestureDetector(
            onTap: (){},
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: LinearGradient(colors: [Color(0xFFE85353),Color(0xFFBE1515)],stops: [0.0,1.0],)
              ),
              width: 157.w,
              height: 57.h,
              child: Center(child: Text("Next",style: GoogleFonts.yeonSung(color: Color(0xFFFFFFFF),fontSize: 20),)),
            ),
          )
        ],
      ),
    );
  }
}
