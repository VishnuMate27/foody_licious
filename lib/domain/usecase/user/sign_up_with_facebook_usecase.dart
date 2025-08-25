import 'package:dartz/dartz.dart';
import 'package:foody_licious/core/error/failures.dart';
import 'package:foody_licious/core/usecase/usecase.dart';
import 'package:foody_licious/domain/entities/user/user.dart';
import 'package:foody_licious/domain/repositories/user_repository.dart';

class SignUpWithFacebookUseCase implements UseCase<User, NoParams> {
  final UserRepository repository;
  SignUpWithFacebookUseCase(this.repository);

  @override
  Future<Either<Failure, User>> call(void params) async {
    return await repository.signUpWithFacebook();
  }
}