import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foody_licious/core/constant/colors.dart';
import 'package:foody_licious/core/constant/images.dart';
import 'package:foody_licious/core/router/app_router.dart';
import 'package:foody_licious/presentation/bloc/user/user_bloc.dart';
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
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {},
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
                        onTap: () {},
                      ),
                      SocialAuthButton(
                        authProviderName: "Google",
                        authProviderlogoImagePath: kGoogleIcon,
                        onTap: () {},
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  BlocBuilder<UserBloc, UserState>(
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
      BuildContext context, GlobalKey<FormState> key, UserState state) async {
    if (key.currentState!.validate()) {
      final emailOrPhone = _emailOrPhoneController.text.trim();
      bool isEmail = false;
      bool isPhone = false;

      if (state is InputValidationState) {
        isEmail = state.isEmail;
        isPhone = state.isPhone;
      }

      if (isEmail) {
        // context.read<UserBloc>().add(SignUpWithEmailUser(SignUpWithEmailParams(
        //     name: _nameController.text.trim(),
        //     email: emailOrPhone,
        //     password: _passwordController.text,
        //     authProvider: "email")));
      } else if (isPhone) {
        // context.read<UserBloc>().add(VerifyPhoneNumberUser(
        //     SignUpWithPhoneParams(
        //         name: _nameController.text.trim(),
        //         phone: emailOrPhone,
        //         authProvider: "phone")));
      }
    }
  }
}
