import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foody_licious/core/constant/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class CallerInfoCard extends StatelessWidget {
  final String callerImageUrl;
  final String callerName;
  final String hotelDistance;
  final num contactNumber; // Example contact number

  const CallerInfoCard({
    super.key,
    required this.callerImageUrl,
    required this.callerName,
    required this.hotelDistance,
    required this.contactNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 87.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: kBorder,
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 10.w,
          ),
          Image.asset(callerImageUrl, width: 64.h, height: 64.h),
          SizedBox(
            width: 20.w,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20.h,
              ),
              Text(
                callerName,
                style: GoogleFonts.yeonSung(
                  color: kBlack,
                  fontSize: 15,
                  fontWeight: FontWeight.normal,
                ),
              ),
              Text(
                hotelDistance,
                style: GoogleFonts.lato(
                  color: kTextSecondary,
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
          SizedBox(
            width: 60.w,
          ),
        ],
      ),
    );
  }
}
