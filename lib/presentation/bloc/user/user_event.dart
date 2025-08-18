part of 'user_bloc.dart';

@immutable
abstract class UserEvent {}

class SignInUser extends UserEvent {
  final SignInParams params;
  SignInUser(this.params);
}

class SignUpUser extends UserEvent {
  final SignUpParams params;
  SignUpUser(this.params);
}

class SignOutUser extends UserEvent {}

class CheckUser extends UserEvent {}

class ValidateEmailOrPhone extends UserEvent {
  final String input;
  
  ValidateEmailOrPhone(this.input);
  
  @override
  List<Object> get props => [input];
}