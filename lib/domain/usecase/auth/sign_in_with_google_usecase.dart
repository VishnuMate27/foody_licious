import 'package:dartz/dartz.dart';
import 'package:foody_licious/core/error/failures.dart';
import 'package:foody_licious/core/usecase/usecase.dart';
import 'package:foody_licious/domain/entities/user/user.dart';
import 'package:foody_licious/domain/repositories/auth_repository.dart';

class SignInWithGoogleUseCase implements UseCase<User, NoParams> {
  final AuthRepository repository;
  SignInWithGoogleUseCase(this.repository);

  @override
  Future<Either<Failure, User>> call(void params) async {
    return await repository.signInWithGoogle();
  }
}
