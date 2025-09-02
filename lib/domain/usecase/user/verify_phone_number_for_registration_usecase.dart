import 'package:dartz/dartz.dart';
import 'package:foody_licious/core/error/failures.dart';
import 'package:foody_licious/core/usecase/usecase.dart';
import 'package:foody_licious/domain/repositories/user_repository.dart';
import 'package:foody_licious/domain/usecase/user/sign_up_with_phone_usecase.dart';

class VerifyPhoneNumberForRegistrationUseCase
    implements UseCase<Unit, SignUpWithPhoneParams> {
  final AuthRepository repository;
  VerifyPhoneNumberForRegistrationUseCase(this.repository);

  @override
  Future<Either<Failure, Unit>> call(SignUpWithPhoneParams params) async {
    return await repository.verifyPhoneNumberForRegistration(params);
  }
}
