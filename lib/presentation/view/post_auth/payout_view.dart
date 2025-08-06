import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foody_licious/core/constant/colors.dart';
import 'package:foody_licious/core/constant/images.dart';
import 'package:google_fonts/google_fonts.dart';

import 'order_confirmation_view.dart';

class PayoutView extends StatefulWidget {
  const PayoutView({super.key});

  @override
  State<PayoutView> createState() => _PayoutViewState();
}

class _PayoutViewState extends State<PayoutView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kFullWhite,
      appBar: AppBar(
        backgroundColor: kFullWhite,
        elevation: 0,
        leading: IconButton(
          icon: ImageIcon(
            AssetImage(kBackArrowIcon),
            color: kYellow, // Set the color of the back arrow
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
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
                keyboardType: TextInputType.name,
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
                height: 18.h,
              ),
              Container(
                height: 80.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18.0),
                    border: Border.all(color: kRedBorderColor, width: 0.5)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Payment Method",
                      style: GoogleFonts.yeonSung(
                        color: kBlackishFontColor2,
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        letterSpacing: 0.5,
                      ),
                    ),
                    Image.asset(
                      kCashOnDeliveryIcon,
                      width: 106,
                      height: 52,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 38.h,
              ),
              GestureDetector(
                onTap: () {
                  print("Place My Order tapped");
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const OrderConfirmationView(),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: kFontColor,
                      border: Border.all(color: kRedBorderColor, width: 0.5)),
                  height: 57.h,
                  child: Center(
                    child: Text(
                      "Place My Order",
                      style: GoogleFonts.yeonSung(
                          color: kRedFontColor2, fontSize: 14),
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
