import 'package:dartz/dartz.dart';
import 'package:foody_licious/core/error/failures.dart';
import 'package:foody_licious/core/usecase/usecase.dart';
import 'package:foody_licious/domain/repositories/user_repository.dart';

class WaitForEmailVerificationUsecase implements UseCase<Unit, void> {
  final UserRepository repository;
  WaitForEmailVerificationUsecase(this.repository);

  @override
  Future<Either<Failure, Unit>> call(void params) async {
    return await repository.waitForEmailVerification();
  }
}