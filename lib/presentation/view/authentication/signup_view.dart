import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foody_licious/core/constant/colors.dart';
import 'package:foody_licious/core/constant/images.dart';
import 'package:foody_licious/core/constant/strings.dart';
import 'package:foody_licious/core/error/failures.dart';
import 'package:foody_licious/core/router/app_router.dart';
import 'package:foody_licious/domain/usecase/user/sign_up_usecase.dart';
import 'package:foody_licious/presentation/bloc/user/user_bloc.dart';
import 'package:foody_licious/presentation/widgets/gradient_button.dart';
import 'package:foody_licious/presentation/widgets/input_text_form_field.dart';
import 'package:foody_licious/presentation/widgets/social_auth_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final TextEditingController _nameController = TextEditingController();
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
    _nameController.dispose();
    _emailOrPhoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onInputChanged() {
    final text = _emailOrPhoneController.text.trim();
    context.read<UserBloc>().add(ValidateEmailOrPhone(text));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        EasyLoading.dismiss();
        if (state is UserLoading) {
          // EasyLoading.show(status: 'Loading...');
        } else if (state is UserLogged) {
          Navigator.of(context).pushNamedAndRemoveUntil(
            AppRouter.home,
            (Route<dynamic> route) => false,
          );
        } else if (state is UserLoggedFail) {
          String errorMessage = "An error occurred. Please try again.";
          if (state.failure is CredentialFailure) {
            errorMessage = "Incorrect username or password.";
          } else if (state.failure is NetworkFailure) {
            errorMessage = "Network error. Check your connection.";
          }
          EasyLoading.showError(errorMessage);
        } else if (state is InputValidationState) {
          if (!state.isEmail && _passwordController.text.isNotEmpty) {
            _passwordController.clear();
          }
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
                    "Sign Up Here",
                    style: GoogleFonts.yeonSung(
                        color: kTextRedDark,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  InputTextFormField(
                      textController: _nameController,
                      labelText: "Name",
                      hintText: "Enter name",
                      prefixIconData: Icons.person_2_outlined,
                      keyboardType: TextInputType.name,
                      validatorText: "Please enter your name"),
                  SizedBox(
                    height: 12.h,
                  ),
                  BlocBuilder<UserBloc, UserState>(
                    builder: (context, state) {
                      bool isEmail = false;
                      IconData prefixIcon = Icons.mail_outlined;
                      TextInputType keyboardType = TextInputType.emailAddress;
                      if (state is InputValidationState) {
                        isEmail = state.isEmail;
                        prefixIcon = isEmail
                            ? Icons.mail_outlined
                            : Icons.phone_outlined;
                        keyboardType = isEmail
                            ? TextInputType.emailAddress
                            : TextInputType.phone;
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
                  BlocBuilder<UserBloc, UserState>(
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
                                children: [
                                  InputTextFormField(
                                      textController: _passwordController,
                                      labelText: "Password",
                                      hintText: "Enter password",
                                      prefixIconData: Icons.lock_outline,
                                      keyboardType: TextInputType.text,
                                      validatorText: "Please set your Password",
                                      obscureText: true),
                                  SizedBox(height: 12.h),
                                ],
                              )
                            : const SizedBox.shrink(),
                      );
                    },
                  ),
                  SizedBox(
                    height: 18.h,
                  ),
                  Text(
                    "Or",
                    style: GoogleFonts.yeonSung(
                        color: kTextPrimary,
                        fontSize: 16,
                        fontWeight: FontWeight.normal),
                  ),
                  Text(
                    "Sign Up With",
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
                          context.read<UserBloc>().add(
                                SignUpUser(
                                  SignUpParams(authProvider: "facebook"),
                                ),
                              );
                        },
                      ),
                      SocialAuthButton(
                        authProviderName: "Google",
                        authProviderlogoImagePath: kGoogleIcon,
                        onTap: () {
                          context.read<UserBloc>().add(
                                SignUpUser(
                                  SignUpParams(authProvider: "google"),
                                ),
                              );
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  BlocBuilder<UserBloc, UserState>(
                    builder: (context, state) {
                      return GradientButton(
                        buttonText: "Create Account",
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            _onSignUp(context, _formKey, state);
                          }
                        },
                      );
                    },
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "Already Have An Account?",
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

  _onSignUp(
      BuildContext context, GlobalKey<FormState> key, UserState state) async {
    if (key.currentState!.validate()) {
      final emailOrPhone = _emailOrPhoneController.text.trim();
      bool isEmail = false;

      if (state is InputValidationState) {
        isEmail = state.isEmail;
      }
      final response = await http.post(
        Uri.parse('$kBaseUrl/api/auth/register'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          "id": "myid1",
          "name": "myName",
          "email": "vishnu2002mate@gmail.com",
          "phone": "0123456788",
          "authProvider": "email"
        }),
      );
      print(response);
    //   context.read<UserBloc>().add(SignUpUser(SignUpParams(
    //       name: _nameController.text.trim(),
    //       email: isEmail ? emailOrPhone : null,
    //       phone: !isEmail ? emailOrPhone : null,
    //       password: isEmail ? _passwordController.text : null,
    //       authProvider: isEmail ? "email" : "phone")));
    }
  }
}
