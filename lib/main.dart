import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foody_licious/core/constant/colors.dart';
import 'package:foody_licious/core/router/app_router.dart';
import 'package:foody_licious/presentation/view/main/main_view.dart';

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
        initialRoute: AppRouter.home,
        onGenerateRoute: AppRouter.onGenerateRoute,
      ),
    );
  }
}
