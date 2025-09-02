import 'package:dartz/dartz.dart';
import 'package:foody_licious/core/usecase/usecase.dart';
import '../../../../../core/error/failures.dart';
import '../../entities/user/user.dart';
import '../../repositories/user_repository.dart';

class SignUpWithPhoneUseCase implements UseCase<User, SignUpWithPhoneParams> {
  final AuthRepository repository;
  SignUpWithPhoneUseCase(this.repository);

  @override
  Future<Either<Failure, User>> call(SignUpWithPhoneParams params) async {
    return await repository.signUpWithPhone(params);
  }
}

class SignUpWithPhoneParams {
  final String? name;
  final String? phone;
  final String? code;
  final String authProvider;
  const SignUpWithPhoneParams(
      {this.name, this.phone, this.code, required this.authProvider});
}
