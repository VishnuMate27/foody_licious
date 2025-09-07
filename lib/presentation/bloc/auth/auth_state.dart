part of 'auth_bloc.dart';

@immutable
abstract class AuthState extends Equatable {}

class AuthInitial extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthLoading extends AuthState {
  @override
  List<Object> get props => [];
}

// class UserLogged extends UserState {
//   final User user;
//   UserLogged(this.user);
//   @override
//   List<Object> get props => [user];
// }

class AuthLoggedFail extends AuthState {
  final Failure failure;
  AuthLoggedFail(this.failure);
  @override
  List<Object> get props => [failure];
}

class AuthSignInWithEmailSuccess extends AuthState {
  final User user;
  AuthSignInWithEmailSuccess(this.user);
  @override
  List<Object> get props => [user];
}

class AuthSignInWithEmailFailed extends AuthState {
  final Failure failure;
  AuthSignInWithEmailFailed(this.failure);
  @override
  List<Object> get props => [failure];
}

class AuthVerificationSMSForLoginSent extends AuthState {
  final Unit unit;
  AuthVerificationSMSForLoginSent(this.unit);
  @override
  List<Object> get props => [unit];
}

class AuthVerificationSMSForLoginSentFailed extends AuthState {
  final Failure failure;
  AuthVerificationSMSForLoginSentFailed(this.failure);
  @override
  List<Object> get props => [failure];
}

class AuthPhoneVerificationForLoginSuccess extends AuthState {
  final User user;
  AuthPhoneVerificationForLoginSuccess(this.user);
  @override
  List<Object> get props => [user];
}

class AuthPhoneVerificationForLoginFailed extends AuthState {
  final Failure failure;
  AuthPhoneVerificationForLoginFailed(this.failure);
  @override
  List<Object> get props => [failure];
}

class AuthGoogleSignInSuccess extends AuthState {
  final User user;
  AuthGoogleSignInSuccess(this.user);
  @override
  List<Object> get props => [user];
}

class AuthGoogleSignInFailed extends AuthState {
  final Failure failure;
  AuthGoogleSignInFailed(this.failure);
  @override
  List<Object> get props => [failure];
}

class AuthFacebookSignInSuccess extends AuthState {
  final User user;
  AuthFacebookSignInSuccess(this.user);
  @override
  List<Object> get props => [user];
}

class AuthFacebookSignInFailed extends AuthState {
  final Failure failure;
  AuthFacebookSignInFailed(this.failure);
  @override
  List<Object> get props => [failure];
}

class AuthPasswordResetEmailSent extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthPasswordResetEmailSentFailed extends AuthState {
  final Failure failure;
  AuthPasswordResetEmailSentFailed(this.failure);
  @override
  List<Object> get props => [failure];
}

class AuthVerificationEmailRequested extends AuthState {
  final User user;
  AuthVerificationEmailRequested(this.user);
  @override
  List<Object> get props => [user];
}

class AuthVerificationEmailRequestFailed extends AuthState {
  final Failure failure;
  AuthVerificationEmailRequestFailed(this.failure);
  @override
  List<Object> get props => [failure];
}

class AuthVerificationEmailSent extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthVerificationEmailSentFailed extends AuthState {
  final Failure failure;
  AuthVerificationEmailSentFailed(this.failure);
  @override
  List<Object> get props => [failure];
}

class AuthEmailVerificationSuccess extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthEmailVerificationFailed extends AuthState {
  final Failure failure;
  AuthEmailVerificationFailed(this.failure);
  @override
  List<Object> get props => [failure];
}

class AuthVerificationSMSForRegistrationSent extends AuthState {
  final Unit unit;
  AuthVerificationSMSForRegistrationSent(this.unit);
  @override
  List<Object> get props => [unit];
}

class AuthVerificationSMSForRegistrationSentFailed extends AuthState {
  final Failure failure;
  AuthVerificationSMSForRegistrationSentFailed(this.failure);
  @override
  List<Object> get props => [failure];
}

class AuthPhoneVerificationForRegistrationSuccess extends AuthState {
  final User user;
  AuthPhoneVerificationForRegistrationSuccess(this.user);
  @override
  List<Object> get props => [user];
}

class AuthPhoneVerificationForRegistrationFailed extends AuthState {
  final Failure failure;
  AuthPhoneVerificationForRegistrationFailed(this.failure);
  @override
  List<Object> get props => [failure];
}

class AuthGoogleSignUpSuccess extends AuthState {
  final User user;
  AuthGoogleSignUpSuccess(this.user);
  @override
  List<Object> get props => [user];
}

class AuthGoogleSignUpFailed extends AuthState {
  final Failure failure;
  AuthGoogleSignUpFailed(this.failure);
  @override
  List<Object> get props => [failure];
}

class AuthFacebookSignUpSuccess extends AuthState {
  final User user;
  AuthFacebookSignUpSuccess(this.user);
  @override
  List<Object> get props => [user];
}

class AuthFacebookSignUpFailed extends AuthState {
  final Failure failure;
  AuthFacebookSignUpFailed(this.failure);
  @override
  List<Object> get props => [failure];
}

class AuthLoggedOut extends AuthState {
  @override
  List<Object> get props => [];
}

class InputValidationState extends AuthState {
  final bool isEmail;
  final bool isPhone;
  final bool isValid;
  final String inputType;

  InputValidationState({
    required this.isEmail,
    required this.isPhone,
    required this.isValid,
    required this.inputType,
  });

  @override
  List<Object> get props => [isEmail, isValid, inputType];
}
