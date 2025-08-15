import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foody_licious/core/constant/colors.dart';
import 'package:foody_licious/core/router/app_router.dart';
import 'package:foody_licious/core/services/services_locator.dart' as EasyLoading;
import 'package:foody_licious/firebase_options.dart';
import 'package:foody_licious/presentation/bloc/user/user_bloc.dart';
import 'package:foody_licious/presentation/view/main/main_view.dart';
import 'package:foody_licious/core/services/services_locator.dart' as di;
import 'package:firebase_core/firebase_core.dart';
import 'cubit/navigation_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
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
          initialRoute: AppRouter.signUp,
          onGenerateRoute: AppRouter.onGenerateRoute,
        ),
      ),
    );
  }
}
