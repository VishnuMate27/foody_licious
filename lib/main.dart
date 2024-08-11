import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foody_licious/view/bottom_nav_bar.dart';
import 'package:foody_licious/view/home_view.dart';
import 'package:foody_licious/view/pre_auth/login_view.dart';
import 'package:foody_licious/view/pre_auth/onboarding_view.dart';
import 'package:foody_licious/view/pre_auth/set_location_view.dart';
import 'package:foody_licious/view/pre_auth/signup_view.dart';


void main() {
  runApp(const MyApp());
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
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: ProvidedStylesExample(menuScreenContext: context,),
      ),
    );
  }
}
