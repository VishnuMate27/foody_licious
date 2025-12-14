import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:foody_licious/core/error/failures.dart';
import 'package:foody_licious/domain/entities/menuItem/menuItem.dart';
import 'package:foody_licious/domain/usecase/menuItem/get_all_menu_items_usecase.dart';
part 'menu_item_state.dart';
part 'menu_item_event.dart';

class MenuItemBloc extends Bloc<MenuItemEvent, MenuItemState> {
  final GetAllItemsInRestaurantsOfUsersCityUseCase _getAllMenuItemsUsecase;
  MenuItemBloc(
    this._getAllMenuItemsUsecase,
  ) : super(MenuItemInitial()) {
    {
      on<GetAllItemsInRestaurantsOfUsersCity>(
          _onGetAllItemsInRestaurantsOfUsersCityItems);
    }
  }

  FutureOr<void> _onGetAllItemsInRestaurantsOfUsersCityItems(
    GetAllItemsInRestaurantsOfUsersCity event,
    Emitter<MenuItemState> emit,
  ) async {
    try {
      // Only show loading for first page
      if (event.params.page == 1) {
        emit(FetchingAllMenuItemsLoading());
      }

      final result = await _getAllMenuItemsUsecase(event.params);
      result.fold((failure) => emit(FetchingAllMenuItemsFailed(failure)), (
        newItems,
      ) {
        final currentState = state;
        if (currentState is FetchingAllMenuItemsSuccess) {
          final updatedList = event.params.page == 1
              ? newItems
              : [...currentState.menuItems, ...newItems];
          emit(FetchingAllMenuItemsSuccess(updatedList));
        } else {
          emit(FetchingAllMenuItemsSuccess(newItems));
        }
      });
    } catch (e) {
      emit(FetchingAllMenuItemsFailed(ExceptionFailure(e.toString())));
    }
  }
}
