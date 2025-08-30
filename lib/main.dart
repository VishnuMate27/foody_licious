import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foody_licious/core/constant/colors.dart';
import 'package:foody_licious/core/constant/strings.dart';
import 'package:foody_licious/core/router/app_router.dart';
import 'package:foody_licious/core/services/services_locator.dart';
import 'package:foody_licious/firebase_options.dart';
import 'package:foody_licious/presentation/bloc/user/user_bloc.dart';
import 'package:foody_licious/presentation/view/main/main_view.dart';
import 'package:foody_licious/core/services/services_locator.dart' as di;
import 'cubit/navigation_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
  configLoading();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => NavigationCubit(),
        ),
        BlocProvider(
          create: (context) => di.sl<UserBloc>()..add(CheckUser()),
        ),
      ],
      child: ScreenUtilInit(
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
          initialRoute: AppRouter.login,
          onGenerateRoute: AppRouter.onGenerateRoute,
          builder: EasyLoading.init(),
        ),
      ),
    );
  }
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2500)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = kWhite
    ..backgroundColor = kPrimaryRed
    ..indicatorColor = kWhite
    ..textColor = kWhite
    ..userInteractions = false
    ..maskType = EasyLoadingMaskType.black
    ..dismissOnTap = true;
}
