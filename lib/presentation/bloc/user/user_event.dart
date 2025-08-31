part of 'user_bloc.dart';

@immutable
abstract class UserEvent {}

class SignInWithEmailUser extends UserEvent {
  final SignInWithEmailParams params;
  SignInWithEmailUser(this.params);
}

class VerifyPhoneNumberForLoginUser extends UserEvent {
  final SignInWithPhoneParams params;
  VerifyPhoneNumberForLoginUser(this.params);
}

class SignInWithPhoneUser extends UserEvent {
  final SignInWithPhoneParams params;
  SignInWithPhoneUser(this.params);
}

class SignInWithGoogleUser extends UserEvent {}

class SignInWithFacebookUser extends UserEvent {}

class SignUpWithEmailUser extends UserEvent {
  final SignUpWithEmailParams params;
  SignUpWithEmailUser(this.params);
}

class SendVerificationEmailUser extends UserEvent {}

class WaitForEmailVerificationUser extends UserEvent {}

class VerifyPhoneNumberForRegistrationUser extends UserEvent {
  final SignUpWithPhoneParams params;
  VerifyPhoneNumberForRegistrationUser(this.params);
}

class SignUpWithPhoneUser extends UserEvent {
  final SignUpWithPhoneParams params;
  SignUpWithPhoneUser(this.params);
}

class SignUpWithGoogleUser extends UserEvent {}

class SignUpWithFacebookUser extends UserEvent {}

class SignOutUser extends UserEvent {}

class CheckUser extends UserEvent {}

class ValidateEmailOrPhone extends UserEvent {
  final String input;

  ValidateEmailOrPhone(this.input);

  @override
  List<Object> get props => [input];
}
