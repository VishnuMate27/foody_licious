import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foody_licious/core/error/failures.dart';
import 'package:foody_licious/core/usecase/usecase.dart';
import 'package:foody_licious/domain/usecase/payment/complete_payment_usecase.dart';
import 'package:foody_licious/presentation/bloc/payment/payment_bloc.dart';
import 'package:mocktail/mocktail.dart';

import '../../../fixtures/constant_objects.dart';

class MockCompletePaymentUseCase extends Mock
    implements CompletePaymentUseCase {}

void main() {
  group('PaymentBloc', () {
    late PaymentBloc paymentBloc;
    late MockCompletePaymentUseCase mockCompletePaymentUseCase;

    setUp(() {
      mockCompletePaymentUseCase = MockCompletePaymentUseCase();
      registerFallbackValue(NoParams());
      paymentBloc = PaymentBloc(mockCompletePaymentUseCase);
    });

    test('Initial State should be PaymentInitial', () {
      expect(paymentBloc.state, PaymentInitial());
    });

    /// _onCheckout
    blocTest<PaymentBloc, PaymentState>(
      'emits [CompletePaymentLoading, CompletePaymentSuccess] when CompletePayment success',
      build: () {
        when(() => mockCompletePaymentUseCase(tPaymentParams))
            .thenAnswer((_) async => Right(unit));
        return paymentBloc;
      },
      act: (bloc) => bloc.add(CompletePayment(tPaymentParams)),
      verify: (_) {
        verify(() => mockCompletePaymentUseCase(tPaymentParams)).called(1);
      },
      expect: () => [
        CompletePaymentLoading(),
        CompletePaymentSuccess(),
      ],
    );

    blocTest<PaymentBloc, PaymentState>(
      'emits [CompletePaymentLoading, CompletePaymentFailed] on CompletePayment error',
      build: () {
        when(() => mockCompletePaymentUseCase(tPaymentParams))
            .thenAnswer((_) async => Left(CredentialFailure()));
        return paymentBloc;
      },
      act: (bloc) => bloc.add(CompletePayment(tPaymentParams)),
      verify: (_) {
        verify(() => mockCompletePaymentUseCase(tPaymentParams)).called(1);
      },
      expect: () => [
        CompletePaymentLoading(),
        CompletePaymentFailed(CredentialFailure()),
      ],
    );


///
    blocTest<PaymentBloc, PaymentState>(
      'emits [CompletePaymentLoading, CompletePaymentFailed] on CompletePayment error',
      build: () {
        when(() => mockCompletePaymentUseCase(tPaymentParams))
            .thenAnswer((_) async => Left(PaymentRequestNotFoundFailure()));
        return paymentBloc;
      },
      act: (bloc) => bloc.add(CompletePayment(tPaymentParams)),
      verify: (_) {
        verify(() => mockCompletePaymentUseCase(tPaymentParams)).called(1);
      },
      expect: () => [
        CompletePaymentLoading(),
        CompletePaymentFailed(PaymentRequestNotFoundFailure()),
      ],
    );

        blocTest<PaymentBloc, PaymentState>(
      'emits [CompletePaymentLoading, CompletePaymentFailed] on CompletePayment error',
      build: () {
        when(() => mockCompletePaymentUseCase(tPaymentParams))
            .thenAnswer((_) async => Left(PaymentStatusIsNotPendingFailure()));
        return paymentBloc;
      },
      act: (bloc) => bloc.add(CompletePayment(tPaymentParams)),
      verify: (_) {
        verify(() => mockCompletePaymentUseCase(tPaymentParams)).called(1);
      },
      expect: () => [
        CompletePaymentLoading(),
        CompletePaymentFailed(PaymentStatusIsNotPendingFailure()),
      ],
    );


        blocTest<PaymentBloc, PaymentState>(
      'emits [CompletePaymentLoading, CompletePaymentFailed] on CompletePayment error',
      build: () {
        when(() => mockCompletePaymentUseCase(tPaymentParams))
            .thenAnswer((_) async => Left(PaymentStatusIsNotSelectedFailure()));
        return paymentBloc;
      },
      act: (bloc) => bloc.add(CompletePayment(tPaymentParams)),
      verify: (_) {
        verify(() => mockCompletePaymentUseCase(tPaymentParams)).called(1);
      },
      expect: () => [
        CompletePaymentLoading(),
        CompletePaymentFailed(PaymentStatusIsNotSelectedFailure()),
      ],
    );


        blocTest<PaymentBloc, PaymentState>(
      'emits [CompletePaymentLoading, CompletePaymentFailed] on CompletePayment error',
      build: () {
        when(() => mockCompletePaymentUseCase(tPaymentParams))
            .thenAnswer((_) async => Left(FailedToUpdatePaymentModeFailure()));
        return paymentBloc;
      },
      act: (bloc) => bloc.add(CompletePayment(tPaymentParams)),
      verify: (_) {
        verify(() => mockCompletePaymentUseCase(tPaymentParams)).called(1);
      },
      expect: () => [
        CompletePaymentLoading(),
        CompletePaymentFailed(FailedToUpdatePaymentModeFailure()),
      ],
    );


        blocTest<PaymentBloc, PaymentState>(
      'emits [CompletePaymentLoading, CompletePaymentFailed] on CompletePayment error',
      build: () {
        when(() => mockCompletePaymentUseCase(tPaymentParams))
            .thenAnswer((_) async => Left(BusinessExceptionFailure("Error")));
        return paymentBloc;
      },
      act: (bloc) => bloc.add(CompletePayment(tPaymentParams)),
      verify: (_) {
        verify(() => mockCompletePaymentUseCase(tPaymentParams)).called(1);
      },
      expect: () => [
        CompletePaymentLoading(),
        CompletePaymentFailed(BusinessExceptionFailure("Error")),
      ],
    );


        blocTest<PaymentBloc, PaymentState>(
      'emits [CompletePaymentLoading, CompletePaymentFailed] on CompletePayment error',
      build: () {
        when(() => mockCompletePaymentUseCase(tPaymentParams))
            .thenAnswer((_) async => Left(ServerFailure()));
        return paymentBloc;
      },
      act: (bloc) => bloc.add(CompletePayment(tPaymentParams)),
      verify: (_) {
        verify(() => mockCompletePaymentUseCase(tPaymentParams)).called(1);
      },
      expect: () => [
        CompletePaymentLoading(),
        CompletePaymentFailed(ServerFailure()),
      ],
    );






  });
}
