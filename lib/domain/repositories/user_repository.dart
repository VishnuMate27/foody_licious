import 'package:dartz/dartz.dart';
import 'package:foody_licious/core/usecase/usecase.dart';
import 'package:foody_licious/domain/usecase/user/sign_in_usecase.dart';
import 'package:foody_licious/domain/usecase/user/sign_up_with_email_usecase.dart';
import 'package:foody_licious/domain/usecase/user/sign_up_with_phone_usecase.dart';

import '../../../../core/error/failures.dart';
import '../entities/user/user.dart';
// import '../usecases/user/sign_in_usecase.dart';
// import '../usecases/user/sign_up_usecase.dart';

abstract class UserRepository {
  Future<Either<Failure, User>> signIn(SignInParams params);
  Future<Either<Failure, User>> signUpWithEmail(SignUpWithEmailParams params);
  Future<Either<Failure, Unit>> verifyPhoneNumber(SignUpWithPhoneParams params);
  Future<Either<Failure, User>> signUpWithPhone(SignUpWithPhoneParams params);
  Future<Either<Failure, Unit>> sendVerificationEmail();
  Future<Either<Failure, Unit>> waitForEmailVerification();
  // Future<Either<Failure, User>> signUpWithGoogle(SignUpParams params);
  // Future<Either<Failure, User>> signUpWithFacebook(SignUpParams params);
  Future<Either<Failure, NoParams>> signOut();
  Future<Either<Failure, User>> getLocalUser();
}
