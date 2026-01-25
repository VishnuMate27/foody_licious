import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foody_licious/core/error/failures.dart';
import 'package:foody_licious/core/network/network_info.dart';
import 'package:foody_licious/data/data_sources/local/user_local_data_source.dart';
import 'package:foody_licious/data/data_sources/remote/checkout_remote_data_source.dart';
import 'package:foody_licious/data/repositories/checkout_repository_impl.dart';
import 'package:mocktail/mocktail.dart';

import '../../fixtures/constant_objects.dart';

class MockCheckoutRemoteDataSource extends Mock
    implements CheckoutRemoteDataSource {}

class MockUserLocalDataSource extends Mock implements UserLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late CheckoutRepositoryImpl repository;
  late MockCheckoutRemoteDataSource mockCheckoutRemoteDataSource;
  late MockUserLocalDataSource mockUserLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUpAll(() {
    mockCheckoutRemoteDataSource = MockCheckoutRemoteDataSource();
    mockUserLocalDataSource = MockUserLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = CheckoutRepositoryImpl(
      checkoutRemoteDataSource: mockCheckoutRemoteDataSource,
      userLocalDataSource: mockUserLocalDataSource,
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
    group('placeOrder', () {
      test(
        'Should return Right(PlaceOrderModel) when remoteDataSource.placeOrder succecced',
        () async {
          // arrange
          when(() => mockUserLocalDataSource.getUser())
              .thenAnswer((_) async => tUserModel);

          tPlaceOrderParams.userId = tUserModel.id;

          when(() => mockCheckoutRemoteDataSource.placeOrder(tPlaceOrderParams))
              .thenAnswer((_) async => tPlaceOrderModel);

          // act
          final result = await repository.placeOrder(tPlaceOrderParams);

          verify(() => mockUserLocalDataSource.getUser()).called(1);
          verify(() =>
                  mockCheckoutRemoteDataSource.placeOrder(tPlaceOrderParams))
              .called(1);

          // assert
          expect(result, Right(tPlaceOrderModel));
        },
      );

      test(
        'Should return Left(Failure) when remoteDataSource.placeOrder throws CredentialFailure',
        () async {
          // arrange
          when(() => mockUserLocalDataSource.getUser())
              .thenAnswer((_) async => tUserModel);

          tPlaceOrderParams.userId = tUserModel.id;

          when(() => mockCheckoutRemoteDataSource.placeOrder(tPlaceOrderParams))
              .thenThrow(CredentialFailure());

          // act
          final result = await repository.placeOrder(tPlaceOrderParams);

          verify(() => mockUserLocalDataSource.getUser()).called(1);
          verify(() =>
                  mockCheckoutRemoteDataSource.placeOrder(tPlaceOrderParams))
              .called(1);

          // assert
          expect(result, Left(CredentialFailure()));
        },
      );

      // Business Failure Case

      test(
        'Should return Left(Failure) when remoteDataSource.placeOrder throws CartLockedFailure',
        () async {
          // arrange
          when(() => mockUserLocalDataSource.getUser())
              .thenAnswer((_) async => tUserModel);

          tPlaceOrderParams.userId = tUserModel.id;

          when(() => mockCheckoutRemoteDataSource.placeOrder(tPlaceOrderParams))
              .thenThrow(CartLockedFailure());

          // act
          final result = await repository.placeOrder(tPlaceOrderParams);

          verify(() => mockUserLocalDataSource.getUser()).called(1);
          verify(() =>
                  mockCheckoutRemoteDataSource.placeOrder(tPlaceOrderParams))
              .called(1);

          // assert
          expect(result, Left(CartLockedFailure()));
        },
      );

      test(
        'Should return Left(Failure) when remoteDataSource.placeOrder throws CartEmptyFailure',
        () async {
          // arrange
          when(() => mockUserLocalDataSource.getUser())
              .thenAnswer((_) async => tUserModel);

          tPlaceOrderParams.userId = tUserModel.id;

          when(() => mockCheckoutRemoteDataSource.placeOrder(tPlaceOrderParams))
              .thenThrow(CartEmptyFailure());

          // act
          final result = await repository.placeOrder(tPlaceOrderParams);

          verify(() => mockUserLocalDataSource.getUser()).called(1);
          verify(() =>
                  mockCheckoutRemoteDataSource.placeOrder(tPlaceOrderParams))
              .called(1);

          // assert
          expect(result, Left(CartEmptyFailure()));
        },
      );

      test(
        'Should return Left(Failure) when remoteDataSource.placeOrder throws OldOrderPendingFailure',
        () async {
          // arrange
          when(() => mockUserLocalDataSource.getUser())
              .thenAnswer((_) async => tUserModel);

          tPlaceOrderParams.userId = tUserModel.id;

          when(() => mockCheckoutRemoteDataSource.placeOrder(tPlaceOrderParams))
              .thenThrow(OldOrderPendingFailure());

          // act
          final result = await repository.placeOrder(tPlaceOrderParams);

          verify(() => mockUserLocalDataSource.getUser()).called(1);
          verify(() =>
                  mockCheckoutRemoteDataSource.placeOrder(tPlaceOrderParams))
              .called(1);

          // assert
          expect(result, Left(OldOrderPendingFailure()));
        },
      );
      test(
        'Should return Left(Failure) when remoteDataSource.placeOrder throws CartNotExistsFailure',
        () async {
          // arrange
          when(() => mockUserLocalDataSource.getUser())
              .thenAnswer((_) async => tUserModel);

          tPlaceOrderParams.userId = tUserModel.id;

          when(() => mockCheckoutRemoteDataSource.placeOrder(tPlaceOrderParams))
              .thenThrow(CartNotExistsFailure());

          // act
          final result = await repository.placeOrder(tPlaceOrderParams);

          verify(() => mockUserLocalDataSource.getUser()).called(1);
          verify(() =>
                  mockCheckoutRemoteDataSource.placeOrder(tPlaceOrderParams))
              .called(1);

          // assert
          expect(result, Left(CartNotExistsFailure()));
        },
      );
      test(
        'Should return Left(Failure) when remoteDataSource.placeOrder throws CartLockFailedFailure',
        () async {
          // arrange
          when(() => mockUserLocalDataSource.getUser())
              .thenAnswer((_) async => tUserModel);

          tPlaceOrderParams.userId = tUserModel.id;

          when(() => mockCheckoutRemoteDataSource.placeOrder(tPlaceOrderParams))
              .thenThrow(CartLockFailedFailure());

          // act
          final result = await repository.placeOrder(tPlaceOrderParams);

          verify(() => mockUserLocalDataSource.getUser()).called(1);
          verify(() =>
                  mockCheckoutRemoteDataSource.placeOrder(tPlaceOrderParams))
              .called(1);

          // assert
          expect(result, Left(CartLockFailedFailure()));
        },
      );

      test(
        'Should return Left(Failure) when remoteDataSource.placeOrder throws OrderNotFoundFailure',
        () async {
          // arrange
          when(() => mockUserLocalDataSource.getUser())
              .thenAnswer((_) async => tUserModel);

          tPlaceOrderParams.userId = tUserModel.id;

          when(() => mockCheckoutRemoteDataSource.placeOrder(tPlaceOrderParams))
              .thenThrow(OrderNotFoundFailure());

          // act
          final result = await repository.placeOrder(tPlaceOrderParams);

          verify(() => mockUserLocalDataSource.getUser()).called(1);
          verify(() =>
                  mockCheckoutRemoteDataSource.placeOrder(tPlaceOrderParams))
              .called(1);

          // assert
          expect(result, Left(OrderNotFoundFailure()));
        },
      );

      test(
        'Should return Left(Failure) when remoteDataSource.placeOrder throws OrderStatusNotPendingPaymentFailure',
        () async {
          // arrange
          when(() => mockUserLocalDataSource.getUser())
              .thenAnswer((_) async => tUserModel);

          tPlaceOrderParams.userId = tUserModel.id;

          when(() => mockCheckoutRemoteDataSource.placeOrder(tPlaceOrderParams))
              .thenThrow(OrderStatusNotPendingPaymentFailure());

          // act
          final result = await repository.placeOrder(tPlaceOrderParams);

          verify(() => mockUserLocalDataSource.getUser()).called(1);
          verify(() =>
                  mockCheckoutRemoteDataSource.placeOrder(tPlaceOrderParams))
              .called(1);

          // assert
          expect(result, Left(OrderStatusNotPendingPaymentFailure()));
        },
      );

      test(
        'Should return Left(Failure) when remoteDataSource.placeOrder throws PaymentStatusAlreadySuccessFailure',
        () async {
          // arrange
          when(() => mockUserLocalDataSource.getUser())
              .thenAnswer((_) async => tUserModel);

          tPlaceOrderParams.userId = tUserModel.id;

          when(() => mockCheckoutRemoteDataSource.placeOrder(tPlaceOrderParams))
              .thenThrow(PaymentStatusAlreadySuccessFailure());

          // act
          final result = await repository.placeOrder(tPlaceOrderParams);

          verify(() => mockUserLocalDataSource.getUser()).called(1);
          verify(() =>
                  mockCheckoutRemoteDataSource.placeOrder(tPlaceOrderParams))
              .called(1);

          // assert
          expect(result, Left(PaymentStatusAlreadySuccessFailure()));
        },
      );

      test(
        'Should return Left(Failure) when remoteDataSource.placeOrder throws OldPaymentStatusAlreadyPendingFailure',
        () async {
          // arrange
          when(() => mockUserLocalDataSource.getUser())
              .thenAnswer((_) async => tUserModel);

          tPlaceOrderParams.userId = tUserModel.id;

          when(() => mockCheckoutRemoteDataSource.placeOrder(tPlaceOrderParams))
              .thenThrow(OldPaymentStatusAlreadyPendingFailure());

          // act
          final result = await repository.placeOrder(tPlaceOrderParams);

          verify(() => mockUserLocalDataSource.getUser()).called(1);
          verify(() =>
                  mockCheckoutRemoteDataSource.placeOrder(tPlaceOrderParams))
              .called(1);

          // assert
          expect(result, Left(OldPaymentStatusAlreadyPendingFailure()));
        },
      );

      test(
        'Should return Left(Failure) when remoteDataSource.placeOrder throws BusinessExceptionFailure',
        () async {
          // arrange
          when(() => mockUserLocalDataSource.getUser())
              .thenAnswer((_) async => tUserModel);

          tPlaceOrderParams.userId = tUserModel.id;

          when(() => mockCheckoutRemoteDataSource.placeOrder(tPlaceOrderParams))
              .thenThrow(BusinessExceptionFailure("Error"));

          // act
          final result = await repository.placeOrder(tPlaceOrderParams);

          verify(() => mockUserLocalDataSource.getUser()).called(1);
          verify(() =>
                  mockCheckoutRemoteDataSource.placeOrder(tPlaceOrderParams))
              .called(1);

          // assert
          expect(result, Left(BusinessExceptionFailure("Error")));
        },
      );

      test(
        'Should return Left(Failure) when remoteDataSource.placeOrder throws ServerFailure',
        () async {
          // arrange
          when(() => mockUserLocalDataSource.getUser())
              .thenAnswer((_) async => tUserModel);

          tPlaceOrderParams.userId = tUserModel.id;

          when(() => mockCheckoutRemoteDataSource.placeOrder(tPlaceOrderParams))
              .thenThrow(ServerFailure());

          // act
          final result = await repository.placeOrder(tPlaceOrderParams);

          verify(() => mockUserLocalDataSource.getUser()).called(1);
          verify(() =>
                  mockCheckoutRemoteDataSource.placeOrder(tPlaceOrderParams))
              .called(1);

          // assert
          expect(result, Left(ServerFailure()));
        },
      );
    });

    group('cancelCheckout', () {
      test(
        'Should return Right(Unit) when remoteDataSource.cancelCheckout succecced',
        () async {
          // arrange
          when(() => mockCheckoutRemoteDataSource.cancelCheckout(
              tCancelCheckoutParams)).thenAnswer((_) async => unit);

          // act
          final result = await repository.cancelCheckout(tCancelCheckoutParams);

          verify(() => mockCheckoutRemoteDataSource
              .cancelCheckout(tCancelCheckoutParams)).called(1);

          // assert
          expect(result, Right(unit));
        },
      );

      test(
        'Should return Left(Failure) when remoteDataSource.cancelCheckout throws CredentialFailure',
        () async {
          // arrange

          when(() => mockCheckoutRemoteDataSource.cancelCheckout(
              tCancelCheckoutParams)).thenThrow(CredentialFailure());

          // act
          final result = await repository.cancelCheckout(tCancelCheckoutParams);

          verify(() => mockCheckoutRemoteDataSource
              .cancelCheckout(tCancelCheckoutParams)).called(1);

          // assert
          expect(result, Left(CredentialFailure()));
        },
      );

      // Business Failure Case
      test(
        'Should return Left(Failure) when remoteDataSource.cancelCheckout throws PaymentRequestNotFoundFailure',
        () async {
          // arrange

          when(() => mockCheckoutRemoteDataSource
                  .cancelCheckout(tCancelCheckoutParams))
              .thenThrow(PaymentRequestNotFoundFailure());

          // act
          final result = await repository.cancelCheckout(tCancelCheckoutParams);

          verify(() => mockCheckoutRemoteDataSource
              .cancelCheckout(tCancelCheckoutParams)).called(1);

          // assert
          expect(result, Left(PaymentRequestNotFoundFailure()));
        },
      );

      test(
        'Should return Left(Failure) when remoteDataSource.cancelCheckout throws PaymentStatusIsNotPendingFailure',
        () async {
          // arrange

          when(() => mockCheckoutRemoteDataSource
                  .cancelCheckout(tCancelCheckoutParams))
              .thenThrow(PaymentStatusIsNotPendingFailure());

          // act
          final result = await repository.cancelCheckout(tCancelCheckoutParams);

          verify(() => mockCheckoutRemoteDataSource
              .cancelCheckout(tCancelCheckoutParams)).called(1);

          // assert
          expect(result, Left(PaymentStatusIsNotPendingFailure()));
        },
      );

      test(
        'Should return Left(Failure) when remoteDataSource.cancelCheckout throws PaymentRequestNotFoundFailure',
        () async {
          // arrange

          when(() => mockCheckoutRemoteDataSource
                  .cancelCheckout(tCancelCheckoutParams))
              .thenThrow(PaymentStatusIsNotPendingFailure());

          // act
          final result = await repository.cancelCheckout(tCancelCheckoutParams);

          verify(() => mockCheckoutRemoteDataSource
              .cancelCheckout(tCancelCheckoutParams)).called(1);

          // assert
          expect(result, Left(PaymentStatusIsNotPendingFailure()));
        },
      );

      test(
        'Should return Left(Failure) when remoteDataSource.cancelCheckout throws PaymentStatusIsNotSelectedFailure',
        () async {
          // arrange

          when(() => mockCheckoutRemoteDataSource
                  .cancelCheckout(tCancelCheckoutParams))
              .thenThrow(PaymentStatusIsNotSelectedFailure());

          // act
          final result = await repository.cancelCheckout(tCancelCheckoutParams);

          verify(() => mockCheckoutRemoteDataSource
              .cancelCheckout(tCancelCheckoutParams)).called(1);

          // assert
          expect(result, Left(PaymentStatusIsNotSelectedFailure()));
        },
      );

      test(
        'Should return Left(Failure) when remoteDataSource.cancelCheckout throws FailedToUpdatePaymentModeFailure',
        () async {
          // arrange

          when(() => mockCheckoutRemoteDataSource
                  .cancelCheckout(tCancelCheckoutParams))
              .thenThrow(FailedToUpdatePaymentModeFailure());

          // act
          final result = await repository.cancelCheckout(tCancelCheckoutParams);

          verify(() => mockCheckoutRemoteDataSource
              .cancelCheckout(tCancelCheckoutParams)).called(1);

          // assert
          expect(result, Left(FailedToUpdatePaymentModeFailure()));
        },
      );

      test(
        'Should return Left(Failure) when remoteDataSource.cancelCheckout throws BusinessExceptionFailure',
        () async {
          // arrange

          when(() => mockCheckoutRemoteDataSource
                  .cancelCheckout(tCancelCheckoutParams))
              .thenThrow(BusinessExceptionFailure("Error"));

          // act
          final result = await repository.cancelCheckout(tCancelCheckoutParams);

          verify(() => mockCheckoutRemoteDataSource
              .cancelCheckout(tCancelCheckoutParams)).called(1);

          // assert
          expect(result, Left(BusinessExceptionFailure("Error")));
        },
      );

      test(
        'Should return Left(Failure) when remoteDataSource.cancelCheckout throws ServerFailure',
        () async {
          // arrange

          when(() => mockCheckoutRemoteDataSource.cancelCheckout(
              tCancelCheckoutParams)).thenThrow(ServerFailure());

          // act
          final result = await repository.cancelCheckout(tCancelCheckoutParams);

          verify(() => mockCheckoutRemoteDataSource
              .cancelCheckout(tCancelCheckoutParams)).called(1);

          // assert
          expect(result, Left(ServerFailure()));
        },
      );
    });
  });
}
