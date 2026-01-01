import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foody_licious/core/error/failures.dart';
import 'package:foody_licious/core/network/network_info.dart';
import 'package:foody_licious/data/data_sources/local/user_local_data_source.dart';
import 'package:foody_licious/data/data_sources/remote/menu_remote_data_source.dart';
import 'package:foody_licious/data/models/menuItem/menu_items_response_model.dart';
import 'package:foody_licious/data/repositories/menu_item_repository_impl.dart';
import 'package:mocktail/mocktail.dart';

import '../../fixtures/constant_objects.dart';

class MockRemoteDataSource extends Mock implements MenuItemsRemoteDataSource {}

class MockLocalDataSource extends Mock implements UserLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late MenuItemRepositoryImpl repository;
  late MockRemoteDataSource mockRemoteDataSource;
  late MockLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = MenuItemRepositoryImpl(
      menuItemsRemoteDataSource: mockRemoteDataSource,
      userLocalDataSource: mockLocalDataSource,
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
    group('getAllItemsInRestaurantsOfUsersCity', () {
      test(
        'Should return Right(List<MenuItem>) when menuItemsRemoteDataSource.getAllItemsInRestaurantsOfUsersCity success',
        () async {
          // Arrange
          when(() => mockLocalDataSource.getUser())
              .thenAnswer((_) async => tUserModel);
          when(
            () => mockRemoteDataSource.getAllItemsInRestaurantsOfUsersCity(
                tGetAllItemsInRestaurantsOfUsersCityParams),
          ).thenAnswer((_) async => tMenuItemsResponseModel);
          // Act
          final result = await repository.getAllItemsInRestaurantsOfUsersCity(
              tGetAllItemsInRestaurantsOfUsersCityParams);
          // Assert
          verify(() => mockLocalDataSource.getUser()).called(1);
          verify(
            () => mockRemoteDataSource.getAllItemsInRestaurantsOfUsersCity(
                tGetAllItemsInRestaurantsOfUsersCityParams),
          ).called(1);
          expect(result, Right(tMenuItemsResponseModel.menuItems));
        },
      );

      test(
          'should return Left(Failure) when menuItemsRemoteDataSource.getAllItemsInRestaurantsOfUsersCity throws CredentialFailure',
          () async {
        // arrange
        when(() => mockLocalDataSource.getUser())
            .thenAnswer((_) async => tUserModel);
        when(() => mockRemoteDataSource.getAllItemsInRestaurantsOfUsersCity(
                tGetAllItemsInRestaurantsOfUsersCityParams))
            .thenThrow(CredentialFailure());

        // act
        final result = await repository.getAllItemsInRestaurantsOfUsersCity(
            tGetAllItemsInRestaurantsOfUsersCityParams);

        // assert
        verify(() => mockRemoteDataSource.getAllItemsInRestaurantsOfUsersCity(
            tGetAllItemsInRestaurantsOfUsersCityParams)).called(1);
        expect(result, Left(CredentialFailure()));
      });

      test(
          'should return Left(Failure) when menuItemsRemoteDataSource.getAllItemsInRestaurantsOfUsersCity throws ServerFailure',
          () async {
        // arrange
        when(() => mockLocalDataSource.getUser())
            .thenAnswer((_) async => tUserModel);
        when(() => mockRemoteDataSource.getAllItemsInRestaurantsOfUsersCity(
                tGetAllItemsInRestaurantsOfUsersCityParams))
            .thenThrow(ServerFailure());

        // act
        final result = await repository.getAllItemsInRestaurantsOfUsersCity(
            tGetAllItemsInRestaurantsOfUsersCityParams);

        // assert
        verify(() => mockRemoteDataSource.getAllItemsInRestaurantsOfUsersCity(
            tGetAllItemsInRestaurantsOfUsersCityParams)).called(1);
        expect(result, Left(ServerFailure()));
      });
    });

    group('getAllItemsInRestaurant', () {
      test(
        'Should return Right(List<MenuItem>) when menuItemsRemoteDataSource.getAllItemsInRestaurant success',
        () async {
          // Arrange
          when(
            () => mockRemoteDataSource.getAllItemsInRestaurant(
                tGetAllMenuItemsInRestaurantParams),
          ).thenAnswer((_) async => tMenuItemsResponseModel);

          // Act
          final result = await repository.getAllItemsInRestaurant(
              tGetAllMenuItemsInRestaurantParams);
          
          // Assert
          verify(
            () => mockRemoteDataSource.getAllItemsInRestaurant(
                tGetAllMenuItemsInRestaurantParams),
          ).called(1);
          expect(result, Right(tMenuItemsResponseModel.menuItems));
        },
      );

      test(
          'should return Left(Failure) when menuItemsRemoteDataSource.getAllItemsInRestaurant throws CredentialFailure',
          () async {
        // arrange
        when(() => mockRemoteDataSource.getAllItemsInRestaurant(
                tGetAllMenuItemsInRestaurantParams))
            .thenThrow(CredentialFailure());

        // act
        final result = await repository.getAllItemsInRestaurant(
            tGetAllMenuItemsInRestaurantParams);

        // assert
        verify(() => mockRemoteDataSource.getAllItemsInRestaurant(
            tGetAllMenuItemsInRestaurantParams)).called(1);
        expect(result, Left(CredentialFailure()));
      });

      test(
          'should return Left(Failure) when menuItemsRemoteDataSource.getAllItemsInRestaurant throws ServerFailure',
          () async {
        // arrange
        when(() => mockRemoteDataSource.getAllItemsInRestaurant(
                tGetAllMenuItemsInRestaurantParams))
            .thenThrow(ServerFailure());

        // act
        final result = await repository.getAllItemsInRestaurant(
            tGetAllMenuItemsInRestaurantParams);

        // assert
        verify(() => mockRemoteDataSource.getAllItemsInRestaurant(
            tGetAllMenuItemsInRestaurantParams)).called(1);
        expect(result, Left(ServerFailure()));
      });
    });  
  });
}
