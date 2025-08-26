import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:foody_licious/domain/usecase/user/get_local_user_usecase.dart';
import 'package:foody_licious/domain/usecase/user/send_verification_email_usecase.dart';
import 'package:foody_licious/domain/usecase/user/sign_in_usecase.dart';
import 'package:foody_licious/domain/usecase/user/sign_up_with_email_usecase.dart';
import 'package:foody_licious/domain/usecase/user/sign_up_with_facebook_usecase.dart';
import 'package:foody_licious/domain/usecase/user/sign_up_with_google_usecase.dart';
import 'package:foody_licious/domain/usecase/user/sign_up_with_phone_usecase.dart';
import 'package:foody_licious/domain/usecase/user/verify_phone_number_usecase.dart';
import 'package:foody_licious/domain/usecase/user/wait_for_email_verification_usecase.dart';
import 'package:foody_licious/firebase_options.dart';
import 'package:foody_licious/presentation/bloc/user/user_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import '../../data/data_sources/local/user_local_data_source.dart';
import '../../data/data_sources/remote/user_remote_data_source.dart';
import '../../data/repositories/user_repository_impl.dart';
import '../../domain/repositories/user_repository.dart';
import '../network/network_info.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Must be first
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await dotenv.load(fileName: "assets/utils/.env");

  //Features - User
  // Bloc
  sl.registerFactory(
    () => UserBloc(sl(), sl(), sl(),sl(),sl(),sl(),sl(),sl(),sl())
  );
  // Use cases
  sl.registerLazySingleton(() => SignInUseCase(sl()));
  sl.registerLazySingleton(() => SignUpWithEmailUseCase(sl()));
  sl.registerLazySingleton(() => SendVerificationEmailUseCase(sl()));
  sl.registerLazySingleton(() => WaitForEmailVerificationUsecase(sl()));
  sl.registerLazySingleton(() => VerifyPhoneNumberUseCase(sl()));
  sl.registerLazySingleton(() => SignUpWithPhoneUseCase(sl()));
  sl.registerLazySingleton(() => SignUpWithGoogleUseCase(sl()));
  sl.registerLazySingleton(() => SignUpWithFacebookUseCase(sl()));
  sl.registerLazySingleton(() => GetLocalUserUseCase(sl()));
  // Repository
  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );
  // Data sources
  sl.registerLazySingleton<UserLocalDataSource>(
    () => UserLocalDataSourceImpl(sharedPreferences: sl(), secureStorage: sl()),
  );
  sl.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSourceImpl(firebaseAuth: sl(), client: sl(),googleSignIn:sl()),
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
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => GoogleSignIn.instance);
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
