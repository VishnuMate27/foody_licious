import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_licious/core/error/failures.dart';
import 'package:foody_licious/core/usecase/usecase.dart';
import 'package:foody_licious/domain/usecase/user/check_user_usecase.dart';
import 'package:foody_licious/domain/usecase/user/delete_user_usecase.dart';
import 'package:foody_licious/domain/usecase/user/update_user_location_usecase.dart';
import 'package:foody_licious/domain/usecase/user/update_user_usecase.dart';
import 'package:foody_licious/presentation/bloc/user/user_event.dart';
import 'package:foody_licious/presentation/bloc/user/user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  CheckUserUseCase _checkUserUseCase;
  UpdateUserLocationUseCase _updateUserLocationUseCase;
  UpdateUserUseCase _updateUserUseCase;
  DeleteUserUseCase _deleteUserUseCase;

  UserBloc(this._checkUserUseCase, this._updateUserLocationUseCase,
      this._updateUserUseCase, this._deleteUserUseCase)
      : super(UserInitial()) {
    on<CheckUser>(_checkUser);
    on<UpdateUser>(_updateUser);
    on<UpdateUserLocation>(_updateUserLocation);
    on<DeleteUser>(_deleteUser);
  }

  void _checkUser(CheckUser event, Emitter<UserState> emit) async {
    try {
      emit(UserLoading());
      final result = await _checkUserUseCase(NoParams());
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
      emit(UserLocationUpdating());
      final result = await _updateUserLocationUseCase(NoParams());
      result.fold(
        (failure) => emit(UserUpdateLocationFailed(failure)),
        (user) => emit(UserUpdateLocationSuccess(user)),
      );
    } catch (e) {
      emit(UserUpdateLocationFailed(ExceptionFailure()));
    }
  }

  void _deleteUser(DeleteUser event, Emitter<UserState> emit) async {
    try {
      emit(UserLoading());
      final result = await _deleteUserUseCase(NoParams());
      result.fold(
        (failure) => emit(UserDeleteFailed(failure)),
        (unit) => emit(UserDeleteSuccess(unit)),
      );
    } catch (e) {
      emit(UserUpdateFailed(ExceptionFailure()));
    }
  }
}
