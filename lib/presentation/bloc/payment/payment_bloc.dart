import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_licious/core/error/failures.dart';
import 'package:foody_licious/domain/usecase/payment/complete_payment_usecase.dart';
part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final CompletePaymentUseCase _completePaymentUsecase;
  PaymentBloc(this._completePaymentUsecase) : super(PaymentInitial()) {
    {
      on<CompletePayment>(_onCompletePayment);
    }
  }

  FutureOr<void> _onCompletePayment(
    CompletePayment event,
    Emitter<PaymentState> emit,
  ) async {
    try {
      emit(CompletePaymentLoading());
      final result = await _completePaymentUsecase(event.params);
      result.fold(
        (failure) => emit(CompletePaymentFailed(failure)),
        (unit) => emit(CompletePaymentSuccess()),
      );
    } catch (e) {
      emit(CompletePaymentFailed(ExceptionFailure(e.toString())));
    }
  }
}
