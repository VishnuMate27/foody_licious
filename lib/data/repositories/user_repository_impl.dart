import 'package:dartz/dartz.dart';
import 'package:foody_licious/core/error/failures.dart';
import 'package:foody_licious/data/data_sources/local/user_local_data_source.dart';
import 'package:foody_licious/domain/entities/user/user.dart';
import 'package:foody_licious/domain/repositories/user_repository.dart';
import 'package:foody_licious/presentation/bloc/user/user_state.dart';

class UserRepositoryImpl implements UserRepository {
  final UserLocalDataSource localDataSource;
  UserRepositoryImpl(this.localDataSource);

  @override
  Future<Either<Failure, User>> checkUser() async{
    try {
      final localResponse = await localDataSource.getUser();
      return Right(localResponse);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }
}
