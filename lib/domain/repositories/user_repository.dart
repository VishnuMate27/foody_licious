import 'package:dartz/dartz.dart';
import 'package:foody_licious/core/error/failures.dart';
import 'package:foody_licious/domain/entities/user/user.dart';

abstract class UserRepository {
  Future<Either<Failure, User>> checkUser();
}
