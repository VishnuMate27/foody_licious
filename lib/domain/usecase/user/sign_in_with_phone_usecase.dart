import 'package:dartz/dartz.dart';
import 'package:foody_licious/core/error/failures.dart';
import 'package:foody_licious/core/usecase/usecase.dart';
import 'package:foody_licious/domain/entities/user/user.dart';
import 'package:foody_licious/domain/repositories/user_repository.dart';

class SignInWithPhoneUseCase implements UseCase<User, SignInWithPhoneParams> {
  final UserRepository repository;
  SignInWithPhoneUseCase(this.repository);

  @override
  Future<Either<Failure, User>> call(SignInWithPhoneParams params) async {
    return await repository.signInWithPhone(params);
  }
}

class SignInWithPhoneParams {
  final String? phone;
  final String? code;
  final String authProvider;
  const SignInWithPhoneParams(
      {this.phone, this.code, required this.authProvider});
}
