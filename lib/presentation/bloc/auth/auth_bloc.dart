import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:foody_licious/core/constant/validators.dart';
import 'package:foody_licious/core/usecase/usecase.dart';
import 'package:foody_licious/domain/usecase/auth/send_password_reset_email_usecase.dart';
import 'package:foody_licious/domain/usecase/auth/send_verification_email_usecase.dart';
import 'package:foody_licious/domain/usecase/auth/sign_in_with_email_usecase.dart';
import 'package:foody_licious/domain/usecase/auth/sign_in_with_facebook.dart';
import 'package:foody_licious/domain/usecase/auth/sign_in_with_google_usecase.dart';
import 'package:foody_licious/domain/usecase/auth/sign_in_with_phone_usecase.dart';
import 'package:foody_licious/domain/usecase/auth/sign_up_with_email_usecase.dart';
import 'package:foody_licious/domain/usecase/auth/sign_up_with_facebook_usecase.dart';
import 'package:foody_licious/domain/usecase/auth/sign_up_with_google_usecase.dart';
import 'package:foody_licious/domain/usecase/auth/sign_up_with_phone_usecase.dart';
import 'package:foody_licious/domain/usecase/auth/verify_phone_number_for_login_usecase.dart';
import 'package:foody_licious/domain/usecase/auth/verify_phone_number_for_registration_usecase.dart';
import 'package:foody_licious/domain/usecase/auth/wait_for_email_verification_usecase.dart';

