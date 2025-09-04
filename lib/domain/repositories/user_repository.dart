import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:foody_licious/core/error/failures.dart';

abstract class UserRepository {
  Future<Either<Failure, User>> checkUser();
}
