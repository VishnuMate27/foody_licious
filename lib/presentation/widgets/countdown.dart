import 'package:flutter/material.dart';
import 'package:foody_licious/core/constant/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class Countdown extends AnimatedWidget {
  final Animation<int>? animation;
  final Function()? onResendOTPTapped;

  Countdown({Key? key, this.animation, this.onResendOTPTapped})
      : super(key: key, listenable: animation!);

  @override
  build(BuildContext context) {
    Duration clockTimer = Duration(seconds: animation!.value);

    String timerText =
        '${clockTimer.inMinutes.remainder(60).toString()}:${clockTimer.inSeconds.remainder(60).toString().padLeft(2, '0')}';

    return clockTimer.inSeconds == 0
        ? TextButton(
            onPressed: onResendOTPTapped,
            child: Text(
              "Resend OTP",
              style: GoogleFonts.lato(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: kTextRedDark,
              ),
            ),
          )
        : Text(
            timerText,
            style: GoogleFonts.lato(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: kTextRedDark,
            ),
          );
  }
}
