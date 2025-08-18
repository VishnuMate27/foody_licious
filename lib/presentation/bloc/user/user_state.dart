part of 'user_bloc.dart';

@immutable
abstract class UserState extends Equatable {}

class UserInitial extends UserState {
  @override
  List<Object> get props => [];
}

class UserLoading extends UserState {
  @override
  List<Object> get props => [];
}

class UserLogged extends UserState {
  final User user;
  UserLogged(this.user);
  @override
  List<Object> get props => [user];
}

class UserLoggedFail extends UserState {
  final Failure failure;
  UserLoggedFail(this.failure);
  @override
  List<Object> get props => [failure];
}

class UserLoggedOut extends UserState {
  @override
  List<Object> get props => [];
}

class InputValidationState extends UserState {
  final bool isEmail;
  final bool isValid;
  final String inputType;
  
  InputValidationState({
    required this.isEmail,
    required this.isValid,
    required this.inputType,
  });
  
  @override
  List<Object> get props => [isEmail, isValid, inputType];
}