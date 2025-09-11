import 'package:dartz/dartz.dart';
import 'package:foody_licious/core/error/failures.dart';
import 'package:foody_licious/core/usecase/usecase.dart';
import 'package:foody_licious/domain/repositories/user_repository.dart';

class DeleteUserUseCase extends UseCase<Unit, void> {
  final UserRepository repository;
  DeleteUserUseCase(this.repository);

  @override
  Future<Either<Failure, Unit>> call(void params) async {
    return await repository.deleteUser();
  }
}