import '../../../core/error/failures.dart';
import '../../../domain/entities/user/user.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignInWithEmailUseCase _signInWithEmailUseCase;
  final VerifyPhoneNumberForLoginUseCase _verifyPhoneNumberForLoginUseCase;
  final SignInWithPhoneUseCase _signInWithPhoneUseCase;
  final SignInWithGoogleUseCase _signInWithGoogleUseCase;
  final SignInWithFacebookUseCase _signInWithFacebookUseCase;
  final SendPasswordResetEmailUseCase _sendPasswordResetEmailUseCase;
  final SignUpWithEmailUseCase _signUpWithEmailUseCase;
  final SendVerificationEmailUseCase _sendVerificationEmailUseCase;
  final WaitForEmailVerificationUsecase _waitForEmailVerificationUseCase;
  final VerifyPhoneNumberForRegistrationUseCase
      _verifyPhoneNumberForRegistrationUseCase;
  final SignUpWithPhoneUseCase _signUpWithPhoneUseCase;
  final SignUpWithGoogleUseCase _signUpWithGoogleUseCase;
  final SignUpWithFacebookUseCase _signUpWithFacebookUseCase;
  AuthBloc(
    this._signInWithEmailUseCase,
    this._verifyPhoneNumberForLoginUseCase,
    this._signInWithPhoneUseCase,
    this._signInWithGoogleUseCase,
    this._signInWithFacebookUseCase,
    this._sendPasswordResetEmailUseCase,
    this._signUpWithEmailUseCase,
    this._sendVerificationEmailUseCase,
    this._waitForEmailVerificationUseCase,
    this._verifyPhoneNumberForRegistrationUseCase,
    this._signUpWithPhoneUseCase,
    this._signUpWithGoogleUseCase,
    this._signUpWithFacebookUseCase,
  ) : super(AuthInitial()) {
    on<AuthSignInWithEmail>(_onSignInWithEmail);
    on<AuthVerifyPhoneNumberForLogin>(_onVerifyPhoneNumberForLogin);
    on<AuthSignInWithPhone>(_onSignInWithPhone);
    on<AuthSignInWithGoogle>(_onSignInWithGoogle);
    on<AuthSignInWithFacebook>(_onSignInWithFacebook);
    on<AuthSendPasswordResetEmail>(_onSendPasswordResetEmail);
    on<AuthSignUpWithEmail>(_onSignUpWithEmail);
    on<AuthSendVerificationEmail>(_onSendVerificationEmail);
    on<AuthWaitForEmailVerification>(_onWaitForEmailVerification);
    on<AuthVerifyPhoneNumberForRegistration>(
        _onVerifyPhoneNumberForRegistration);
    on<AuthSignUpWithPhone>(_onSignUpWithPhone);
    on<AuthSignUpWithGoogle>(_onSignUpWithGoogle);
    on<AuthSignUpWithFacebook>(_onSignUpWithFacebook);
    on<AuthCheck>(_onCheckAuth);
    on<AuthSignOut>(_onSignOut);
    on<ValidateEmailOrPhone>(_onValidateEmailOrPhone);
  }

  void _onSignInWithEmail(
      AuthSignInWithEmail event, Emitter<AuthState> emit) async {
    try {
      emit(AuthLoading());
      final result = await _signInWithEmailUseCase(event.params);
      result.fold(
        (failure) => emit(AuthSignInWithEmailFailed(failure)),
        (user) => emit(AuthSignInWithEmailSuccess(user)),
      );
    } catch (e) {
      emit(AuthSignInWithEmailFailed(ExceptionFailure()));
    }
  }

  FutureOr<void> _onVerifyPhoneNumberForLogin(
      AuthVerifyPhoneNumberForLogin event, Emitter<AuthState> emit) async {
    try {
      emit(AuthLoading());
      final result = await _verifyPhoneNumberForLoginUseCase(event.params);
      result.fold(
        (failure) => emit(AuthVerificationSMSForLoginSentFailed(failure)),
        (unit) => emit(AuthVerificationSMSForLoginSent(unit)),
      );
    } catch (e) {
      emit(AuthVerificationSMSForLoginSentFailed(ExceptionFailure()));
    }
  }

  FutureOr<void> _onSignInWithPhone(
      AuthSignInWithPhone event, Emitter<AuthState> emit) async {
    try {
      final result = await _signInWithPhoneUseCase(event.params);
      result.fold(
        (failure) => emit(AuthPhoneVerificationForLoginFailed(failure)),
        (user) => emit(AuthPhoneVerificationForLoginSuccess(user)),
      );
    } catch (e) {
      emit(AuthPhoneVerificationForLoginFailed(ExceptionFailure()));
    }
  }

  FutureOr<void> _onSignInWithGoogle(
      AuthSignInWithGoogle event, Emitter<AuthState> emit) async {
    try {
      emit(AuthLoading());
      final result = await _signInWithGoogleUseCase(event);
      result.fold(
        (failure) => emit(AuthGoogleSignInFailed(failure)),
        (user) => emit(AuthGoogleSignInSuccess(user)),
      );
    } catch (e) {
      emit(AuthGoogleSignInFailed(ExceptionFailure()));
    }
  }

  FutureOr<void> _onSignInWithFacebook(
      AuthSignInWithFacebook event, Emitter<AuthState> emit) async {
    try {
      emit(AuthLoading());
      final result = await _signInWithFacebookUseCase(event);
      result.fold(
        (failure) => emit(AuthFacebookSignInFailed(failure)),
        (user) => emit(AuthFacebookSignInSuccess(user)),
      );
    } catch (e) {
      emit(AuthFacebookSignInFailed(ExceptionFailure()));
    }
  }

  FutureOr<void> _onSendPasswordResetEmail(
      AuthSendPasswordResetEmail event, Emitter<AuthState> emit) async {
    try {
      final result = await _sendPasswordResetEmailUseCase(event.params);
      result.fold(
        (failure) => emit(AuthPasswordResetEmailSentFailed(failure)),
        (unit) => emit(AuthPasswordResetEmailSent()),
      );
    } catch (e) {
      emit(AuthPasswordResetEmailSentFailed(ExceptionFailure()));
    }
  }

  FutureOr<void> _onSignUpWithEmail(
      AuthSignUpWithEmail event, Emitter<AuthState> emit) async {
    try {
      emit(AuthLoading());
      final result = await _signUpWithEmailUseCase(event.params);
      result.fold(
        (failure) => emit(AuthVerificationEmailRequestFailed(failure)),
        (user) => emit(AuthVerificationEmailRequested(user)),
      );
    } catch (e) {
      emit(AuthVerificationEmailRequestFailed(ExceptionFailure()));
    }
  }

  FutureOr<void> _onSendVerificationEmail(
      AuthSendVerificationEmail event, Emitter<AuthState> emit) async {
    try {
      final result = await _sendVerificationEmailUseCase(NoParams());
      result.fold(
        (failure) => emit(AuthVerificationEmailSentFailed(failure)),
        (unit) => emit(AuthVerificationEmailSent()),
      );
    } catch (e) {
      emit(AuthVerificationEmailSentFailed(ExceptionFailure()));
    }
  }

  FutureOr<void> _onWaitForEmailVerification(
      AuthWaitForEmailVerification event, Emitter<AuthState> emit) async {
    try {
      final result = await _waitForEmailVerificationUseCase(NoParams());
      result.fold(
        (failure) => emit(AuthEmailVerificationFailed(failure)),
        (unit) => emit(AuthEmailVerificationSuccess()),
      );
    } catch (e) {
      emit(AuthEmailVerificationFailed(ExceptionFailure()));
    }
  }

  FutureOr<void> _onVerifyPhoneNumberForRegistration(
      AuthVerifyPhoneNumberForRegistration event,
      Emitter<AuthState> emit) async {
    try {
      emit(AuthLoading());
      final result =
          await _verifyPhoneNumberForRegistrationUseCase(event.params);
      result.fold(
        (failure) =>
            emit(AuthVerificationSMSForRegistrationSentFailed(failure)),
        (unit) => emit(AuthVerificationSMSForRegistrationSent(unit)),
      );
    } catch (e) {
      emit(AuthVerificationSMSForRegistrationSentFailed(ExceptionFailure()));
    }
  }

  FutureOr<void> _onSignUpWithPhone(
      AuthSignUpWithPhone event, Emitter<AuthState> emit) async {
    try {
      final result = await _signUpWithPhoneUseCase(event.params);
      result.fold(
        (failure) => emit(AuthPhoneVerificationForRegistrationFailed(failure)),
        (user) => emit(AuthPhoneVerificationForRegistrationSuccess(user)),
      );
    } catch (e) {
      emit(AuthPhoneVerificationForRegistrationFailed(ExceptionFailure()));
    }
  }

  FutureOr<void> _onSignUpWithGoogle(
      AuthSignUpWithGoogle event, Emitter<AuthState> emit) async {
    try {
      emit(AuthLoading());
      final result = await _signUpWithGoogleUseCase(event);
      result.fold(
        (failure) => emit(AuthGoogleSignUpFailed(failure)),
        (user) => emit(AuthGoogleSignUpSuccess(user)),
      );
    } catch (e) {
      emit(AuthGoogleSignUpFailed(ExceptionFailure()));
    }
  }

  FutureOr<void> _onSignUpWithFacebook(
      AuthSignUpWithFacebook event, Emitter<AuthState> emit) async {
    try {
      emit(AuthLoading());
      final result = await _signUpWithFacebookUseCase(event);
      result.fold(
        (failure) => emit(AuthFacebookSignUpFailed(failure)),
        (user) => emit(AuthFacebookSignUpSuccess(user)),
      );
    } catch (e) {
      emit(AuthFacebookSignUpFailed(ExceptionFailure()));
    }
  }

  void _onCheckAuth(AuthCheck event, Emitter<AuthState> emit) async {
    try {
      // emit(AuthLoading());
      // final result = await _getCachedAuthUseCase(NoParams());
      // result.fold(
      //   (failure) => emit(AuthLoggedFail(failure)),
      //   (user) => emit(AuthLogged(user)),
      // );
    } catch (e) {
      emit(AuthLoggedFail(ExceptionFailure()));
    }
  }

  void _onSignOut(AuthSignOut event, Emitter<AuthState> emit) async {
    try {
      emit(AuthLoading());
      // await _signOutUseCase(NoParams());
      emit(AuthLoggedOut());
    } catch (e) {
      emit(AuthLoggedFail(ExceptionFailure()));
    }
  }

  void _onValidateEmailOrPhone(
      ValidateEmailOrPhone event, Emitter<AuthState> emit) {
    final input = event.input.trim();

    if (input.isEmpty) {
      emit(InputValidationState(
        isEmail: false,
        isPhone: false,
        isValid: false,
        inputType: 'none',
      ));
      return;
    }

    final bool isEmail = Validators.isValidEmail(input);
    final bool isPhone = Validators.isValidPhone(input);

    emit(InputValidationState(
      isEmail: isEmail,
      isPhone: isPhone,
      isValid: isEmail || isPhone,
      inputType: isEmail ? 'email' : (isPhone ? 'phone' : 'invalid'),
    ));
  }
}
