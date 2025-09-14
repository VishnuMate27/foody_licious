import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foody_licious/core/constant/colors.dart';
import 'package:foody_licious/core/constant/images.dart';
import 'package:foody_licious/core/router/app_router.dart';
import 'package:foody_licious/domain/usecase/user/check_user_usecase.dart';
import 'package:foody_licious/presentation/bloc/user/user_bloc.dart';
import 'package:foody_licious/presentation/bloc/user/user_event.dart';
import 'package:foody_licious/presentation/bloc/user/user_state.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) async {
        EasyLoading.dismiss();
        if (state is UserAuthenticated) {
          await Future.delayed(Duration(seconds: 5));
          Navigator.of(context).pushNamedAndRemoveUntil(
            AppRouter.setLocation,
            (Route<dynamic> route) => false,
            arguments: {
              'previousCity': state.user.address?.city,
            },
          );
        } else if (state is UserUnauthenticated) {
          await Future.delayed(Duration(seconds: 5));
          Navigator.of(context).pushNamedAndRemoveUntil(
            AppRouter.login,
            (Route<dynamic> route) => false,
          );
        }
      },
      child: Scaffold(
        backgroundColor: kWhite,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Hero(
              tag: kLogo,
              child: Center(
                child: Image.asset(
                  kLogo,
                  width: 185.w,
                  height: 189.h,
                ),
              ),
            ),
            SizedBox(
              height: 42.h,
            ),
            Text(
              "Foody Licious",
              style: GoogleFonts.yeonSung(color: kTextRed, fontSize: 40),
            ),
            SizedBox(
              height: 40.h,
            ),
            Text(
              "Deliever Favorite Food",
              style: GoogleFonts.lato(
                  color: kTextRed, fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
