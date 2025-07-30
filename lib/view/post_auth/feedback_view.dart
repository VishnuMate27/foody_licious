import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
            color: Color(0xFFE85353),
            fontSize: 24,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const ImageIcon(
            AssetImage("assets/icons/back_arrow.png"),
            color: Color(0xFFFEAD1D), // Set the color of the back arrow
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
              fillColor: Color(0xFFF4F4F4),
              labelText: 'Address',
              labelStyle: GoogleFonts.yeonSung(
                  color: Color(0xFF000000),
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                  letterSpacing: 0.5),
              hintText: 'Enter full address',
              hintStyle: GoogleFonts.lato(
                  color: Color(0xFF000000),
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  letterSpacing: 0.5),
              suffixIcon: Icon(CupertinoIcons.create, color: Color(0xFF000000)),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: Color(0x80F4F4F4), // Make the border transparent
                  width: 1, // Set the border width to 0
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color:
                      Color(0x51FF8080), // Transparent border when not focused
                  width: 1.sp,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: Color(0x51FF8080), // Transparent border when focused
                  width: 1,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color:
                      Color(0xCCFF0000), // Transparent border for error state
                  width: 1,
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: Color(0x51FF8080), // Transparent border when disabled
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
