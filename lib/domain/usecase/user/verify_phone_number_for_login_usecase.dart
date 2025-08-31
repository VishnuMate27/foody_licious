import 'package:dartz/dartz.dart';
import 'package:foody_licious/core/error/failures.dart';
import 'package:foody_licious/core/usecase/usecase.dart';
import 'package:foody_licious/domain/repositories/user_repository.dart';
import 'package:foody_licious/domain/usecase/user/sign_in_with_phone_usecase.dart';

class VerifyPhoneNumberForLoginUseCase
    implements UseCase<Unit, SignInWithPhoneParams> {
  final UserRepository repository;
  VerifyPhoneNumberForLoginUseCase(this.repository);

  @override
  Future<Either<Failure, Unit>> call(SignInWithPhoneParams params) async {
    return await repository.verifyPhoneNumberForLogin(params);
  }
}
