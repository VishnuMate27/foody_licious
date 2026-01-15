import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foody_licious/core/error/failures.dart';
import 'package:foody_licious/core/network/network_info.dart';
import 'package:foody_licious/data/data_sources/remote/restaurant_remote_data_source.dart';
import 'package:foody_licious/data/repositories/restaurant_repository_impl.dart';
import 'package:mocktail/mocktail.dart';

import '../../fixtures/constant_objects.dart';

class MockRemoteDataSource extends Mock implements RestaurantRemoteDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late RestaurantRepositoryImpl repository;
  late MockRemoteDataSource mockRemoteDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = RestaurantRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
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
    group('getRestaurantDetails', () {
      test(
        'Should return Right(List<MenuItem>) when menuItemsRemoteDataSource.getAllItemsInRestaurantsOfUsersCity success',
        () async {
          // Arrange
          when(
            () => mockRemoteDataSource
                .getRestaurantDetails(tGetRestaurantDetailsParams),
          ).thenAnswer((_) async => tRestaurantResponseModel);
          // Act
          final result = await repository
              .getRestaurantDetails(tGetRestaurantDetailsParams);
          // Assert
          verify(
            () => mockRemoteDataSource
                .getRestaurantDetails(tGetRestaurantDetailsParams),
          ).called(1);
          expect(result, Right(tRestaurantResponseModel.restaurant));
        },
      );

      test(
        'Should return Left(CredentialFailure) when menuItemsRemoteDataSource.getAllItemsInRestaurantsOfUsersCity success',
        () async {
          // Arrange
          when(
            () => mockRemoteDataSource
                .getRestaurantDetails(tGetRestaurantDetailsParams),
          ).thenThrow(CredentialFailure());
          // Act
          final result = await repository
              .getRestaurantDetails(tGetRestaurantDetailsParams);
          // Assert
          verify(
            () => mockRemoteDataSource
                .getRestaurantDetails(tGetRestaurantDetailsParams),
          ).called(1);
          expect(result, Left(CredentialFailure()));
        },
      );

      test(
        'Should return Left(RestaurantNotExistsFailure) when menuItemsRemoteDataSource.getAllItemsInRestaurantsOfUsersCity success',
        () async {
          // Arrange
          when(
            () => mockRemoteDataSource
                .getRestaurantDetails(tGetRestaurantDetailsParams),
          ).thenThrow(RestaurantNotExistsFailure());
          // Act
          final result = await repository
              .getRestaurantDetails(tGetRestaurantDetailsParams);
          // Assert
          verify(
            () => mockRemoteDataSource
                .getRestaurantDetails(tGetRestaurantDetailsParams),
          ).called(1);
          expect(result, Left(RestaurantNotExistsFailure()));
        },
      );

      test(
        'Should return Left(ServerFailure) when menuItemsRemoteDataSource.getAllItemsInRestaurantsOfUsersCity success',
        () async {
          // Arrange
          when(
            () => mockRemoteDataSource
                .getRestaurantDetails(tGetRestaurantDetailsParams),
          ).thenThrow(ServerFailure());
          // Act
          final result = await repository
              .getRestaurantDetails(tGetRestaurantDetailsParams);
          // Assert
          verify(
            () => mockRemoteDataSource
                .getRestaurantDetails(tGetRestaurantDetailsParams),
          ).called(1);
          expect(result, Left(ServerFailure()));
        },
      );      
    });
  });
}
