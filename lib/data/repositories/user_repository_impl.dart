import 'package:dartz/dartz.dart';
import 'package:foody_licious/core/usecase/usecase.dart';
import 'package:foody_licious/data/data_sources/local/user_local_data_source.dart';

import '../../../../core/error/failures.dart';
import '../../core/network/network_info.dart';
import '../../domain/entities/user/user.dart';
import '../../domain/repositories/user_repository.dart';
import '../data_sources/remote/user_remote_data_source.dart';
import '../models/user/authentication_response_model.dart';

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
  Future<Either<Failure, User>> signIn(params) async {
    if (!await networkInfo.isConnected) {
      return Left(NetworkFailure());
    }
    try {
      final remoteResponse = await remoteDataSource.signIn(params);
      return Right(remoteResponse.user);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, User>> signUpWithEmail(params) async {
    if (!await networkInfo.isConnected) {
      return Left(NetworkFailure());
    }
    try {
      final remoteResponse = await remoteDataSource.signUpWithEmail(params);
      return Right(remoteResponse.user);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }
  
  @override
  Future<Either<Failure, Unit>> sendVerificationEmail() async {
    if (!await networkInfo.isConnected) {
      return Left(NetworkFailure());
    }
    try {
      final remoteResponse = await remoteDataSource.sendVerificationEmail();
      return Right(remoteResponse);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, Unit>> waitForEmailVerification() async {
    if (!await networkInfo.isConnected) {
      return Left(NetworkFailure());
    }
    try {
      final remoteResponse = await remoteDataSource.waitForEmailVerification();
      return Right(remoteResponse);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, Unit>> verifyPhoneNumber(params) async {
    if (!await networkInfo.isConnected) {
      return Left(NetworkFailure());
    }
    try {
      final remoteResponse = await remoteDataSource.verifyPhoneNumber(params);
      return Right(remoteResponse);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, User>> signUpWithPhone(params) async {
    if (!await networkInfo.isConnected) {
      return Left(NetworkFailure());
    }
    try {
      final remoteResponse = await remoteDataSource.signUpWithPhone(params);
      return Right(remoteResponse.user);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, User>> signUpWithGoogle() async {
    if (!await networkInfo.isConnected) {
      return Left(NetworkFailure());
    }
    try {
      final remoteResponse = await remoteDataSource.signUpWithGoogle();
      return Right(remoteResponse.user);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, User>> signUpWithFacebook() async {
    if (!await networkInfo.isConnected) {
      return Left(NetworkFailure());
    }
    try {
      final remoteResponse = await remoteDataSource.signUpWithFacebook();
      return Right(remoteResponse.user);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, NoParams>> signOut() async {
    try {
      await localDataSource.clearCache();
      return Right(NoParams());
    } on CacheFailure {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, User>> getLocalUser() async {
    try {
      final user = await localDataSource.getUser();
      return Right(user);
    } on CacheFailure {
      return Left(CacheFailure());
    }
  }
}
