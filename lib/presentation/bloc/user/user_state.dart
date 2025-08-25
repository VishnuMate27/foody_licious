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

class UserEmailVerificationSuccess extends UserState {
  @override
  List<Object> get props => [];
}

class UserVerificationEmailRequested extends UserState {
  final User user;
  UserVerificationEmailRequested(this.user);
  @override
  List<Object> get props => [user];
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

class UserPhoneVerificationSuccess extends UserState {
  final User user;
  UserPhoneVerificationSuccess(this.user);
  @override
  List<Object> get props => [user];
}
class UserGoogleSignUpSuccess extends UserState {
  final User user;
  UserGoogleSignUpSuccess(this.user);
  @override
  List<Object> get props => [user];
}

class UserFacebookSignUpSuccess extends UserState {
  final User user;
  UserFacebookSignUpSuccess(this.user);
  @override
  List<Object> get props => [user];
}

class UserVerificationSMSSent extends UserState {
  final Unit unit;
  UserVerificationSMSSent(this.unit);
  @override
  List<Object> get props => [unit];
}

class UserVerificationSMSSentFailed extends UserState {
  final Failure failure;
  UserVerificationSMSSentFailed(this.failure);
  @override
  List<Object> get props => [failure];
}
