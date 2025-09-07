import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:foody_licious/data/data_sources/remote/user_remote_data_source.dart';
import 'package:foody_licious/data/repositories/user_repository_impl.dart';
import 'package:foody_licious/domain/repositories/user_repository.dart';
import 'package:foody_licious/domain/usecase/auth/send_password_reset_email_usecase.dart';
import 'package:foody_licious/domain/usecase/auth/send_verification_email_usecase.dart';
import 'package:foody_licious/domain/usecase/auth/sign_in_with_email_usecase.dart';
import 'package:foody_licious/domain/usecase/auth/sign_in_with_facebook.dart';
import 'package:foody_licious/domain/usecase/auth/sign_in_with_google_usecase.dart';
import 'package:foody_licious/domain/usecase/auth/sign_in_with_phone_usecase.dart';
import 'package:foody_licious/domain/usecase/auth/sign_up_with_email_usecase.dart';
import 'package:foody_licious/domain/usecase/auth/sign_up_with_facebook_usecase.dart';
import 'package:foody_licious/domain/usecase/auth/sign_up_with_google_usecase.dart';
import 'package:foody_licious/domain/usecase/auth/sign_up_with_phone_usecase.dart';
import 'package:foody_licious/domain/usecase/auth/verify_phone_number_for_login_usecase.dart';
import 'package:foody_licious/domain/usecase/auth/verify_phone_number_for_registration_usecase.dart';
import 'package:foody_licious/domain/usecase/auth/wait_for_email_verification_usecase.dart';
import 'package:foody_licious/domain/usecase/user/check_user_usecase.dart';
import 'package:foody_licious/domain/usecase/user/update_user_location_usecase.dart';
import 'package:foody_licious/domain/usecase/user/update_user_usecase.dart';
import 'package:foody_licious/firebase_options.dart';
import 'package:foody_licious/presentation/bloc/auth/auth_bloc.dart';
import 'package:foody_licious/presentation/bloc/user/user_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:smart_auth/smart_auth.dart';
import '../../data/data_sources/local/user_local_data_source.dart';
import '../../data/data_sources/remote/auth_remote_data_source.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/repositories/auth_repository.dart';
import '../network/network_info.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Must be first
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await dotenv.load(fileName: "assets/utils/.env");

  //Features - Auth
  // Bloc
  sl.registerFactory(() => AuthBloc(sl(), sl(), sl(), sl(), sl(), sl(), sl(),
      sl(), sl(), sl(), sl(), sl(), sl()));
  // Use cases
  sl.registerLazySingleton(() => SignInWithEmailUseCase(sl()));
  sl.registerLazySingleton(() => VerifyPhoneNumberForLoginUseCase(sl()));
  sl.registerLazySingleton(() => SignInWithPhoneUseCase(sl()));
  sl.registerLazySingleton(() => SignUpWithEmailUseCase(sl()));
  sl.registerLazySingleton(() => SignInWithGoogleUseCase(sl()));
  sl.registerLazySingleton(() => SendPasswordResetEmailUseCase(sl()));
  sl.registerLazySingleton(() => SignInWithFacebookUseCase(sl()));
  sl.registerLazySingleton(() => SendVerificationEmailUseCase(sl()));
  sl.registerLazySingleton(() => WaitForEmailVerificationUsecase(sl()));
  sl.registerLazySingleton(() => VerifyPhoneNumberForRegistrationUseCase(sl()));
  sl.registerLazySingleton(() => SignUpWithPhoneUseCase(sl()));
  sl.registerLazySingleton(() => SignUpWithGoogleUseCase(sl()));
  sl.registerLazySingleton(() => SignUpWithFacebookUseCase(sl()));
  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
        firebaseAuth: sl(), client: sl(), googleSignIn: sl()),
  );

  //Features - User
  // Bloc
  sl.registerFactory(() => UserBloc(sl(),sl(),sl()));
  // Use cases
  sl.registerLazySingleton(() => CheckUserUseCase(sl()));
  sl.registerLazySingleton(() => UpdateUserLocationUseCase(sl()));
  sl.registerLazySingleton(() => UpdateUserUseCase(sl()));
  // Repository
  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl(),),
  );
  // Data sources
  sl.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSourceImpl(),
  );
  sl.registerLazySingleton<UserLocalDataSource>(
    () => UserLocalDataSourceImpl(sharedPreferences: sl(), secureStorage: sl()),
  );

  ///***********************************************
  ///! Core
  /// sl.registerLazySingleton(() => InputConverter());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  ///! External
  final sharedPreferences = await SharedPreferences.getInstance();
  const secureStorage = FlutterSecureStorage();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => secureStorage);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => GoogleSignIn.instance);
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => SmartAuth.instance);
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
