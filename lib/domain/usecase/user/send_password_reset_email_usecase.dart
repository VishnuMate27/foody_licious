import 'package:dartz/dartz.dart';
import 'package:foody_licious/core/error/failures.dart';
import 'package:foody_licious/core/usecase/usecase.dart';
import 'package:foody_licious/domain/repositories/user_repository.dart';

class SendPasswordResetEmailUseCase
    implements UseCase<Unit, SendPasswordResetEmailParams> {
  final AuthRepository repository;
  SendPasswordResetEmailUseCase(this.repository);

  @override
  Future<Either<Failure, Unit>> call(
      SendPasswordResetEmailParams params) async {
    return await repository.sendPasswordResetEmail(params);
  }
}

class SendPasswordResetEmailParams {
  final String email;
  const SendPasswordResetEmailParams({
    required this.email,
  });
}
