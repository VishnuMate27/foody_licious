import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foody_licious/core/constant/colors.dart';
import 'package:foody_licious/core/constant/images.dart';
import 'package:foody_licious/presentation/widgets/gradient_button.dart';
import 'package:foody_licious/presentation/widgets/input_text_form_field.dart';
import 'package:google_fonts/google_fonts.dart';

class FeedbackView extends StatefulWidget {
  const FeedbackView({super.key});

  @override
  State<FeedbackView> createState() => _FeedbackViewState();
}

class _FeedbackViewState extends State<FeedbackView> {
  final TextEditingController _feedbackController = TextEditingController();
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Column(
          children: [
            SizedBox(height: 40.h),
            InputTextFormField(
              textController: _feedbackController,
              labelText: "Feedback",
              labelStyle: GoogleFonts.yeonSung(
                color: kBlack,
                fontSize: 20,
                fontWeight: FontWeight.normal,
              ),
              suffixIcon: Icon(CupertinoIcons.create, color: kBlack),
              hintText: "Enter you feedback",
              keyboardType: TextInputType.streetAddress,
              validatorText: "Please enter your feedback",
              minLines: 2,
              maxLines: 5,
            ),
            SizedBox(height: 40.h),
            GradientButton(
              onTap: () {},
              buttonText: "Submit",
            )
          ],
        ),
      ),
    );
  }
}
