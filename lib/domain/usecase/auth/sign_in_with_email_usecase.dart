import 'package:dartz/dartz.dart';
import 'package:foody_licious/core/usecase/usecase.dart';

import '../../../../../core/error/failures.dart';
import '../../entities/user/user.dart';
import '../../repositories/auth_repository.dart';

class SignInWithEmailUseCase implements UseCase<User, SignInWithEmailParams> {
  final AuthRepository repository;
  SignInWithEmailUseCase(this.repository);

  @override
  Future<Either<Failure, User>> call(SignInWithEmailParams params) async {
    return await repository.signInWithEmail(params);
  }
}

class SignInWithEmailParams {
  final String email;
  final String password;
  final String authProvider;
  const SignInWithEmailParams({
    required this.email,
    required this.password,
    required this.authProvider,
  });
}
