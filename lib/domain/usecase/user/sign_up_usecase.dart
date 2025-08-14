import 'package:dartz/dartz.dart';
import 'package:foody_licious/core/usecase/usecase.dart';
import '../../../../../core/error/failures.dart';
import '../../entities/user/user.dart';
import '../../repositories/user_repository.dart';

class SignUpUseCase implements UseCase<User, SignUpParams> {
  final UserRepository repository;
  SignUpUseCase(this.repository);

  @override
  Future<Either<Failure, User>> call(SignUpParams params) async {
    return await repository.signUp(params);
  }
}

class SignUpParams {
  final String name;
  final String? email;
  final String? phone;
  final String password;
  final String authProvider;
  const SignUpParams({
    required this.name,
    this.email,
    this.phone,
    required this.password,
    required this.authProvider
  });
}