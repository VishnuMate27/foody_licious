import 'package:dartz/dartz.dart';
import 'package:foody_licious/core/usecase/usecase.dart';
import '../../../../../core/error/failures.dart';
import '../../entities/user/user.dart';
import '../../repositories/user_repository.dart';

class SignUpWithPhoneUseCase implements UseCase<Unit, SignUpWithPhoneParams> {
  final UserRepository repository;
  SignUpWithPhoneUseCase(this.repository);

  @override
  Future<Either<Failure, Unit>> call(SignUpWithPhoneParams params) async {
    return await repository.signUpWithPhone(params);
  }
}

class SignUpWithPhoneParams {
  final String? name;
  final String? phone;
  final String authProvider;
  const SignUpWithPhoneParams(
      {this.name,
      this.phone,
      required this.authProvider});
}
