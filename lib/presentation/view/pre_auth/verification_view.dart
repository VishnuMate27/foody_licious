import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foody_licious/core/constant/colors.dart';
import 'package:foody_licious/core/constant/images.dart';
import 'package:foody_licious/core/utils/sms_retriever.dart';
import 'package:foody_licious/presentation/widgets/gradient_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:smart_auth/smart_auth.dart';

class VerificationView extends StatefulWidget {
  final TextEditingController? emailOrPhoneController;
  const VerificationView({super.key, this.emailOrPhoneController});

  State<VerificationView> createState() => _VerificationViewState();
}

class _VerificationViewState extends State<VerificationView> {
  final smartAuth = SmartAuth.instance;
  late final SmsRetriever smsRetriever;
  late final TextEditingController pinController;
  late final FocusNode focusNode;
  late final GlobalKey<FormState> formKey;

  @override
  void initState() {
    super.initState();
    formKey = GlobalKey<FormState>();
    pinController = TextEditingController();
    focusNode = FocusNode();
    smsRetriever = SmsRetrieverImpl(smartAuth);
  }

  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 22,
        color: kTextSecondary,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(19),
        border: Border.all(color: kBorder),
      ),
    );

    return Scaffold(
        backgroundColor: kWhite,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(children: [
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
                style: GoogleFonts.yeonSung(color: kTextRed, fontSize: 40),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                "Deliever Favorite Food",
                style: GoogleFonts.lato(
                    color: kTextRedDark,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 28.h,
              ),
              Text(
                "OTP Verification",
                style: GoogleFonts.yeonSung(
                    color: kTextRedDark,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0),
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                "Enter the code sent to the",
                style: GoogleFonts.lato(
                    color: kTextRedDark,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                widget.emailOrPhoneController != null
                    ? widget.emailOrPhoneController!.value.text
                    : "",
                style: GoogleFonts.lato(
                    color: kTextRedDark,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0),
              ),
              SizedBox(
                height: 20.h,
              ),
              Pinput(
                smsRetriever: smsRetriever,
                controller: pinController,
                focusNode: focusNode,
                defaultPinTheme: defaultPinTheme,
                separatorBuilder: (index) => const SizedBox(width: 8),
                validator: (value) {
                  return value == '2222' ? null : 'Pin is incorrect';
                },
                hapticFeedbackType: HapticFeedbackType.lightImpact,
                onCompleted: (pin) {
                  debugPrint('onCompleted: $pin');
                },
                onChanged: (value) {
                  debugPrint('onChanged: $value');
                },
                cursor: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 9),
                      width: 22,
                      height: 1,
                      color: kBorder,
                    ),
                  ],
                ),
                focusedPinTheme: defaultPinTheme.copyWith(
                  decoration: defaultPinTheme.decoration!.copyWith(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: kBorder),
                  ),
                ),
                submittedPinTheme: defaultPinTheme.copyWith(
                  decoration: defaultPinTheme.decoration!.copyWith(
                    color: kWhite,
                    borderRadius: BorderRadius.circular(19),
                    border: Border.all(color: kBorder),
                  ),
                ),
                errorPinTheme: defaultPinTheme.copyBorderWith(
                  border: Border.all(color: kError),
                ),
              ),
              SizedBox(
                height: 40.h,
              ),
              GradientButton(buttonText: "Verify", onTap: () {})
            ]),
          ),
        ));
  }
}
