import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foody_licious/core/constant/colors.dart';
import 'package:foody_licious/core/constant/images.dart';
import 'package:google_fonts/google_fonts.dart';

class SocialAuthButton extends StatelessWidget {
  final String authProviderName;
  final String authProviderlogoImagePath;
  final Function()? onTap;
  const SocialAuthButton(
      {super.key,
      required this.authProviderName,
      required this.authProviderlogoImagePath,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border:
              Border.all(color: kBorder, width: 1.0, style: BorderStyle.solid),
        ),
        width: 152.w,
        height: 57.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              authProviderlogoImagePath,
              width: 25.w,
              height: 25.h,
            ),
            SizedBox(
              width: 12.w,
            ),
            Text(
              authProviderName,
              style: GoogleFonts.lato(color: kTextPrimary, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
