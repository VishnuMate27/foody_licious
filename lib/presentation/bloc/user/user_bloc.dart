import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_licious/core/error/failures.dart';
import 'package:foody_licious/domain/usecase/user/check_user_usecase.dart';
import 'package:foody_licious/presentation/bloc/user/user_event.dart';
import 'package:foody_licious/presentation/bloc/user/user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  CheckUserUseCase _checkUserUseCase;
  UserBloc(
    this._checkUserUseCase
  ) : super(UserInitial()) {
    on<CheckUser>(_checkUser);
  }
  void _checkUser(CheckUser event,Emitter<UserState> emit) async {
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
}
