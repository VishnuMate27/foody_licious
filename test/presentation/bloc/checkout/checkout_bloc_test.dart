import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foody_licious/core/error/failures.dart';
import 'package:foody_licious/core/usecase/usecase.dart';
import 'package:foody_licious/domain/usecase/checkout/cancel_checkout_usecase.dart';
import 'package:foody_licious/domain/usecase/checkout/place_order_usecase.dart';
import 'package:foody_licious/presentation/bloc/checkout/checkout_bloc.dart';
import 'package:mocktail/mocktail.dart';

import '../../../fixtures/constant_objects.dart';

class MockPlaceOrderUseCase extends Mock implements PlaceOrderUseCase {}

class MockCancelCheckoutUseCase extends Mock implements CancelCheckoutUseCase {}

void main() {
  group('CheckoutBloc', () {
    late CheckoutBloc checkoutBloc;
    late MockPlaceOrderUseCase mockPlaceOrderUseCase;
    late MockCancelCheckoutUseCase mockCancelCheckoutUseCase;
    setUp(() {
      mockPlaceOrderUseCase = MockPlaceOrderUseCase();
      mockCancelCheckoutUseCase = MockCancelCheckoutUseCase();
      registerFallbackValue(NoParams());
      checkoutBloc =
          CheckoutBloc(mockPlaceOrderUseCase, mockCancelCheckoutUseCase);
    });

    test('Initial State should be CheckoutInitial', () {
      expect(checkoutBloc.state, CheckoutInitial());
    });

    /// _onCheckout
    blocTest<CheckoutBloc, CheckoutState>(
      'emits [PlaceOrderLoading, PlaceOrderSuccess] when PlaceOrder success',
      build: () {
        when(() => mockPlaceOrderUseCase(tPlaceOrderParams))
            .thenAnswer((_) async => Right(tPlaceOrderDetails));
        return checkoutBloc;
      },
      act: (bloc) => bloc.add(PlaceOrder(tPlaceOrderParams)),
      verify: (_) {
        verify(() => mockPlaceOrderUseCase(tPlaceOrderParams)).called(1);
      },
      expect: () => [
        PlaceOrderLoading(),
        PlaceOrderSuccess(tPlaceOrderDetails),
      ],
    );

    blocTest<CheckoutBloc, CheckoutState>(
      'emits [PlaceOrderLoading, PlaceOrderFailed] on PlaceOrder error',
      build: () {
        when(() => mockPlaceOrderUseCase(tPlaceOrderParams))
            .thenAnswer((_) async => Left(CredentialFailure()));
        return checkoutBloc;
      },
      act: (bloc) async => bloc.add(PlaceOrder(tPlaceOrderParams)),
      verify: (_) {
        verify(() => mockPlaceOrderUseCase(tPlaceOrderParams)).called(1);
      },
      expect: () => [
        PlaceOrderLoading(),
        PlaceOrderFailed(CredentialFailure()),
      ],
    );

    blocTest<CheckoutBloc, CheckoutState>(
      'emits [PlaceOrderLoading, PlaceOrderFailed] on PlaceOrder error',
      build: () {
        when(() => mockPlaceOrderUseCase(tPlaceOrderParams))
            .thenAnswer((_) async => Left(CartLockedFailure()));
        return checkoutBloc;
      },
      act: (bloc) async => bloc.add(PlaceOrder(tPlaceOrderParams)),
      expect: () => [
        PlaceOrderLoading(),
        PlaceOrderFailed(CartLockedFailure()),
      ],
    );

    blocTest<CheckoutBloc, CheckoutState>(
      'emits [PlaceOrderLoading, PlaceOrderFailed] on PlaceOrder error',
      build: () {
        when(() => mockPlaceOrderUseCase(tPlaceOrderParams))
            .thenAnswer((_) async => Left(CartEmptyFailure()));
        return checkoutBloc;
      },
      act: (bloc) => bloc.add(PlaceOrder(tPlaceOrderParams)),
      verify: (_) {
        verify(() => mockPlaceOrderUseCase(tPlaceOrderParams)).called(1);
      },
      expect: () => [
        PlaceOrderLoading(),
        PlaceOrderFailed(CartEmptyFailure()),
      ],
    );

    blocTest<CheckoutBloc, CheckoutState>(
      'emits [PlaceOrderLoading, PlaceOrderFailed] on PlaceOrder error',
      build: () {
        when(() => mockPlaceOrderUseCase(tPlaceOrderParams))
            .thenAnswer((_) async => Left(OldOrderPendingFailure()));
        return checkoutBloc;
      },
      act: (bloc) => bloc.add(PlaceOrder(tPlaceOrderParams)),
      verify: (_) {
        verify(() => mockPlaceOrderUseCase(tPlaceOrderParams)).called(1);
      },
      expect: () => [
        PlaceOrderLoading(),
        PlaceOrderFailed(OldOrderPendingFailure()),
      ],
    );

    blocTest<CheckoutBloc, CheckoutState>(
      'emits [PlaceOrderLoading, PlaceOrderFailed] on PlaceOrder error',
      build: () {
        when(() => mockPlaceOrderUseCase(tPlaceOrderParams))
            .thenAnswer((_) async => Left(CartNotExistsFailure()));
        return checkoutBloc;
      },
      act: (bloc) => bloc.add(PlaceOrder(tPlaceOrderParams)),
      verify: (_) {
        verify(() => mockPlaceOrderUseCase(tPlaceOrderParams)).called(1);
      },
      expect: () => [
        PlaceOrderLoading(),
        PlaceOrderFailed(CartNotExistsFailure()),
      ],
    );

    blocTest<CheckoutBloc, CheckoutState>(
      'emits [PlaceOrderLoading, PlaceOrderFailed] on PlaceOrder error',
      build: () {
        when(() => mockPlaceOrderUseCase(tPlaceOrderParams))
            .thenAnswer((_) async => Left(CartLockFailedFailure()));
        return checkoutBloc;
      },
      act: (bloc) => bloc.add(PlaceOrder(tPlaceOrderParams)),
      verify: (_) {
        verify(() => mockPlaceOrderUseCase(tPlaceOrderParams)).called(1);
      },
      expect: () => [
        PlaceOrderLoading(),
        PlaceOrderFailed(CartLockFailedFailure()),
      ],
    );

    blocTest<CheckoutBloc, CheckoutState>(
      'emits [PlaceOrderLoading, PlaceOrderFailed] on PlaceOrder error',
      build: () {
        when(() => mockPlaceOrderUseCase(tPlaceOrderParams))
            .thenAnswer((_) async => Left(OrderNotFoundFailure()));
        return checkoutBloc;
      },
      act: (bloc) => bloc.add(PlaceOrder(tPlaceOrderParams)),
      verify: (_) {
        verify(() => mockPlaceOrderUseCase(tPlaceOrderParams)).called(1);
      },
      expect: () => [
        PlaceOrderLoading(),
        PlaceOrderFailed(OrderNotFoundFailure()),
      ],
    );

    blocTest<CheckoutBloc, CheckoutState>(
      'emits [PlaceOrderLoading, PlaceOrderFailed] on PlaceOrder error',
      build: () {
        when(() => mockPlaceOrderUseCase(tPlaceOrderParams)).thenAnswer(
            (_) async => Left(OrderStatusNotPendingPaymentFailure()));
        return checkoutBloc;
      },
      act: (bloc) => bloc.add(PlaceOrder(tPlaceOrderParams)),
      verify: (_) {
        verify(() => mockPlaceOrderUseCase(tPlaceOrderParams)).called(1);
      },
      expect: () => [
        PlaceOrderLoading(),
        PlaceOrderFailed(OrderStatusNotPendingPaymentFailure()),
      ],
    );

    blocTest<CheckoutBloc, CheckoutState>(
      'emits [PlaceOrderLoading, PlaceOrderFailed] on PlaceOrder error',
      build: () {
        when(() => mockPlaceOrderUseCase(tPlaceOrderParams)).thenAnswer(
            (_) async => Left(PaymentStatusAlreadySuccessFailure()));
        return checkoutBloc;
      },
      act: (bloc) => bloc.add(PlaceOrder(tPlaceOrderParams)),
      verify: (_) {
        verify(() => mockPlaceOrderUseCase(tPlaceOrderParams)).called(1);
      },
      expect: () => [
        PlaceOrderLoading(),
        PlaceOrderFailed(PaymentStatusAlreadySuccessFailure()),
      ],
    );

    blocTest<CheckoutBloc, CheckoutState>(
      'emits [PlaceOrderLoading, PlaceOrderFailed] on PlaceOrder error',
      build: () {
        when(() => mockPlaceOrderUseCase(tPlaceOrderParams)).thenAnswer(
            (_) async => Left(OldPaymentStatusAlreadyPendingFailure()));
        return checkoutBloc;
      },
      act: (bloc) => bloc.add(PlaceOrder(tPlaceOrderParams)),
      verify: (_) {
        verify(() => mockPlaceOrderUseCase(tPlaceOrderParams)).called(1);
      },
      expect: () => [
        PlaceOrderLoading(),
        PlaceOrderFailed(OldPaymentStatusAlreadyPendingFailure()),
      ],
    );

    blocTest<CheckoutBloc, CheckoutState>(
      'emits [PlaceOrderLoading, PlaceOrderFailed] on PlaceOrder error',
      build: () {
        when(() => mockPlaceOrderUseCase(tPlaceOrderParams))
            .thenAnswer((_) async => Left(BusinessExceptionFailure("Error")));
        return checkoutBloc;
      },
      act: (bloc) => bloc.add(PlaceOrder(tPlaceOrderParams)),
      verify: (_) {
        verify(() => mockPlaceOrderUseCase(tPlaceOrderParams)).called(1);
      },
      expect: () => [
        PlaceOrderLoading(),
        PlaceOrderFailed(BusinessExceptionFailure("Error")),
      ],
    );

    blocTest<CheckoutBloc, CheckoutState>(
      'emits [PlaceOrderLoading, PlaceOrderFailed] on PlaceOrder error',
      build: () {
        when(() => mockPlaceOrderUseCase(tPlaceOrderParams))
            .thenAnswer((_) async => Left(ServerFailure()));
        return checkoutBloc;
      },
      act: (bloc) => bloc.add(PlaceOrder(tPlaceOrderParams)),
      verify: (_) {
        verify(() => mockPlaceOrderUseCase(tPlaceOrderParams)).called(1);
      },
      expect: () => [
        PlaceOrderLoading(),
        PlaceOrderFailed(ServerFailure()),
      ],
    );

    // _cancelCheckout
    blocTest<CheckoutBloc, CheckoutState>(
      'emits [CancelCheckoutLoading, CancelCheckoutSuccess] when CancelCheckout success',
      build: () {
        when(() => mockCancelCheckoutUseCase(tCancelCheckoutParams))
            .thenAnswer((_) async => Right(unit));
        return checkoutBloc;
      },
      act: (bloc) => bloc.add(CancelCheckout(tCancelCheckoutParams)),
      verify: (_) {
        verify(() => mockCancelCheckoutUseCase(tCancelCheckoutParams))
            .called(1);
      },
      expect: () => [
        CancelCheckoutLoading(),
        CancelCheckoutSuccess(),
      ],
    );

    blocTest<CheckoutBloc, CheckoutState>(
      'emits [CancelCheckoutLoading, CancelCheckoutFailed] on CancelCheckout error',
      build: () {
        when(() => mockCancelCheckoutUseCase(tCancelCheckoutParams))
            .thenAnswer((_) async => Left(CredentialFailure()));
        return checkoutBloc;
      },
      act: (bloc) => bloc.add(CancelCheckout(tCancelCheckoutParams)),
      verify: (_) {
        verify(() => mockCancelCheckoutUseCase(tCancelCheckoutParams))
            .called(1);
      },
      expect: () => [
        CancelCheckoutLoading(),
        CancelCheckoutFailed(CredentialFailure()),
      ],
    );

////
    blocTest<CheckoutBloc, CheckoutState>(
      'emits [CancelCheckoutLoading, CancelCheckoutFailed] on CancelCheckout error',
      build: () {
        when(() => mockCancelCheckoutUseCase(tCancelCheckoutParams))
            .thenAnswer((_) async => Left(PaymentRequestNotFoundFailure()));
        return checkoutBloc;
      },
      act: (bloc) => bloc.add(CancelCheckout(tCancelCheckoutParams)),
      verify: (_) {
        verify(() => mockCancelCheckoutUseCase(tCancelCheckoutParams))
            .called(1);
      },
      expect: () => [
        CancelCheckoutLoading(),
        CancelCheckoutFailed(PaymentRequestNotFoundFailure()),
      ],
    );

    blocTest<CheckoutBloc, CheckoutState>(
      'emits [CancelCheckoutLoading, CancelCheckoutFailed] on CancelCheckout error',
      build: () {
        when(() => mockCancelCheckoutUseCase(tCancelCheckoutParams))
            .thenAnswer((_) async => Left(PaymentStatusIsNotPendingFailure()));
        return checkoutBloc;
      },
      act: (bloc) => bloc.add(CancelCheckout(tCancelCheckoutParams)),
      verify: (_) {
        verify(() => mockCancelCheckoutUseCase(tCancelCheckoutParams))
            .called(1);
      },
      expect: () => [
        CancelCheckoutLoading(),
        CancelCheckoutFailed(PaymentStatusIsNotPendingFailure()),
      ],
    );

    blocTest<CheckoutBloc, CheckoutState>(
      'emits [CancelCheckoutLoading, CancelCheckoutFailed] on CancelCheckout error',
      build: () {
        when(() => mockCancelCheckoutUseCase(tCancelCheckoutParams))
            .thenAnswer((_) async => Left(PaymentStatusIsNotSelectedFailure()));
        return checkoutBloc;
      },
      act: (bloc) => bloc.add(CancelCheckout(tCancelCheckoutParams)),
      verify: (_) {
        verify(() => mockCancelCheckoutUseCase(tCancelCheckoutParams))
            .called(1);
      },
      expect: () => [
        CancelCheckoutLoading(),
        CancelCheckoutFailed(PaymentStatusIsNotSelectedFailure()),
      ],
    );

    blocTest<CheckoutBloc, CheckoutState>(
      'emits [CancelCheckoutLoading, CancelCheckoutFailed] on CancelCheckout error',
      build: () {
        when(() => mockCancelCheckoutUseCase(tCancelCheckoutParams))
            .thenAnswer((_) async => Left(FailedToUpdatePaymentModeFailure()));
        return checkoutBloc;
      },
      act: (bloc) => bloc.add(CancelCheckout(tCancelCheckoutParams)),
      verify: (_) {
        verify(() => mockCancelCheckoutUseCase(tCancelCheckoutParams))
            .called(1);
      },
      expect: () => [
        CancelCheckoutLoading(),
        CancelCheckoutFailed(FailedToUpdatePaymentModeFailure()),
      ],
    );

    blocTest<CheckoutBloc, CheckoutState>(
      'emits [CancelCheckoutLoading, CancelCheckoutFailed] on CancelCheckout error',
      build: () {
        when(() => mockCancelCheckoutUseCase(tCancelCheckoutParams))
            .thenAnswer((_) async => Left(BusinessExceptionFailure("Error")));
        return checkoutBloc;
      },
      act: (bloc) => bloc.add(CancelCheckout(tCancelCheckoutParams)),
      verify: (_) {
        verify(() => mockCancelCheckoutUseCase(tCancelCheckoutParams))
            .called(1);
      },
      expect: () => [
        CancelCheckoutLoading(),
        CancelCheckoutFailed(BusinessExceptionFailure("Error")),
      ],
    );

    blocTest<CheckoutBloc, CheckoutState>(
      'emits [CancelCheckoutLoading, CancelCheckoutFailed] on CancelCheckout error',
      build: () {
        when(() => mockCancelCheckoutUseCase(tCancelCheckoutParams))
            .thenAnswer((_) async => Left(ServerFailure()));
        return checkoutBloc;
      },
      act: (bloc) => bloc.add(CancelCheckout(tCancelCheckoutParams)),
      verify: (_) {
        verify(() => mockCancelCheckoutUseCase(tCancelCheckoutParams))
            .called(1);
      },
      expect: () => [
        CancelCheckoutLoading(),
        CancelCheckoutFailed(ServerFailure()),
      ],
    );
  });
}
