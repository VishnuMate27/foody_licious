import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foody_licious/core/constant/colors.dart';
import 'package:foody_licious/core/constant/images.dart';
import 'package:google_fonts/google_fonts.dart';

class FeedbackView extends StatefulWidget {
  const FeedbackView({super.key});

  @override
  State<FeedbackView> createState() => _FeedbackViewState();
}

class _FeedbackViewState extends State<FeedbackView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Write Your Feedback Here",
          style: GoogleFonts.yeonSung(
            color: kTextRed,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
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
      body: Column(
        children: [
          TextFormField(
            minLines: 2,
            maxLines: 5,
            // expands: true,
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
              fillColor: kCardBackground,
              labelText: 'Address',
              labelStyle: GoogleFonts.yeonSung(
                  color: kBlack,
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                  letterSpacing: 0.5),
              hintText: 'Enter full address',
              hintStyle: GoogleFonts.lato(
                  color: kBlack,
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  letterSpacing: 0.5),
              suffixIcon: Icon(CupertinoIcons.create, color: kBlack),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: kBorderLight, // Make the border transparent
                  width: 1, // Set the border width to 0
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: kBorder, // Transparent border when not focused
                  width: 1.sp,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: kBorder, // Transparent border when focused
                  width: 1,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: kError, // Transparent border for error state
                  width: 1,
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: kBorder, // Transparent border when disabled
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
        ],
      ),
    );
  }
}
