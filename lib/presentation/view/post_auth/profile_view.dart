import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foody_licious/core/constant/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
          style: GoogleFonts.yeonSung(
            color: kRedFont,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Edit",
                style: GoogleFonts.yeonSung(
                    color: kRedFont, fontSize: 24, letterSpacing: 1.0),
              ),
              SizedBox(
                height: 20.h,
              ),
              TextFormField(
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  fillColor: kFillColor,
                  labelText: 'Name',
                  labelStyle: GoogleFonts.yeonSung(
                      color: kFullBlack,
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                      letterSpacing: 0.5),
                  hintText: 'Enter name',
                  hintStyle: GoogleFonts.lato(
                      color: kFullBlack,
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      letterSpacing: 0.5),
                  suffixIcon: Icon(CupertinoIcons.create, color: kFullBlack),
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
                minLines: 2,
                maxLines: 5,
                // expands: true,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  fillColor: kFillColor,
                  labelText: 'Address',
                  labelStyle: GoogleFonts.yeonSung(
                      color: kFullBlack,
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                      letterSpacing: 0.5),
                  hintText: 'Enter full address',
                  hintStyle: GoogleFonts.lato(
                      color: kFullBlack,
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      letterSpacing: 0.5),
                  suffixIcon: Icon(CupertinoIcons.create, color: kFullBlack),
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
                  labelText: 'Email',
                  labelStyle: GoogleFonts.yeonSung(
                      color: kFullBlack,
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                      letterSpacing: 0.5),
                  hintText: 'Enter your email address',
                  hintStyle: GoogleFonts.lato(
                      color: kFullBlack,
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      letterSpacing: 0.5),
                  suffixIcon: Icon(CupertinoIcons.create, color: kFullBlack),
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
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  fillColor: kFillColor,
                  labelText: 'Phone',
                  labelStyle: GoogleFonts.yeonSung(
                      color: kFullBlack,
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                      letterSpacing: 0.5),
                  hintText: 'Enter your 10 digit phone number',
                  hintStyle: GoogleFonts.lato(
                      color: kFullBlack,
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      letterSpacing: 0.5),
                  suffixIcon: Icon(CupertinoIcons.create, color: kFullBlack),
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
                  labelStyle: GoogleFonts.yeonSung(
                      color: kFullBlack,
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                      letterSpacing: 0.5),
                  hintText: 'Enter your password',
                  hintStyle: GoogleFonts.lato(
                      color: kFullBlack,
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      letterSpacing: 0.5),
                  suffixIcon: Icon(CupertinoIcons.create, color: kFullBlack),
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
                height: 24.h,
              ),
              GestureDetector(
                onTap: () {
                  print("Save Information tapped");
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: kFontColor,
                      border: Border.all(color: kRedBorderColor, width: 0.5)),
                  height: 57.h,
                  child: Center(
                    child: Text(
                      "Save Information",
                      style: GoogleFonts.yeonSung(
                          color: kRedFontColor3, fontSize: 14),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
