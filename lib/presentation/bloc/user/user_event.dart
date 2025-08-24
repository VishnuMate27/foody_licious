part of 'user_bloc.dart';

@immutable
abstract class UserEvent {}

class SignInUser extends UserEvent {
  final SignInParams params;
  SignInUser(this.params);
}

class SignUpWithEmailUser extends UserEvent {
  final SignUpWithEmailParams params;
  SignUpWithEmailUser(this.params);
}
class VerifyPhoneNumberUser extends UserEvent {
  final SignUpWithPhoneParams params;
  VerifyPhoneNumberUser(this.params);
}

class SignUpWithPhoneUser extends UserEvent {
  final SignUpWithPhoneParams params;
  SignUpWithPhoneUser(this.params);
}

class SignOutUser extends UserEvent {}

class CheckUser extends UserEvent {}

class ValidateEmailOrPhone extends UserEvent {
  final String input;

  ValidateEmailOrPhone(this.input);

  @override
  List<Object> get props => [input];
}

class SendVerificationEmailUser extends UserEvent {}

class WaitForEmailVerificationUser extends UserEvent {}
