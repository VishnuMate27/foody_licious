import 'package:dartz/dartz.dart';
import 'package:foody_licious/core/error/failures.dart';
import 'package:foody_licious/core/network/network_info.dart';
import 'package:foody_licious/data/data_sources/local/user_local_data_source.dart';
import 'package:foody_licious/data/data_sources/remote/user_remote_data_source.dart';
import 'package:foody_licious/domain/entities/user/user.dart';
import 'package:foody_licious/domain/repositories/user_repository.dart';
import 'package:foody_licious/domain/usecase/user/update_user_usecase.dart';
import 'package:foody_licious/presentation/bloc/user/user_state.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;
  final UserLocalDataSource localDataSource;
  final NetworkInfo networkInfo;
  UserRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, User>> checkUser() async {
    try {
      final user = await localDataSource.getUser();
      return Right(user);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, User>> updateUser(UpdateUserParams params) async {
    if (!await networkInfo.isConnected) {
      return Left(NetworkFailure());
    }
    try {
      final user = await localDataSource.getUser();
      params.id = user.id;
      final remoteResponse = await remoteDataSource.updateUser(params);
      await localDataSource.saveUser(remoteResponse.user);
      return Right(remoteResponse.user);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, User>> updateUserLocation() async {
    if (!await networkInfo.isConnected) {
      return Left(NetworkFailure());
    }
    try {
      final user = await localDataSource.getUser();
      final remoteResponse = await remoteDataSource.updateUserLocation(user.id);
      await localDataSource.saveUser(remoteResponse.user);
      return Right(remoteResponse.user);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteUser() async {
    if (!await networkInfo.isConnected) {
      return Left(NetworkFailure());
    }
    try {
      final user = await localDataSource.getUser();
      final remoteResponse = await remoteDataSource.deleteUser(user.id);
      await localDataSource.clearCache();
      return Right(remoteResponse);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }
}
