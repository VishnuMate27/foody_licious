import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:foody_licious/core/constant/validators.dart';
import 'package:foody_licious/core/usecase/usecase.dart';
import 'package:foody_licious/domain/usecase/user/get_local_user_usecase.dart';
import 'package:foody_licious/domain/usecase/user/send_verification_email_usecase.dart';
import 'package:foody_licious/domain/usecase/user/sign_in_with_email_usecase.dart';
import 'package:foody_licious/domain/usecase/user/sign_in_with_facebook.dart';
import 'package:foody_licious/domain/usecase/user/sign_in_with_google_usecase.dart';
import 'package:foody_licious/domain/usecase/user/sign_in_with_phone_usecase.dart';
import 'package:foody_licious/domain/usecase/user/sign_up_with_email_usecase.dart';
import 'package:foody_licious/domain/usecase/user/sign_up_with_facebook_usecase.dart';
import 'package:foody_licious/domain/usecase/user/sign_up_with_google_usecase.dart';
import 'package:foody_licious/domain/usecase/user/sign_up_with_phone_usecase.dart';
import 'package:foody_licious/domain/usecase/user/verify_phone_number_for_login_usecase.dart';
import 'package:foody_licious/domain/usecase/user/verify_phone_number_for_registration_usecase.dart';
import 'package:foody_licious/domain/usecase/user/wait_for_email_verification_usecase.dart';

