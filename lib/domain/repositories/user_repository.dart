import 'package:dartz/dartz.dart';
import 'package:foody_licious/core/error/failures.dart';
import 'package:foody_licious/domain/entities/user/user.dart';
import 'package:foody_licious/domain/usecase/user/update_user_usecase.dart';
import 'package:geolocator/geolocator.dart';

abstract class UserRepository {
  Future<Either<Failure, User>> checkUser();
  Future<Either<Failure, User>> updateUser(UpdateUserParams params);
  Future<Either<Failure, User>> updateUserLocation();
}
