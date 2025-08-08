import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foody_licious/core/constant/colors.dart';
import 'package:foody_licious/presentation/view/bottom_nav_bar.dart';
import 'package:foody_licious/presentation/view/post_auth/home_view.dart';
import 'package:foody_licious/presentation/view/pre_auth/login_view.dart';
import 'package:foody_licious/presentation/view/pre_auth/onboarding_view.dart';
import 'package:foody_licious/presentation/view/pre_auth/set_location_view.dart';
import 'package:foody_licious/presentation/view/pre_auth/signup_view.dart';
import 'package:foody_licious/presentation/view/pre_auth/splash_view.dart';

import 'cubit/navigation_cubit.dart';

void main() {
  runApp(
    BlocProvider(
      create: (_) => NavigationCubit(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 800),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        title: 'Foody Licious',
        theme: ThemeData(
          scaffoldBackgroundColor: kWhite,
          appBarTheme: AppBarTheme(backgroundColor: kWhite),
          useMaterial3: true,
        ),
        home: SignUpView(),
      ),
    );
  }
}
