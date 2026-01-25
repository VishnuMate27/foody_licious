import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_licious/core/error/failures.dart';
import 'package:foody_licious/domain/entities/checkout/place_order_details.dart';
import 'package:foody_licious/domain/usecase/checkout/cancel_checkout_usecase.dart';
import 'package:foody_licious/domain/usecase/checkout/place_order_usecase.dart';
import 'package:equatable/equatable.dart';
part 'checkout_event.dart';
part 'checkout_state.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  final PlaceOrderUseCase _placeOrderUsecase;
  final CancelCheckoutUseCase _cancelCheckoutUsecase;
  CheckoutBloc(
    this._placeOrderUsecase,
    this._cancelCheckoutUsecase,
  ) : super(CheckoutInitial()) {
    on<PlaceOrder>(_onCheckout);
    on<CancelCheckout>(_cancelCheckout);
  }

  FutureOr<void> _onCheckout(
      PlaceOrder event, Emitter<CheckoutState> emit) async {
    try {
      emit(PlaceOrderLoading());
      final result = await _placeOrderUsecase(event.params);
      result.fold(
        (failure) => emit(PlaceOrderFailed(failure)),
        (placeOrderDetails) => emit(PlaceOrderSuccess(placeOrderDetails)),
      );
    } catch (e) {
      emit(PlaceOrderFailed(ExceptionFailure(e.toString())));
    }
  }

  FutureOr<void> _cancelCheckout(
      CancelCheckout event, Emitter<CheckoutState> emit) async {
    try {
      emit(CancelCheckoutLoading());
      final result = await _cancelCheckoutUsecase(event.params);
      result.fold(
        (failure) => emit(CancelCheckoutFailed(failure)),
        (unit) => emit(CancelCheckoutSuccess()),
      );
    } catch (e) {
      emit(CancelCheckoutFailed(ExceptionFailure(e.toString())));
    }
  }
}
