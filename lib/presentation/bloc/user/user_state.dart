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

class UserSignInWithEmailSuccess extends UserState {
  final User user;
  UserSignInWithEmailSuccess(this.user);
  @override
  List<Object> get props => [user];
}

class UserSignInWithEmailFailed extends UserState {
  final Failure failure;
  UserSignInWithEmailFailed(this.failure);
  @override
  List<Object> get props => [failure];
}

class UserVerificationSMSForLoginSent extends UserState {
  final Unit unit;
  UserVerificationSMSForLoginSent(this.unit);
  @override
  List<Object> get props => [unit];
}

class UserVerificationSMSForLoginSentFailed extends UserState {
  final Failure failure;
  UserVerificationSMSForLoginSentFailed(this.failure);
  @override
  List<Object> get props => [failure];
}

class UserPhoneVerificationForLoginSuccess extends UserState {
  final User user;
  UserPhoneVerificationForLoginSuccess(this.user);
  @override
  List<Object> get props => [user];
}

class UserPhoneVerificationForLoginFailed extends UserState {
  final Failure failure;
  UserPhoneVerificationForLoginFailed(this.failure);
  @override
  List<Object> get props => [failure];
}

class UserGoogleSignInSuccess extends UserState {
  final User user;
  UserGoogleSignInSuccess(this.user);
  @override
  List<Object> get props => [user];
}

class UserGoogleSignInFailed extends UserState {
  final Failure failure;
  UserGoogleSignInFailed(this.failure);
  @override
  List<Object> get props => [failure];
}

class UserFacebookSignInSuccess extends UserState {
  final User user;
  UserFacebookSignInSuccess(this.user);
  @override
  List<Object> get props => [user];
}

class UserFacebookSignInFailed extends UserState {
  final Failure failure;
  UserFacebookSignInFailed(this.failure);
  @override
  List<Object> get props => [failure];
}

class UserPasswordResetEmailSent extends UserState {
  @override
  List<Object> get props => [];
}

class UserPasswordResetEmailSentFailed extends UserState {
  final Failure failure;
  UserPasswordResetEmailSentFailed(this.failure);
  @override
  List<Object> get props => [failure];
}

class UserVerificationEmailRequested extends UserState {
  final User user;
  UserVerificationEmailRequested(this.user);
  @override
  List<Object> get props => [user];
}

class UserVerificationEmailRequestFailed extends UserState {
  final Failure failure;
  UserVerificationEmailRequestFailed(this.failure);
  @override
  List<Object> get props => [failure];
}

class UserVerificationEmailSent extends UserState {
  @override
  List<Object> get props => [];
}

class UserVerificationEmailSentFailed extends UserState {
  final Failure failure;
  UserVerificationEmailSentFailed(this.failure);
  @override
  List<Object> get props => [failure];
}

class UserEmailVerificationSuccess extends UserState {
  @override
  List<Object> get props => [];
}

class UserEmailVerificationFailed extends UserState {
  final Failure failure;
  UserEmailVerificationFailed(this.failure);
  @override
  List<Object> get props => [failure];
}

class UserVerificationSMSForRegistrationSent extends UserState {
  final Unit unit;
  UserVerificationSMSForRegistrationSent(this.unit);
  @override
  List<Object> get props => [unit];
}

class UserVerificationSMSForRegistrationSentFailed extends UserState {
  final Failure failure;
  UserVerificationSMSForRegistrationSentFailed(this.failure);
  @override
  List<Object> get props => [failure];
}

class UserPhoneVerificationForRegistrationSuccess extends UserState {
  final User user;
  UserPhoneVerificationForRegistrationSuccess(this.user);
  @override
  List<Object> get props => [user];
}

class UserPhoneVerificationForRegistrationFailed extends UserState {
  final Failure failure;
  UserPhoneVerificationForRegistrationFailed(this.failure);
  @override
  List<Object> get props => [failure];
}

class UserGoogleSignUpSuccess extends UserState {
  final User user;
  UserGoogleSignUpSuccess(this.user);
  @override
  List<Object> get props => [user];
}

class UserGoogleSignUpFailed extends UserState {
  final Failure failure;
  UserGoogleSignUpFailed(this.failure);
  @override
  List<Object> get props => [failure];
}

class UserFacebookSignUpSuccess extends UserState {
  final User user;
  UserFacebookSignUpSuccess(this.user);
  @override
  List<Object> get props => [user];
}

class UserFacebookSignUpFailed extends UserState {
  final Failure failure;
  UserFacebookSignUpFailed(this.failure);
  @override
  List<Object> get props => [failure];
}

class UserLoggedOut extends UserState {
  @override
  List<Object> get props => [];
}

class InputValidationState extends UserState {
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
