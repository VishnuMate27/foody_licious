import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foody_licious/core/constant/colors.dart';
import 'package:foody_licious/core/constant/images.dart';
import 'package:foody_licious/core/extension/failure_extension.dart';
import 'package:foody_licious/core/router/app_router.dart';
import 'package:foody_licious/domain/usecase/auth/send_password_reset_email_usecase.dart';
import 'package:foody_licious/domain/usecase/auth/sign_in_with_email_usecase.dart';
import 'package:foody_licious/domain/usecase/auth/sign_in_with_phone_usecase.dart';
import 'package:foody_licious/presentation/bloc/auth/auth_bloc.dart';
import 'package:foody_licious/presentation/widgets/gradient_button.dart';
import 'package:foody_licious/presentation/widgets/input_text_form_field.dart';
import 'package:foody_licious/presentation/widgets/social_auth_button.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});
  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _emailOrPhoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // Listen to changes in email/phone field and dispatch to BLoC
    _emailOrPhoneController.addListener(_onInputChanged);
  }

  @override
  void dispose() {
    _emailOrPhoneController.removeListener(_onInputChanged);
    _emailOrPhoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onInputChanged() {
    final text = _emailOrPhoneController.text.trim();
    context.read<AuthBloc>().add(ValidateEmailOrPhone(text));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        EasyLoading.dismiss();
        if (state is AuthLoading) {
          EasyLoading.show(status: 'Loading...');
        } else if (state is AuthSignInWithEmailSuccess) {
          Navigator.of(context).pushNamedAndRemoveUntil(
            AppRouter.setLocation,
            (Route<dynamic> route) => false,
          );
        } else if (state is AuthSignInWithEmailFailed) {
          EasyLoading.showError(
            state.failure.toMessage(
              defaultMessage: "Email login Failed!",
            ),
          );
        } else if (state is AuthVerificationSMSForLoginSent) {
          Navigator.of(context).pushNamedAndRemoveUntil(
              AppRouter.verification, (Route<dynamic> route) => false,
              arguments: {
                'emailOrPhoneController': _emailOrPhoneController,
                'authProvider': 'phone',
              });
        } else if (state is AuthVerificationSMSForLoginSentFailed) {
          EasyLoading.showError(
            state.failure.toMessage(
              defaultMessage: "Failed to send verification SMS!",
            ),
          );
        } else if (state is AuthGoogleSignInSuccess ||
            state is AuthFacebookSignInSuccess) {
          Navigator.of(context).pushNamedAndRemoveUntil(
            AppRouter.setLocation,
            (Route<dynamic> route) => false,
          );
        } else if (state is AuthPasswordResetEmailSent) {
          EasyLoading.showToast("Password Reset Email Sent!");
        } else if (state is AuthPasswordResetEmailSentFailed) {
          EasyLoading.show(status: "Failed to send password reset email!");
        } else if (state is AuthGoogleSignInFailed) {
          EasyLoading.showError(
            state.failure.toMessage(
              defaultMessage: "Failed to login with google!",
            ),
          );
        } else if (state is AuthFacebookSignInFailed) {
          EasyLoading.showError(
            state.failure.toMessage(
              defaultMessage: "Failed to login with facebook!",
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: kWhite,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 82.h,
                  ),
                  Hero(
                    tag: kLogo,
                    child: Center(
                      child: Image.asset(
                        kLogo,
                        width: 90.w,
                        height: 90.h,
                      ),
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
                    "Login To Your Account",
                    style: GoogleFonts.lato(
                        color: kTextRedDark,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0),
                  ),
                  SizedBox(
                    height: 28.h,
                  ),
                  BlocConsumer<AuthBloc, AuthState>(
                    listener: (context, state) {
                      if (state is InputValidationState) {
                        if (state.isPhone) {
                          // Phone mode → enforce +91
                          if (!_emailOrPhoneController.text.startsWith("+91")) {
                            final newText = _emailOrPhoneController.text;
                            _emailOrPhoneController.text = "+91$newText";
                            _emailOrPhoneController.selection =
                                TextSelection.fromPosition(
                              TextPosition(
                                  offset: _emailOrPhoneController.text.length),
                            );
                          }
                        } else if (state.isEmail) {
                          // Email mode → remove +91 if present
                          if (_emailOrPhoneController.text.startsWith("+91")) {
                            final newText = _emailOrPhoneController.text
                                .replaceFirst("+91", "");
                            _emailOrPhoneController.text = newText;
                            _emailOrPhoneController.selection =
                                TextSelection.fromPosition(
                              TextPosition(
                                  offset: _emailOrPhoneController.text.length),
                            );
                          }
                        }
                      }
                    },
                    builder: (context, state) {
                      bool isEmail = false;
                      bool isPhone = false;
                      IconData prefixIcon = Icons.mail_outlined;
                      TextInputType keyboardType = TextInputType.text;

                      if (state is InputValidationState) {
                        isEmail = state.isEmail;
                        isPhone = state.isPhone;

                        if (isEmail) {
                          prefixIcon = Icons.mail_outlined;
                          keyboardType = TextInputType.emailAddress;
                        } else if (isPhone) {
                          prefixIcon = Icons.phone_outlined;
                          keyboardType = TextInputType.phone;
                        }
                      }

                      return InputTextFormField(
                        textController: _emailOrPhoneController,
                        labelText: "Email or Phone Number",
                        hintText: "Enter email or phone number",
                        prefixIconData: prefixIcon,
                        keyboardType: keyboardType,
                        validatorText:
                            "Please enter your email or phone number",
                      );
                    },
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      bool showPassword = false;

                      if (state is InputValidationState) {
                        showPassword = state.isEmail && state.isValid;
                      }

                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        height: showPassword ? null : 0,
                        child: showPassword
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  InputTextFormField(
                                      textController: _passwordController,
                                      labelText: "Password",
                                      hintText: "Enter password",
                                      prefixIconData: Icons.lock_outline,
                                      keyboardType: TextInputType.text,
                                      validatorText: "Please set your Password",
                                      obscureText: true),
                                  Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        TextButton(
                                          onPressed: () {
                                            context.read<AuthBloc>().add(
                                                  AuthSendPasswordResetEmail(
                                                    SendPasswordResetEmailParams(
                                                      email:
                                                          _emailOrPhoneController
                                                              .text
                                                              .toLowerCase()
                                                              .trim(),
                                                    ),
                                                  ),
                                                );
                                          },
                                          child: Text(
                                            "Forgot Password ?",
                                            style: GoogleFonts.lato(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: kTextRedDark,
                                            ),
                                            textAlign: TextAlign.end,
                                          ),
                                        )
                                      ]),
                                  SizedBox(height: 12.h),
                                ],
                              )
                            : const SizedBox.shrink(),
                      );
                    },
                  ),
                  SizedBox(
                    height: 28.h,
                  ),
                  Text(
                    "Or",
                    style: GoogleFonts.yeonSung(
                        color: kTextPrimary,
                        fontSize: 16,
                        fontWeight: FontWeight.normal),
                  ),
                  Text(
                    "Continue With",
                    style: GoogleFonts.yeonSung(
                        color: kTextPrimary,
                        fontSize: 20,
                        fontWeight: FontWeight.normal),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SocialAuthButton(
                        authProviderName: "Facebook",
                        authProviderlogoImagePath: kFacebookIcon,
                        onTap: () {
                          context
                              .read<AuthBloc>()
                              .add(AuthSignInWithFacebook());
                        },
                      ),
                      SocialAuthButton(
                        authProviderName: "Google",
                        authProviderlogoImagePath: kGoogleIcon,
                        onTap: () {
                          context.read<AuthBloc>().add(AuthSignInWithGoogle());
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      return GradientButton(
                        buttonText: "Login",
                        onTap: () {
                          _onLogin(context, _formKey, state);
                        },
                      );
                    },
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        AppRouter.signUp,
                        (Route<dynamic> route) => false,
                      );
                    },
                    child: Text(
                      "Don’t Have Account?",
                      style: GoogleFonts.lato(
                          color: kTextRedDark,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.0),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _onLogin(
      BuildContext context, GlobalKey<FormState> key, AuthState state) async {
    if (key.currentState!.validate()) {
      final emailOrPhone = _emailOrPhoneController.text.trim();
      bool isEmail = false;
      bool isPhone = false;

      if (state is InputValidationState) {
        isEmail = state.isEmail;
        isPhone = state.isPhone;
      }

      if (isEmail) {
        context.read<AuthBloc>().add(AuthSignInWithEmail(SignInWithEmailParams(
            email: emailOrPhone,
            password: _passwordController.text,
            authProvider: "email")));
      } else if (isPhone) {
        context.read<AuthBloc>().add(AuthVerifyPhoneNumberForLogin(
            SignInWithPhoneParams(phone: emailOrPhone, authProvider: "phone")));
      }
    }
  }
}