import '../../../core/error/failures.dart';
import '../../../domain/entities/user/user.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final GetLocalUserUseCase _getCachedUserUseCase;
  final SignInWithEmailUseCase _signInWithEmailUseCase;
  final VerifyPhoneNumberForLoginUseCase _verifyPhoneNumberForLoginUseCase;
  final SignInWithPhoneUseCase _signInWithPhoneUseCase;
  final SignInWithGoogleUseCase _signInWithGoogleUseCase;
  final SignInWithFacebookUseCase _signInWithFacebookUseCase;
  final SignUpWithEmailUseCase _signUpWithEmailUseCase;
  final SendVerificationEmailUseCase _sendVerificationEmailUseCase;
  final WaitForEmailVerificationUsecase _waitForEmailVerificationUseCase;
  final VerifyPhoneNumberForRegistrationUseCase
      _verifyPhoneNumberForRegistrationUseCase;
  final SignUpWithPhoneUseCase _signUpWithPhoneUseCase;
  final SignUpWithGoogleUseCase _signUpWithGoogleUseCase;
  final SignUpWithFacebookUseCase _signUpWithFacebookUseCase;
  UserBloc(
    this._getCachedUserUseCase,
    this._signInWithEmailUseCase,
    this._verifyPhoneNumberForLoginUseCase,
    this._signInWithPhoneUseCase,
    this._signInWithGoogleUseCase,
    this._signInWithFacebookUseCase,
    this._signUpWithEmailUseCase,
    this._sendVerificationEmailUseCase,
    this._waitForEmailVerificationUseCase,
    this._verifyPhoneNumberForRegistrationUseCase,
    this._signUpWithPhoneUseCase,
    this._signUpWithGoogleUseCase,
    this._signUpWithFacebookUseCase,
  ) : super(UserInitial()) {
    on<SignInWithEmailUser>(_onSignInWithEmail);
    on<VerifyPhoneNumberForLoginUser>(_onVerifyPhoneNumberForLogin);
    on<SignInWithPhoneUser>(_onSignInWithPhone);
    on<SignInWithGoogleUser>(_onSignInWithGoogle);
    on<SignInWithFacebookUser>(_onSignInWithFacebook);
    on<SignUpWithEmailUser>(_onSignUpWithEmail);
    on<SendVerificationEmailUser>(_onSendVerificationEmail);
    on<WaitForEmailVerificationUser>(_onWaitForEmailVerification);
    on<VerifyPhoneNumberForRegistrationUser>(
        _onVerifyPhoneNumberForRegistration);
    on<SignUpWithPhoneUser>(_onSignUpWithPhone);
    on<SignUpWithGoogleUser>(_onSignUpWithGoogle);
    on<SignUpWithFacebookUser>(_onSignUpWithFacebook);
    on<CheckUser>(_onCheckUser);
    on<SignOutUser>(_onSignOut);
    on<ValidateEmailOrPhone>(_onValidateEmailOrPhone);
  }

  void _onSignInWithEmail(
      SignInWithEmailUser event, Emitter<UserState> emit) async {
    try {
      emit(UserLoading());
      final result = await _signInWithEmailUseCase(event.params);
      result.fold(
        (failure) => emit(UserSignInWithEmailFailed(failure)),
        (user) => emit(UserSignInWithEmailSuccess(user)),
      );
    } catch (e) {
      emit(UserSignInWithEmailFailed(ExceptionFailure()));
    }
  }

  FutureOr<void> _onVerifyPhoneNumberForLogin(
      VerifyPhoneNumberForLoginUser event, Emitter<UserState> emit) async {
    try {
      emit(UserLoading());
      final result = await _verifyPhoneNumberForLoginUseCase(event.params);
      result.fold(
        (failure) => emit(UserVerificationSMSForLoginSentFailed(failure)),
        (unit) => emit(UserVerificationSMSForLoginSent(unit)),
      );
    } catch (e) {
      emit(UserVerificationSMSForLoginSentFailed(ExceptionFailure()));
    }
  }

  FutureOr<void> _onSignInWithPhone(
      SignInWithPhoneUser event, Emitter<UserState> emit) async {
    try {
      final result = await _signInWithPhoneUseCase(event.params);
      result.fold(
        (failure) => emit(UserPhoneVerificationForLoginFailed(failure)),
        (user) => emit(UserPhoneVerificationForLoginSuccess(user)),
      );
    } catch (e) {
      emit(UserPhoneVerificationForLoginFailed(ExceptionFailure()));
    }
  }

  FutureOr<void> _onSignInWithGoogle(
      SignInWithGoogleUser event, Emitter<UserState> emit) async {
    try {
      emit(UserLoading());
      final result = await _signInWithGoogleUseCase(event);
      result.fold(
        (failure) => emit(UserGoogleSignInFailed(failure)),
        (user) => emit(UserGoogleSignInSuccess(user)),
      );
    } catch (e) {
      emit(UserGoogleSignInFailed(ExceptionFailure()));
    }
  }

  FutureOr<void> _onSignInWithFacebook(
      SignInWithFacebookUser event, Emitter<UserState> emit) async {
    try {
      emit(UserLoading());
      final result = await _signInWithFacebookUseCase(event);
      result.fold(
        (failure) => emit(UserFacebookSignInFailed(failure)),
        (user) => emit(UserFacebookSignInSuccess(user)),
      );
    } catch (e) {
      emit(UserFacebookSignInFailed(ExceptionFailure()));
    }
  }

  FutureOr<void> _onSignUpWithEmail(
      SignUpWithEmailUser event, Emitter<UserState> emit) async {
    try {
      emit(UserLoading());
      final result = await _signUpWithEmailUseCase(event.params);
      result.fold(
        (failure) => emit(UserVerificationEmailRequestFailed(failure)),
        (user) => emit(UserVerificationEmailRequested(user)),
      );
    } catch (e) {
      emit(UserVerificationEmailRequestFailed(ExceptionFailure()));
    }
  }

  FutureOr<void> _onSendVerificationEmail(
      SendVerificationEmailUser event, Emitter<UserState> emit) async {
    try {
      final result = await _sendVerificationEmailUseCase(NoParams());
      result.fold(
        (failure) => emit(UserVerificationEmailSentFailed(failure)),
        (unit) => emit(UserVerificationEmailSent()),
      );
    } catch (e) {
      emit(UserVerificationEmailSentFailed(ExceptionFailure()));
    }
  }

  FutureOr<void> _onWaitForEmailVerification(
      WaitForEmailVerificationUser event, Emitter<UserState> emit) async {
    try {
      final result = await _waitForEmailVerificationUseCase(NoParams());
      result.fold(
        (failure) => emit(UserEmailVerificationFailed(failure)),
        (unit) => emit(UserEmailVerificationSuccess()),
      );
    } catch (e) {
      emit(UserEmailVerificationFailed(ExceptionFailure()));
    }
  }

  FutureOr<void> _onVerifyPhoneNumberForRegistration(
      VerifyPhoneNumberForRegistrationUser event,
      Emitter<UserState> emit) async {
    try {
      emit(UserLoading());
      final result =
          await _verifyPhoneNumberForRegistrationUseCase(event.params);
      result.fold(
        (failure) =>
            emit(UserVerificationSMSForRegistrationSentFailed(failure)),
        (unit) => emit(UserVerificationSMSForRegistrationSent(unit)),
      );
    } catch (e) {
      emit(UserVerificationSMSForRegistrationSentFailed(ExceptionFailure()));
    }
  }

  FutureOr<void> _onSignUpWithPhone(
      SignUpWithPhoneUser event, Emitter<UserState> emit) async {
    try {
      final result = await _signUpWithPhoneUseCase(event.params);
      result.fold(
        (failure) => emit(UserPhoneVerificationForRegistrationFailed(failure)),
        (user) => emit(UserPhoneVerificationForRegistrationSuccess(user)),
      );
    } catch (e) {
      emit(UserPhoneVerificationForRegistrationFailed(ExceptionFailure()));
    }
  }

  FutureOr<void> _onSignUpWithGoogle(
      SignUpWithGoogleUser event, Emitter<UserState> emit) async {
    try {
      emit(UserLoading());
      final result = await _signUpWithGoogleUseCase(event);
      result.fold(
        (failure) => emit(UserGoogleSignUpFailed(failure)),
        (user) => emit(UserGoogleSignUpSuccess(user)),
      );
    } catch (e) {
      emit(UserGoogleSignUpFailed(ExceptionFailure()));
    }
  }

  FutureOr<void> _onSignUpWithFacebook(
      SignUpWithFacebookUser event, Emitter<UserState> emit) async {
    try {
      emit(UserLoading());
      final result = await _signUpWithFacebookUseCase(event);
      result.fold(
        (failure) => emit(UserFacebookSignUpFailed(failure)),
        (user) => emit(UserFacebookSignUpSuccess(user)),
      );
    } catch (e) {
      emit(UserFacebookSignUpFailed(ExceptionFailure()));
    }
  }

  void _onCheckUser(CheckUser event, Emitter<UserState> emit) async {
    try {
      // emit(UserLoading());
      // final result = await _getCachedUserUseCase(NoParams());
      // result.fold(
      //   (failure) => emit(UserLoggedFail(failure)),
      //   (user) => emit(UserLogged(user)),
      // );
    } catch (e) {
      emit(UserLoggedFail(ExceptionFailure()));
    }
  }

  void _onSignOut(SignOutUser event, Emitter<UserState> emit) async {
    try {
      emit(UserLoading());
      // await _signOutUseCase(NoParams());
      emit(UserLoggedOut());
    } catch (e) {
      emit(UserLoggedFail(ExceptionFailure()));
    }
  }

  void _onValidateEmailOrPhone(
      ValidateEmailOrPhone event, Emitter<UserState> emit) {
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
