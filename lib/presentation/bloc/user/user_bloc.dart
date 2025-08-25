import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:foody_licious/core/constant/validators.dart';
import 'package:foody_licious/core/usecase/usecase.dart';
import 'package:foody_licious/domain/usecase/user/get_local_user_usecase.dart';
import 'package:foody_licious/domain/usecase/user/send_verification_email_usecase.dart';
import 'package:foody_licious/domain/usecase/user/sign_in_usecase.dart';
import 'package:foody_licious/domain/usecase/user/sign_up_with_email_usecase.dart';
import 'package:foody_licious/domain/usecase/user/sign_up_with_facebook_usecase.dart';
import 'package:foody_licious/domain/usecase/user/sign_up_with_google_usecase.dart';
import 'package:foody_licious/domain/usecase/user/sign_up_with_phone_usecase.dart';
import 'package:foody_licious/domain/usecase/user/verify_phone_number_usecase.dart';
import 'package:foody_licious/domain/usecase/user/wait_for_email_verification_usecase.dart';

import '../../../core/error/failures.dart';
import '../../../domain/entities/user/user.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final GetLocalUserUseCase _getCachedUserUseCase;
  final SignInUseCase _signInUseCase;
  final SignUpWithEmailUseCase _signUpWithEmailUseCase;
  final VerifyPhoneNumberUseCase _verifyPhoneNumberUseCase;
  final SignUpWithPhoneUseCase _signUpWithPhoneUseCase;
  final SignUpWithGoogleUseCase _signUpWithGoogleUseCase;
  final SignUpWithFacebookUseCase _signUpWithFacebookUseCase;
  final SendVerificationEmailUseCase _sendVerificationEmailUseCase;
  final WaitForEmailVerificationUsecase _waitForEmailVerificationUseCase;
  UserBloc(
    this._signInUseCase,
    this._signUpWithEmailUseCase,
    this._verifyPhoneNumberUseCase,
    this._signUpWithPhoneUseCase,
    this._signUpWithGoogleUseCase,
    this._signUpWithFacebookUseCase,
    this._sendVerificationEmailUseCase,
    this._getCachedUserUseCase,
    this._waitForEmailVerificationUseCase,
  ) : super(UserInitial()) {
    on<SignInUser>(_onSignIn);
    on<SignUpWithEmailUser>(_onSignUpWithEmail);
    on<SendVerificationEmailUser>(_onSendVerificationEmail);
    on<WaitForEmailVerificationUser>(_onWaitForEmailVerification);
    on<SignUpWithPhoneUser>(_onSignUpWithPhone);
    on<SignUpWithGoogleUser>(_onSignUpWithGoogle);
    on<SignUpWithFacebookUser>(_onSignUpWithFacebook);
    on<VerifyPhoneNumberUser>(_onVerifyPhoneNumber);
    on<CheckUser>(_onCheckUser);
    on<SignOutUser>(_onSignOut);
    on<ValidateEmailOrPhone>(_onValidateEmailOrPhone);
  }

  void _onSignIn(SignInUser event, Emitter<UserState> emit) async {
    try {
      emit(UserLoading());
      final result = await _signInUseCase(event.params);
      result.fold(
        (failure) => emit(UserLoggedFail(failure)),
        (user) => emit(UserLogged(user)),
      );
    } catch (e) {
      emit(UserLoggedFail(ExceptionFailure()));
    }
  }

  void _onCheckUser(CheckUser event, Emitter<UserState> emit) async {
    try {
      emit(UserLoading());
      // final result = await _getCachedUserUseCase(NoParams());
      // result.fold(
      //   (failure) => emit(UserLoggedFail(failure)),
      //   (user) => emit(UserLogged(user)),
      // );
    } catch (e) {
      emit(UserLoggedFail(ExceptionFailure()));
    }
  }

  FutureOr<void> _onSignUpWithEmail(
      SignUpWithEmailUser event, Emitter<UserState> emit) async {
    try {
      emit(UserLoading());
      final result = await _signUpWithEmailUseCase(event.params);
      result.fold(
        (failure) => emit(UserLoggedFail(failure)),
        (user) => emit(UserVerificationEmailRequested(user)),
      );
    } catch (e) {
      emit(UserLoggedFail(ExceptionFailure()));
    }
  }

  FutureOr<void> _onSendVerificationEmail(
      SendVerificationEmailUser event, Emitter<UserState> emit) async {
    try {
      emit(UserLoading());
      final result = await _sendVerificationEmailUseCase(NoParams());
      result.fold(
        (failure) => emit(UserLoggedFail(failure)),
        (unit) => emit(UserVerificationEmailSent()),
      );
    } catch (e) {
      emit(UserLoggedFail(ExceptionFailure()));
    }
  }

  FutureOr<void> _onWaitForEmailVerification(
      WaitForEmailVerificationUser event, Emitter<UserState> emit) async {
    try {
      final result = await _waitForEmailVerificationUseCase(NoParams());
      result.fold(
        (failure) => emit(UserLoggedFail(failure)),
        (unit) => emit(UserEmailVerificationSuccess()),
      );
    } catch (e) {
      emit(UserLoggedFail(ExceptionFailure()));
    }
  }

  FutureOr<void> _onSignUpWithPhone(
      SignUpWithPhoneUser event, Emitter<UserState> emit) async {
    try {
      emit(UserLoading());
      final result = await _signUpWithPhoneUseCase(event.params);
      result.fold(
        (failure) => emit(UserLoggedFail(failure)),
        (user) => emit(UserPhoneVerificationSuccess(user)),
      );
    } catch (e) {
      emit(UserLoggedFail(ExceptionFailure()));
    }
  }

  FutureOr<void> _onSignUpWithGoogle(
      SignUpWithGoogleUser event, Emitter<UserState> emit) async {
    try {
      emit(UserLoading());
      final result = await _signUpWithGoogleUseCase(event);
      result.fold(
        (failure) => emit(UserLoggedFail(failure)),
        (user) => emit(UserGoogleSignUpSuccess(user)),
      );
    } catch (e) {
      emit(UserLoggedFail(ExceptionFailure()));
    }
  }

  FutureOr<void> _onSignUpWithFacebook(
      SignUpWithFacebookUser event, Emitter<UserState> emit) async {
    try {
      emit(UserLoading());
      final result = await _signUpWithFacebookUseCase(event);
      result.fold(
        (failure) => emit(UserLoggedFail(failure)),
        (user) => emit(UserFacebookSignUpSuccess(user)),
      );
    } catch (e) {
      emit(UserLoggedFail(ExceptionFailure()));
    }
  }

  FutureOr<void> _onVerifyPhoneNumber(
      VerifyPhoneNumberUser event, Emitter<UserState> emit) async {
    try {
      emit(UserLoading());
      final result = await _verifyPhoneNumberUseCase(event.params);
      result.fold(
        (failure) => emit(UserLoggedFail(failure)),
        (unit) => emit(UserVerificationSMSSent(unit)),
      );
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
