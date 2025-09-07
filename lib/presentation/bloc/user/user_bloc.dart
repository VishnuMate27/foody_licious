import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_licious/core/error/failures.dart';
import 'package:foody_licious/domain/usecase/user/check_user_usecase.dart';
import 'package:foody_licious/domain/usecase/user/update_user_location_usecase.dart';
import 'package:foody_licious/domain/usecase/user/update_user_usecase.dart';
import 'package:foody_licious/presentation/bloc/user/user_event.dart';
import 'package:foody_licious/presentation/bloc/user/user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  CheckUserUseCase _checkUserUseCase;
  UpdateUserLocationUseCase _updateUserLocationUseCase;
  UpdateUserUseCase _updateUserUseCase;
  UserBloc(this._checkUserUseCase, this._updateUserLocationUseCase,
      this._updateUserUseCase)
      : super(UserInitial()) {
    on<CheckUser>(_checkUser);
    on<UpdateUser>(_updateUser);
    on<UpdateUserLocation>(_updateUserLocation);
  }

  void _checkUser(CheckUser event, Emitter<UserState> emit) async {
    try {
      emit(UserLoading());
      final result = await _checkUserUseCase(event);
      result.fold(
        (failure) => emit(UserUnauthenticated(failure)),
        (user) => emit(UserAuthenticated(user)),
      );
    } catch (e) {
      emit(UserUnauthenticated(ExceptionFailure()));
    }
  }

  void _updateUser(UpdateUser event, Emitter<UserState> emit) async {
    try {
      emit(UserLoading());
      final result = await _updateUserUseCase(event.params);
      result.fold(
        (failure) => emit(UserUpdateFailed(failure)),
        (user) => emit(UserUpdateSuccess(user)),
      );
    } catch (e) {
      emit(UserUpdateFailed(ExceptionFailure()));
    }
  }

  void _updateUserLocation(
      UpdateUserLocation event, Emitter<UserState> emit) async {
    try {
      emit(UserLoading());
      final result = await _updateUserLocationUseCase(event);
      result.fold(
        (failure) => emit(UserUpdateLocationFailed(failure)),
        (user) => emit(UserUpdateLocationSuccess(user)),
      );
    } catch (e) {
      emit(UserUpdateLocationFailed(ExceptionFailure()));
    }
  }
}
