import 'package:dartz/dartz.dart';
import 'package:foody_licious/core/error/failures.dart';
import 'package:foody_licious/core/usecase/usecase.dart';
import 'package:foody_licious/domain/entities/user/user.dart';
import 'package:foody_licious/domain/repositories/user_repository.dart';

class CheckUserUseCase extends UseCase<User, void> {
  final UserRepository repository;
  CheckUserUseCase(this.repository);

  @override
  Future<Either<Failure, User>> call(void params) async {
    return await repository.checkUser();
  }
}
