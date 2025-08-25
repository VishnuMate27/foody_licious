import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foody_licious/core/constant/colors.dart';
import 'package:foody_licious/core/constant/images.dart';
import 'package:foody_licious/core/router/app_router.dart';
import 'package:foody_licious/core/utils/sms_retriever.dart';
import 'package:foody_licious/domain/usecase/user/sign_up_with_phone_usecase.dart';
import 'package:foody_licious/presentation/bloc/user/user_bloc.dart';
import 'package:foody_licious/presentation/widgets/bouncy_icon.dart';
import 'package:foody_licious/presentation/widgets/gradient_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:smart_auth/smart_auth.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:open_mail_app_plus/open_mail_app_plus.dart';

class VerificationView extends StatefulWidget {
  final TextEditingController? nameController;
  final TextEditingController? emailOrPhoneController;
  final String? authProvider;
  const VerificationView(
      {super.key,
      this.nameController,
      this.emailOrPhoneController,
      this.authProvider});

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
      if (state is UserPhoneVerificationSuccess) {
        Navigator.of(context).pushNamedAndRemoveUntil(
          AppRouter.home,
          (Route<dynamic> route) => false,
        );
      }
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
                  BouncyIcon(
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
                              onTap: () async {
                                // Android: Will open mail app or show native picker.
                                // iOS: Will open mail app if single mail app found.
                                var result = await OpenMailAppPlus.openMailApp(
                                  nativePickerTitle: 'Select email app to open',
                                );

                                // If no mail apps found, show error
                                if (!result.didOpen && !result.canOpen) {
                                  showNoMailAppsDialog(context);

                                  // iOS: if multiple mail apps found, show dialog to select.
                                  // There is no native intent/default app system in iOS so
                                  // you have to do it yourself.
                                } else if (!result.didOpen && result.canOpen) {
                                  showDialog(
                                    context: context,
                                    builder: (_) {
                                      return MailAppPickerDialog(
                                        mailApps: result.options,
                                      );
                                    },
                                  );
                                }
                              }),
                          GradientButton(
                              height: 30.h,
                              width: 140.h,
                              buttonText: "Resend Email",
                              fontSize: 14,
                              onTap: () {
                                
                              })
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
                    "Verification Successful!",
                    style: GoogleFonts.yeonSung(
                        color: kTextRedDark,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0),
                  ),
                  SizedBox(height: 20.h),
                  BouncyIcon(
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
                    duration: const Duration(seconds: 10),
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
      } else if (state is UserVerificationSMSSent) {
        return Scaffold(
          backgroundColor: kWhite,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Form(
                key: formKey,
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
                      style:
                          GoogleFonts.yeonSung(color: kTextRed, fontSize: 40),
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
                        // return value!.length != 4 ? null : 'Pin is incomplete!';
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
                    GradientButton(
                      buttonText: "Verify",
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          _onVerify(context, formKey);
                        }
                      },
                    ),
                  ],
                ),
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
                GradientButton(
                    buttonText: "Verify",
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        _onVerify(context, formKey);
                      }
                    })
              ],
            ),
          ),
        ),
      );
    });
  }
  _onVerify(BuildContext context, GlobalKey<FormState> key) async {
    if (key.currentState!.validate()) {
      final verificationCode = pinController.text.trim();
      context.read<UserBloc>().add(
            SignUpWithPhoneUser(
              SignUpWithPhoneParams(
                name: widget.nameController!.text,
                phone: widget.emailOrPhoneController!.text,
                code: verificationCode,
                authProvider: widget.authProvider!,
              ),
            ),
          );
    }
  }

   void showNoMailAppsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Open Mail App"),
          content: Text("No mail apps installed"),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }

}
