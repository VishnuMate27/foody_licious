import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foody_licious/core/constant/colors.dart';
import 'package:foody_licious/core/constant/images.dart';
import 'package:foody_licious/core/error/failures.dart';
import 'package:foody_licious/core/router/app_router.dart';
import 'package:foody_licious/domain/usecase/user/sign_up_usecase.dart';
import 'package:foody_licious/presentation/bloc/user/user_bloc.dart';
import 'package:foody_licious/presentation/widgets/gradient_button.dart';
import 'package:foody_licious/presentation/widgets/input_text_form_field.dart';
import 'package:foody_licious/presentation/widgets/social_auth_button.dart';
import 'package:google_fonts/google_fonts.dart';

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
                  InputTextFormField(
                      textController: _emailOrPhoneController,
                      labelText: "Email or Phone Number",
                      hintText: "Enter email or phone Number",
                      prefixIconData: Icons.mail_outlined,
                      keyboardType: TextInputType.emailAddress,
                      validatorText:
                          "Please enter your valid email or phone Number"),
                  SizedBox(
                    height: 12.h,
                  ),
                  InputTextFormField(
                      textController: _passwordController,
                      labelText: "Password",
                      hintText: "Enter password",
                      prefixIconData: Icons.lock_outline,
                      keyboardType: TextInputType.text,
                      validatorText: "Please set your Password",
                      obscureText: true),
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
                  GradientButton(
                      buttonText: "Create Account",
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          if (_passwordController.text !=
                              _emailOrPhoneController.text) {
                            print("Email & password cannot be same");
                            _onSignUp(context, _formKey);
                          }
                        }
                      }),
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

  void _onSignUp(BuildContext context, GlobalKey<FormState> key) {
    if (key.currentState!.validate()) {
      context.read<UserBloc>().add(SignUpUser(SignUpParams(
          name: _nameController.value.text,
          email: _emailOrPhoneController.text,
          phone: _emailOrPhoneController.text,
          password: _passwordController.text,
          authProvider: "google")));
    }
  }
}
