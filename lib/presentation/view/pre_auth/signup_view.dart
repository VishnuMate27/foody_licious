import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foody_licious/core/constant/colors.dart';
import 'package:foody_licious/core/constant/images.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kFullWhite,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 82.h,
              ),
              Center(
                child: Image.asset(
                  kLogo,
                  width: 90.w,
                  height: 90.h,
                ),
              ),
              Text(
                "Foody Licious",
                style: GoogleFonts.yeonSung(color: kRedFont, fontSize: 40),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                "Deliever Favorite Food",
                style: GoogleFonts.lato(
                    color: kRedFontColor2,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 28.h,
              ),
              Text(
                "Sign Up Here",
                style: GoogleFonts.yeonSung(
                    color: kRedFontColor2,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0),
              ),
              SizedBox(
                height: 20.h,
              ),
              TextFormField(
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  fillColor: kFillColor,
                  labelText: 'Name',
                  labelStyle: GoogleFonts.lato(
                      color: kBlackishFontColor2,
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      letterSpacing: 0.5),
                  hintText: 'Enter name',
                  prefixIcon: Icon(
                    Icons.person_2_outlined,
                    color: kFullBlack,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: kBorderSideColor2, // Make the border transparent
                      width: 1, // Set the border width to 0
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: Color(
                          0x51FF8080), // Transparent border when not focused
                      width: 1.sp,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color:
                          kBorderSideColor, // Transparent border when focused
                      width: 1,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: Color(
                          0xCCFF0000), // Transparent border for error state
                      width: 1,
                    ),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color:
                          kBorderSideColor, // Transparent border when disabled
                      width: 1,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
                onSaved: (value) {},
              ),
              SizedBox(
                height: 12.h,
              ),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  fillColor: kFillColor,
                  labelText: 'Email or Phone Number',
                  labelStyle: GoogleFonts.lato(
                      color: kBlackishFontColor2,
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      letterSpacing: 0.5),
                  hintText: 'Enter email',
                  prefixIcon: Icon(
                    Icons.mail_outlined,
                    color: kFullBlack,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: kBorderSideColor2, // Make the border transparent
                      width: 1, // Set the border width to 0
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: Color(
                          0x51FF8080), // Transparent border when not focused
                      width: 1.sp,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color:
                          kBorderSideColor, // Transparent border when focused
                      width: 1,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: Color(
                          0xCCFF0000), // Transparent border for error state
                      width: 1,
                    ),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color:
                          kBorderSideColor, // Transparent border when disabled
                      width: 1,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
                onSaved: (value) {},
              ),
              SizedBox(
                height: 12.h,
              ),
              TextFormField(
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  fillColor: kFillColor,
                  labelText: 'Password',
                  labelStyle: GoogleFonts.lato(
                      color: kBlackishFontColor2,
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      letterSpacing: 0.5),
                  hintText: 'Enter Password',
                  prefixIcon: Icon(
                    Icons.lock_outline,
                    color: kFullBlack,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: kBorderSideColor, // Make the border transparent
                      width: 1, // Set the border width to 0
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: Color(
                          0x51FF8080), // Transparent border when not focused
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color:
                          kBorderSideColor, // Transparent border when focused
                      width: 1,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: Color(
                          0xCCFF0000), // Transparent border for error state
                      width: 1,
                    ),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color:
                          kBorderSideColor, // Transparent border when disabled
                      width: 1,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
                onSaved: (value) {},
              ),
              SizedBox(
                height: 18.h,
              ),
              Text(
                "Or",
                style: GoogleFonts.yeonSung(
                    color: kBlackishFontColor,
                    fontSize: 16,
                    fontWeight: FontWeight.normal),
              ),
              Text(
                "Sign Up With",
                style: GoogleFonts.yeonSung(
                    color: kBlackishFontColor,
                    fontSize: 20,
                    fontWeight: FontWeight.normal),
              ),
              SizedBox(
                height: 20.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                            color: kBorderSideColor,
                            width: 1.0,
                            style: BorderStyle.solid),
                      ),
                      width: 152.w,
                      height: 57.h,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            "icons/facebook.png",
                            width: 25.w,
                            height: 25.h,
                          ),
                          SizedBox(
                            width: 12.w,
                          ),
                          Text(
                            "Facebook",
                            style: GoogleFonts.lato(
                                color: kBlackishFontColor, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                            color: kBorderSideColor,
                            width: 1.0,
                            style: BorderStyle.solid),
                      ),
                      width: 152.w,
                      height: 57.h,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            kGoogleIcon,
                            width: 25.w,
                            height: 25.h,
                          ),
                          SizedBox(
                            width: 12.w,
                          ),
                          Text(
                            "Google",
                            style: GoogleFonts.lato(
                                color: kBlackishFontColor, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      gradient: LinearGradient(
                        colors: [kGradientColor1, kGradientColor2],
                        stops: [0.0, 1.0],
                      )),
                  width: 157.w,
                  height: 57.h,
                  child: Center(
                      child: Text(
                    "Create Account",
                    style:
                        GoogleFonts.yeonSung(color: kFullWhite, fontSize: 20),
                  )),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                "Already Have An Account?",
                style: GoogleFonts.lato(
                    color: kRedFontColor2,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
