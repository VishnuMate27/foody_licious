import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foody_licious/core/constant/colors.dart';
import 'package:foody_licious/core/constant/images.dart';
import 'package:foody_licious/core/router/app_router.dart';
import 'package:foody_licious/core/utils/sms_retriever.dart';
import 'package:foody_licious/presentation/bloc/user/user_bloc.dart';
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

    return BlocConsumer<UserBloc, UserState>(listener: (context, state) async {
      // if (state is UserEmailVerificationSuccess) {
      //   Navigator.of(context).pushNamedAndRemoveUntil(
      //     AppRouter.home,
      //     (Route<dynamic> route) => false,
      //   );
      // }
    }, builder: (context, state) {
      if (state is UserVerificationEmailSent) {
        return Scaffold(
          backgroundColor: kWhite,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
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
                    "Email Verification",
                    style: GoogleFonts.yeonSung(
                        color: kTextRedDark,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  _BouncyIcon(
                    icon: Icons.mark_email_read_rounded,
                    size: 50,
                    color: kTextRed,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    "We’ve sent you a verification email!",
                    style: GoogleFonts.lato(
                        color: kTextRedDark,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    "Please check your inbox and click the link to verify your email address. Once verified, you can start enjoying delicious food with Foodylicious.",
                    style: GoogleFonts.lato(
                      color: kTextRedDark,
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GradientButton(
                              height: 30.h,
                              width: 140.h,
                              buttonText: "Open Mail App",
                              fontSize: 14,
                              onTap: () {}),
                          GradientButton(
                              height: 30.h,
                              width: 140.h,
                              buttonText: "Resend Email",
                              fontSize: 14,
                              onTap: () {})
                        ]),
                  ),
                ],
              ),
            ),
          ),
        );
      } else if (state is UserEmailVerificationSuccess) {
        return Scaffold(
          backgroundColor: kWhite,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  SizedBox(height: 82.h),
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
                  SizedBox(height: 10.h),
                  Text(
                    "Deliver Favorite Food",
                    style: GoogleFonts.lato(
                        color: kTextRedDark,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 28.h),
                  Text(
                    "Verification Successful",
                    style: GoogleFonts.yeonSung(
                        color: kTextRedDark,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0),
                  ),
                  SizedBox(height: 20.h),
                  _BouncyIcon(
                    icon: Icons.verified_rounded,
                    size: 60,
                    color: Colors.green,
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    "Your email has been verified!",
                    style: GoogleFonts.lato(
                        color: kTextRedDark,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    "Welcome to Foodylicious 🎉 Now you can explore menus, order your favorite dishes, and enjoy fast delivery.",
                    style: GoogleFonts.lato(
                      color: kTextRedDark,
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 30.h),
                  TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0.0, end: 1.0),
                    duration: const Duration(seconds: 5),
                    onEnd: () {
                      // Auto continue after 5 seconds
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        AppRouter.home,
                        (Route<dynamic> route) => false,
                      );
                    },
                    builder: (context, value, child) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                            AppRouter.home,
                            (Route<dynamic> route) => false,
                          );
                        },
                        child: Container(
                          height: 45.h,
                          width: 200.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            gradient: LinearGradient(
                              colors: [kTextRed, kTextRedDark],
                            ),
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Positioned.fill(
                                child: LinearProgressIndicator(
                                  value: value,
                                  backgroundColor: Colors.transparent,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white.withOpacity(0.4),
                                  ),
                                ),
                              ),
                              Text(
                                "Continue",
                                style: GoogleFonts.lato(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        );
      }
      return Scaffold(
        backgroundColor: kWhite,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
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
              ],
            ),
          ),
        ),
      );
    });
  }
}

class _BouncyIcon extends StatefulWidget {
  const _BouncyIcon({
    required this.icon,
    this.size = 80,
    this.color = kTextRed,
  });
  final IconData icon;
  final double size;
  final Color color;

  @override
  State<_BouncyIcon> createState() => _BouncyIconState();
}

class _BouncyIconState extends State<_BouncyIcon>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 900))
    ..repeat(reverse: true);
  late final Animation<double> _scale = Tween(begin: 0.96, end: 1.04)
      .animate(CurvedAnimation(parent: _c, curve: Curves.easeInOut));

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scale,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: widget.color.withOpacity(0.15),
          border: Border.all(color: widget.color.withOpacity(0.6)),
          boxShadow: [
            BoxShadow(
              blurRadius: 30,
              spreadRadius: 2,
              color: widget.color.withOpacity(0.25),
            ),
          ],
        ),
        child: Icon(widget.icon, size: widget.size, color: widget.color),
      ),
    );
  }
}
