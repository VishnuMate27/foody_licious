import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foody_licious/core/constant/colors.dart';
import 'package:foody_licious/core/constant/images.dart';
import 'package:foody_licious/presentation/widgets/input_text_form_field.dart';
import 'package:google_fonts/google_fonts.dart';

import 'order_confirmation_view.dart';

class PayoutView extends StatefulWidget {
  const PayoutView({super.key});

  @override
  State<PayoutView> createState() => _PayoutViewState();
}

class _PayoutViewState extends State<PayoutView> {
  final TextEditingController _nameController =
      TextEditingController(text: "Old Name");
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      appBar: AppBar(
        backgroundColor: kWhite,
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
                    color: kTextRed, fontSize: 24, letterSpacing: 1.0),
              ),
              SizedBox(
                height: 20.h,
              ),
              InputTextFormField(
                textController: _nameController,
                labelText: "Name",
                labelStyle: GoogleFonts.yeonSung(
                  color: kBlack,
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                ),
                hintStyle: GoogleFonts.lato(
                  color: kBlack,
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  letterSpacing: 0.5,
                ),
                suffixIcon: Icon(CupertinoIcons.create, color: kBlack),
                hintText: "Enter name",
                keyboardType: TextInputType.name,
                validatorText: "Please enter your name",
              ),
              SizedBox(
                height: 12.h,
              ),
              InputTextFormField(
                textController: _addressController,
                labelText: "Address",
                labelStyle: GoogleFonts.yeonSung(
                  color: kBlack,
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                ),
                hintStyle: GoogleFonts.lato(
                  color: kBlack,
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  letterSpacing: 0.5,
                ),
                suffixIcon: Icon(CupertinoIcons.create, color: kBlack),
                hintText: "Enter full address",
                keyboardType: TextInputType.streetAddress,
                validatorText: "Please enter your full address",
                minLines: 2,
                maxLines: 5,
              ),
              SizedBox(
                height: 12.h,
              ),
              InputTextFormField(
                textController: _phoneController,
                labelText: "Phone",
                labelStyle: GoogleFonts.yeonSung(
                  color: kBlack,
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                ),
                hintStyle: GoogleFonts.lato(
                    color: kBlack,
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    letterSpacing: 0.5),
                suffixIcon: Icon(CupertinoIcons.create, color: kBlack),
                hintText: "Enter your 10 digit phone number",
                keyboardType: TextInputType.phone,
                validatorText: "Please enter your valid phone number",
              ),
              SizedBox(
                height: 18.h,
              ),
              Container(
                height: 80.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18.0),
                    border: Border.all(color: kBorder, width: 1.0)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Payment Method",
                      style: GoogleFonts.yeonSung(
                        color: kTextSecondary,
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
                  print("Save Information tapped");
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: kTextOnPrimary,
                      border: Border.all(
                        color: kBorder,
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 4),
                          color: kBlack.withAlpha(26),
                          blurRadius: 4,
                        )
                      ]),
                  height: 57.h,
                  child: Center(
                    child: Text(
                      "Place My Order",
                      style: GoogleFonts.yeonSung(
                          color: kTextRedDark, fontSize: 14),
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
