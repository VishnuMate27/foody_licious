import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foody_licious/core/error/failures.dart';
import 'package:foody_licious/core/network/network_info.dart';
import 'package:foody_licious/data/data_sources/remote/payment_remote_data_source.dart';
import 'package:foody_licious/data/repositories/payment_repository_impl.dart';
import 'package:mocktail/mocktail.dart';

import '../../fixtures/constant_objects.dart';

class MockPaymentRemoteDataSource extends Mock
    implements PaymentRemoteDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late PaymentRepositoryImpl repository;
  late MockPaymentRemoteDataSource mockPaymentRemoteDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUpAll(() {
    mockPaymentRemoteDataSource = MockPaymentRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = PaymentRepositoryImpl(
      paymentRemoteDataSource: mockPaymentRemoteDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  void runTestsOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      body();
    });
  }

  void runTestsOffline(Function body) {
    group('device is offline', () {
      setUp(() {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      body();
    });
  }

  runTestsOnline(() {
    group('completePayment', () {
      test(
        'Should return Right(PlaceOrderModel) when remoteDataSource.completePayment succecced',
        () async {
          // arrange
          when(() =>
                  mockPaymentRemoteDataSource.completePayment(tPaymentParams))
              .thenAnswer((_) async => unit);

          // act
          final result = await repository.completePayment(tPaymentParams);
          verify(() =>
                  mockPaymentRemoteDataSource.completePayment(tPaymentParams))
              .called(1);

          // assert
          expect(result, Right(unit));
        },
      );

      test(
        'Should return Left(Failure) when remoteDataSource.completePayment throws CredentialFailure',
        () async {
          // arrange
          when(() =>
                  mockPaymentRemoteDataSource.completePayment(tPaymentParams))
              .thenThrow(CredentialFailure());

          // act
          final result = await repository.completePayment(tPaymentParams);

          verify(() =>
                  mockPaymentRemoteDataSource.completePayment(tPaymentParams))
              .called(1);

          // assert
          expect(result, Left(CredentialFailure()));
        },
      );

      // Business Failure Case

      test(
        'Should return Left(Failure) when remoteDataSource.completePayment throws PaymentRequestNotFoundFailure',
        () async {
          // arrange
          when(() =>
                  mockPaymentRemoteDataSource.completePayment(tPaymentParams))
              .thenThrow(PaymentRequestNotFoundFailure());

          // act
          final result = await repository.completePayment(tPaymentParams);

          verify(() =>
                  mockPaymentRemoteDataSource.completePayment(tPaymentParams))
              .called(1);

          // assert
          expect(result, Left(PaymentRequestNotFoundFailure()));
        },
      );


      test(
        'Should return Left(Failure) when remoteDataSource.completePayment throws PaymentStatusIsNotPendingFailure',
        () async {
          // arrange
          when(() =>
                  mockPaymentRemoteDataSource.completePayment(tPaymentParams))
              .thenThrow(PaymentStatusIsNotPendingFailure());

          // act
          final result = await repository.completePayment(tPaymentParams);

          verify(() =>
                  mockPaymentRemoteDataSource.completePayment(tPaymentParams))
              .called(1);

          // assert
          expect(result, Left(PaymentStatusIsNotPendingFailure()));
        },
      );

      test(
        'Should return Left(Failure) when remoteDataSource.completePayment throws PaymentStatusIsNotSelectedFailure',
        () async {
          // arrange
          when(() =>
                  mockPaymentRemoteDataSource.completePayment(tPaymentParams))
              .thenThrow(PaymentStatusIsNotSelectedFailure());

          // act
          final result = await repository.completePayment(tPaymentParams);

          verify(() =>
                  mockPaymentRemoteDataSource.completePayment(tPaymentParams))
              .called(1);

          // assert
          expect(result, Left(PaymentStatusIsNotSelectedFailure()));
        },
      );

      test(
        'Should return Left(Failure) when remoteDataSource.completePayment throws PaymentStatusIsNotSelectedFailure',
        () async {
          // arrange
          when(() =>
                  mockPaymentRemoteDataSource.completePayment(tPaymentParams))
              .thenThrow(PaymentStatusIsNotSelectedFailure());

          // act
          final result = await repository.completePayment(tPaymentParams);

          verify(() =>
                  mockPaymentRemoteDataSource.completePayment(tPaymentParams))
              .called(1);

          // assert
          expect(result, Left(PaymentStatusIsNotSelectedFailure()));
        },
      );


            test(
        'Should return Left(Failure) when remoteDataSource.completePayment throws FailedToUpdatePaymentModeFailure',
        () async {
          // arrange
          when(() =>
                  mockPaymentRemoteDataSource.completePayment(tPaymentParams))
              .thenThrow(FailedToUpdatePaymentModeFailure());

          // act
          final result = await repository.completePayment(tPaymentParams);

          verify(() =>
                  mockPaymentRemoteDataSource.completePayment(tPaymentParams))
              .called(1);

          // assert
          expect(result, Left(FailedToUpdatePaymentModeFailure()));
        },
      );


            test(
        'Should return Left(Failure) when remoteDataSource.completePayment throws BusinessExceptionFailure',
        () async {
          // arrange
          when(() =>
                  mockPaymentRemoteDataSource.completePayment(tPaymentParams))
              .thenThrow(BusinessExceptionFailure("Error"));

          // act
          final result = await repository.completePayment(tPaymentParams);

          verify(() =>
                  mockPaymentRemoteDataSource.completePayment(tPaymentParams))
              .called(1);

          // assert
          expect(result, Left(BusinessExceptionFailure("Error")));
        },
      );


      test(
        'Should return Left(Failure) when remoteDataSource.completePayment throws ServerFailure',
        () async {
          // arrange
          when(() =>
                  mockPaymentRemoteDataSource.completePayment(tPaymentParams))
              .thenThrow(ServerFailure());

          // act
          final result = await repository.completePayment(tPaymentParams);

          verify(() =>
                  mockPaymentRemoteDataSource.completePayment(tPaymentParams))
              .called(1);

          // assert
          expect(result, Left(ServerFailure()));
        },
      );

    });
  });
}
