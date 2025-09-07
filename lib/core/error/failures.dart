import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object> get props => [];
}

// General failures
class ServerFailure extends Failure {}

class CacheFailure extends Failure {}

class NetworkFailure extends Failure {}

class ExceptionFailure extends Failure {}

class CredentialFailure extends Failure {}

// ignore: must_be_immutable
class AuthenticationFailure extends Failure {
  String? failureMessage;
  AuthenticationFailure(this.failureMessage);
}

class UserNotExistsFailure extends Failure {}

class TimeOutFailure extends Failure {}

class UserAlreadyExistsFailure extends Failure {}

class TooManyRequestsFailure extends Failure {}

class AuthProviderMissMatchFailure extends Failure {}

class LocationServicesDisabledFailure extends Failure {}

class LocationPermissionDeniedFailure extends Failure {}

class LocationPermissionPermanentlyDeniedFailure extends Failure {}