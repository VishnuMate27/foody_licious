part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class AuthSignInWithEmail extends AuthEvent {
  final SignInWithEmailParams params;
  AuthSignInWithEmail(this.params);
}

class AuthVerifyPhoneNumberForLogin extends AuthEvent {
  final SignInWithPhoneParams params;
  AuthVerifyPhoneNumberForLogin(this.params);
}

class AuthSignInWithPhone extends AuthEvent {
  final SignInWithPhoneParams params;
  AuthSignInWithPhone(this.params);
}

class AuthSignInWithGoogle extends AuthEvent {}

class AuthSignInWithFacebook extends AuthEvent {}

class AuthSendPasswordResetEmail extends AuthEvent {
  final SendPasswordResetEmailParams params;
  AuthSendPasswordResetEmail(this.params);
}

class AuthSignUpWithEmail extends AuthEvent {
  final SignUpWithEmailParams params;
  AuthSignUpWithEmail(this.params);
}

class AuthSendVerificationEmail extends AuthEvent {}

class AuthWaitForEmailVerification extends AuthEvent {}

class AuthVerifyPhoneNumberForRegistration extends AuthEvent {
  final SignUpWithPhoneParams params;
  AuthVerifyPhoneNumberForRegistration(this.params);
}

class AuthSignUpWithPhone extends AuthEvent {
  final SignUpWithPhoneParams params;
  AuthSignUpWithPhone(this.params);
}

class AuthSignUpWithGoogle extends AuthEvent {}

class AuthSignUpWithFacebook extends AuthEvent {}

class AuthSignOut extends AuthEvent {}

class AuthCheck extends AuthEvent {}

class ValidateEmailOrPhone extends AuthEvent {
  final String input;

  ValidateEmailOrPhone(this.input);

  @override
  List<Object> get props => [input];
}
