import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:foody_licious/core/constant/validators.dart';
import 'package:foody_licious/core/usecase/usecase.dart';
import 'package:foody_licious/domain/usecase/user/get_local_user_usecase.dart';
import 'package:foody_licious/domain/usecase/user/sign_in_usecase.dart';
import 'package:foody_licious/domain/usecase/user/sign_up_usecase.dart';

import '../../../core/error/failures.dart';
import '../../../domain/entities/user/user.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final GetLocalUserUseCase _getCachedUserUseCase;
  final SignInUseCase _signInUseCase;
  final SignUpUseCase _signUpUseCase;
  UserBloc(
    this._signInUseCase,
    this._signUpUseCase,
    this._getCachedUserUseCase,
  ) : super(UserInitial()) {
    on<SignInUser>(_onSignIn);
    on<SignUpUser>(_onSignUp);
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

  FutureOr<void> _onSignUp(SignUpUser event, Emitter<UserState> emit) async {
    try {
      emit(UserLoading());
      final result = await _signUpUseCase(event.params);
      result.fold(
        (failure) => emit(UserLoggedFail(failure)),
        (user) => emit(UserLogged(user)),
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
        isValid: false,
        inputType: 'none',
      ));
      return;
    }

    final bool isEmail = Validators.isValidEmail(input);
    final bool isPhone = Validators.isValidPhone(input);

    emit(InputValidationState(
      isEmail: isEmail,
      isValid: isEmail || isPhone,
      inputType: isEmail ? 'email' : (isPhone ? 'phone' : 'invalid'),
    ));
  }
}
