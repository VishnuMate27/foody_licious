import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:foody_licious/core/error/failures.dart';
import 'package:foody_licious/domain/entities/restaurant/restaurant.dart';
import 'package:foody_licious/domain/usecase/restaurant/get_restaurant_details_usecase.dart';
part 'restaurant_event.dart';
part 'restaurant_state.dart';

class RestaurantBloc extends Bloc<RestaurantEvent, RestaurantState> {
  final GetRestaurantDetailsUseCase _getRestaurantDetailsUsecase;
  RestaurantBloc(
    this._getRestaurantDetailsUsecase,
  ) : super(RestaurantInitial()) {
    {
      on<FetchRestaurantDetails>(_onFetchRestaurantDetails);
    }
  }

  FutureOr<void> _onFetchRestaurantDetails(
    FetchRestaurantDetails event,
    Emitter<RestaurantState> emit,
  ) async {
    try {
      final result = await _getRestaurantDetailsUsecase(event.params);
      emit(FetchingRestaurantDetails());
      result.fold(
        (failure) => emit(RestaurantDetailsFetchFail(failure)),
        (restaurant) => emit(RestaurantDetailsFetchSuccess(restaurant)),
      );
    } catch (e) {
      emit(RestaurantDetailsFetchFail(ExceptionFailure(e.toString())));
    }
  }
}
