import 'package:dartz/dartz.dart';
import 'package:foody_licious/core/usecase/usecase.dart';
import '../../../../../core/error/failures.dart';
import '../../entities/user/user.dart';
import '../../repositories/user_repository.dart';

class SignUpWithEmailUseCase implements UseCase<User, SignUpWithEmailParams> {
  final UserRepository repository;
  SignUpWithEmailUseCase(this.repository);

  @override
  Future<Either<Failure, User>> call(SignUpWithEmailParams params) async {
    return await repository.signUpWithEmail(params);
  }
}

class SignUpWithEmailParams {
  final String? name;
  final String? email;
  final String? password;
  final String authProvider;
  const SignUpWithEmailParams(
      {this.name,
      this.email,
      this.password,
      required this.authProvider});
}
