import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foody_licious/core/error/failures.dart';
import 'package:foody_licious/core/network/network_info.dart';
import 'package:foody_licious/data/data_sources/local/user_local_data_source.dart';
import 'package:foody_licious/data/data_sources/remote/cart_remote_data_source.dart';
import 'package:foody_licious/data/models/user/user_model.dart';
import 'package:foody_licious/data/repositories/cart_repository_impl.dart';
import 'package:foody_licious/domain/usecase/cart/get_cart_pricing_details_usecase.dart';
import 'package:mocktail/mocktail.dart';

import '../../fixtures/constant_objects.dart';

class MockCartRemoteDataSource extends Mock implements CartRemoteDataSource {}

class MockUserLocalDataSource extends Mock implements UserLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late CartRepositoryImpl repository;
  late MockCartRemoteDataSource mockCartRemoteDataSource;
  late MockUserLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUpAll(() {
    mockCartRemoteDataSource = MockCartRemoteDataSource();
    mockLocalDataSource = MockUserLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = CartRepositoryImpl(
      networkInfo: mockNetworkInfo,
      cartRemoteDataSource: mockCartRemoteDataSource,
      userLocalDataSource: mockLocalDataSource,
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
    group('getAllCartItem', () {
      test(
          'Should return Right(List<CartItem>) when remoteDataSource.getAllCartItem succecced',
          () async {
        // arrange
        when(() => mockLocalDataSource.getUser())
            .thenAnswer((_) async => tUserModel);

        tGetAllCartItemParams.userId = tUserModel.id;

        when(() =>
                mockCartRemoteDataSource.getAllCartItem(tGetAllCartItemParams))
            .thenAnswer((_) async => tCartItemsResponseModel);

        // act
        final result = await repository.getAllCartItem(tGetAllCartItemParams);

        // assert
        verify(() => mockLocalDataSource.getUser()).called(1);
        verify(() =>
                mockCartRemoteDataSource.getAllCartItem(tGetAllCartItemParams))
            .called(1);

        expect(result, Right(tCartItemsResponseModel.cartItems));
      });

      test(
          'Should return Left(Failure) when remoteDataSource.getAllCartItem throws CredentialFailure',
          () async {
        // arrange
        when(() => mockLocalDataSource.getUser())
            .thenAnswer((_) async => tUserModel);
        tGetAllCartItemParams.userId = tUserModel.id;
        when(() =>
                mockCartRemoteDataSource.getAllCartItem(tGetAllCartItemParams))
            .thenThrow(CredentialFailure());

        // act
        final result = await repository.getAllCartItem(tGetAllCartItemParams);

        // assert
        verify(() =>
                mockCartRemoteDataSource.getAllCartItem(tGetAllCartItemParams))
            .called(1);
        expect(result, Left(CredentialFailure()));
      });

      test(
          'Should return Left(Failure) when remoteDataSource.getAllCartItem throws CartNotExistsFailure',
          () async {
        // arrange
        when(() => mockLocalDataSource.getUser())
            .thenAnswer((_) async => tUserModel);
        tGetAllCartItemParams.userId = tUserModel.id;
        when(() =>
                mockCartRemoteDataSource.getAllCartItem(tGetAllCartItemParams))
            .thenThrow(CartNotExistsFailure());

        // act
        final result = await repository.getAllCartItem(tGetAllCartItemParams);

        // assert
        verify(() =>
                mockCartRemoteDataSource.getAllCartItem(tGetAllCartItemParams))
            .called(1);
        expect(result, Left(CartNotExistsFailure()));
      });

      test(
          'Should return Left(Failure) when remoteDataSource.getAllCartItem throws ServerFailure',
          () async {
        // arrange
        when(() => mockLocalDataSource.getUser())
            .thenAnswer((_) async => tUserModel);
        tGetAllCartItemParams.userId = tUserModel.id;
        when(() =>
                mockCartRemoteDataSource.getAllCartItem(tGetAllCartItemParams))
            .thenThrow(ServerFailure());

        // act
        final result = await repository.getAllCartItem(tGetAllCartItemParams);

        // assert
        verify(() =>
                mockCartRemoteDataSource.getAllCartItem(tGetAllCartItemParams))
            .called(1);
        expect(result, Left(ServerFailure()));
      });
    });

    group('getCartPricingDetails', () {
      test(
          'Should return Right(CartPricingDetails) when remoteDataSource.getCartPricingDetails succecced',
          () async {
        // arrange
        when(() => mockLocalDataSource.getUser())
            .thenAnswer((_) async => tUserModel);

        tGetCartPricingDetailsParams.userId = tUserModel.id;

        when(() => mockCartRemoteDataSource
                .getCartPricingDetails(tGetCartPricingDetailsParams))
            .thenAnswer((_) async => tCartPricingDetailsResponseModel);

        // act
        final result = await repository
            .getCartPricingDetails(tGetCartPricingDetailsParams);

        // TODO: Add Proper verify case for getUser called times
        // verify(() => mockLocalDataSource.getUser()).called(1);

        // assert
        verify(() => mockCartRemoteDataSource
            .getCartPricingDetails(tGetCartPricingDetailsParams)).called(1);

        expect(
            result, Right(tCartPricingDetailsResponseModel.cartPricingDetails));
      });

      test(
          'Should return Left(Failure) when remoteDataSource.getCartPricingDetails throws CredentialFailure',
          () async {
        // arrange
        when(() => mockLocalDataSource.getUser())
            .thenAnswer((_) async => tUserModel);
        final params = GetCartPricingDetailsParams(
          userId: tUserModel.id,
        );
        when(() => mockCartRemoteDataSource.getCartPricingDetails(params))
            .thenThrow(CredentialFailure());

        // act
        final result = await repository.getCartPricingDetails(params);

        // assert
        verify(() => mockCartRemoteDataSource.getCartPricingDetails(params))
            .called(1);
        expect(result, Left(CredentialFailure()));
      });

      test(
          'Should return Left(Failure) when remoteDataSource.getCartPricingDetails throws CartNotExistsFailure',
          () async {
        // arrange
        when(() => mockLocalDataSource.getUser())
            .thenAnswer((_) async => tUserModel);
        final params = GetCartPricingDetailsParams(
          userId: tUserModel.id,
        );
        when(() => mockCartRemoteDataSource.getCartPricingDetails(params))
            .thenThrow(CartNotExistsFailure());

        // act
        final result = await repository.getCartPricingDetails(params);

        // assert
        verify(() => mockCartRemoteDataSource.getCartPricingDetails(params))
            .called(1);
        expect(result, Left(CartNotExistsFailure()));
      });

      test(
          'Should return Left(Failure) when remoteDataSource.getCartPricingDetails throws ServerFailure',
          () async {
        // arrange
        when(() => mockLocalDataSource.getUser())
            .thenAnswer((_) async => tUserModel);
        final params = GetCartPricingDetailsParams(
          userId: tUserModel.id,
        );
        when(() => mockCartRemoteDataSource.getCartPricingDetails(params))
            .thenThrow(ServerFailure());

        // act
        final result = await repository.getCartPricingDetails(params);

        // assert
        verify(() => mockCartRemoteDataSource.getCartPricingDetails(params))
            .called(1);
        expect(result, Left(ServerFailure()));
      });
    });

    group('addItemToCart', () {
      test(
          'Should return Right(Unit) when remoteDataSource.addItemToCart succecced',
          () async {
        // arrange
        when(() => mockLocalDataSource.getUser())
            .thenAnswer((_) async => tUserModel);
        tGetAllCartItemParams.userId = tUserModel.id;
        when(() => mockCartRemoteDataSource.addItemToCart(tAddItemToCartParams))
            .thenAnswer((_) async => unit);

        // act
        final result = await repository.addItemToCart(tAddItemToCartParams);

        // assert
        verify(() =>
                mockCartRemoteDataSource.addItemToCart(tAddItemToCartParams))
            .called(1);

        expect(result, Right(unit));
      });

      test(
          'Should return Left(Failure) when remoteDataSource.addItemToCart throws CredentialFailure',
          () async {
        // arrange
        when(() => mockLocalDataSource.getUser())
            .thenAnswer((_) async => tUserModel);
        tGetAllCartItemParams.userId = tUserModel.id;
        when(() => mockCartRemoteDataSource.addItemToCart(tAddItemToCartParams))
            .thenThrow(CredentialFailure());

        // act
        final result = await repository.addItemToCart(tAddItemToCartParams);

        // assert
        verify(() =>
                mockCartRemoteDataSource.addItemToCart(tAddItemToCartParams))
            .called(1);
        expect(result, Left(CredentialFailure()));
      });

      test(
          'Should return Left(Failure) when remoteDataSource.addItemToCart throws CartNotExistsFailure',
          () async {
        // arrange
        when(() => mockLocalDataSource.getUser())
            .thenAnswer((_) async => tUserModel);
        tGetAllCartItemParams.userId = tUserModel.id;
        when(() => mockCartRemoteDataSource.addItemToCart(tAddItemToCartParams))
            .thenThrow(MenuItemNotExistsFailure());

        // act
        final result = await repository.addItemToCart(tAddItemToCartParams);

        // assert
        verify(() =>
                mockCartRemoteDataSource.addItemToCart(tAddItemToCartParams))
            .called(1);
        expect(result, Left(MenuItemNotExistsFailure()));
      });

      test(
          'Should return Left(Failure) when remoteDataSource.addItemToCart throws MenuItemOutOfStockFailure',
          () async {
        // arrange
        when(() => mockLocalDataSource.getUser())
            .thenAnswer((_) async => tUserModel);
        tGetAllCartItemParams.userId = tUserModel.id;
        when(() => mockCartRemoteDataSource.addItemToCart(tAddItemToCartParams))
            .thenThrow(MenuItemOutOfStockFailure());

        // act
        final result = await repository.addItemToCart(tAddItemToCartParams);

        // assert
        verify(() =>
                mockCartRemoteDataSource.addItemToCart(tAddItemToCartParams))
            .called(1);
        expect(result, Left(MenuItemOutOfStockFailure()));
      });

      test(
          'Should return Left(Failure) when remoteDataSource.addItemToCart throws ServerFailure',
          () async {
        // arrange
        when(() => mockLocalDataSource.getUser())
            .thenAnswer((_) async => tUserModel);
        tGetAllCartItemParams.userId = tUserModel.id;
        when(() => mockCartRemoteDataSource.addItemToCart(tAddItemToCartParams))
            .thenThrow(ServerFailure());

        // act
        final result = await repository.addItemToCart(tAddItemToCartParams);

        // assert
        verify(() =>
                mockCartRemoteDataSource.addItemToCart(tAddItemToCartParams))
            .called(1);
        expect(result, Left(ServerFailure()));
      });
    });

    group('deleteItemInCart', () {
      test(
          'Should return Right(Unit) when remoteDataSource.deleteItemInCart succecced',
          () async {
        // arrange
        when(() => mockLocalDataSource.getUser())
            .thenAnswer((_) async => tUserModel);
        tGetAllCartItemParams.userId = tUserModel.id;
        when(() => mockCartRemoteDataSource.deleteItemInCart(
            tDeleteItemInCartParams)).thenAnswer((_) async => unit);

        // act
        final result =
            await repository.deleteItemInCart(tDeleteItemInCartParams);

        // assert
        verify(() => mockCartRemoteDataSource
            .deleteItemInCart(tDeleteItemInCartParams)).called(1);

        expect(result, Right(unit));
      });

      test(
          'Should return Left(Failure) when remoteDataSource.deleteItemInCart throws CredentialFailure',
          () async {
        // arrange
        when(() => mockLocalDataSource.getUser())
            .thenAnswer((_) async => tUserModel);
        tGetAllCartItemParams.userId = tUserModel.id;
        when(() => mockCartRemoteDataSource.deleteItemInCart(
            tDeleteItemInCartParams)).thenThrow(CredentialFailure());

        // act
        final result =
            await repository.deleteItemInCart(tDeleteItemInCartParams);

        // assert
        verify(() => mockCartRemoteDataSource
            .deleteItemInCart(tDeleteItemInCartParams)).called(1);
        expect(result, Left(CredentialFailure()));
      });

      test(
          'Should return Left(Failure) when remoteDataSource.deleteItemInCart throws MenuItemNotExistsFailure',
          () async {
        // arrange
        when(() => mockLocalDataSource.getUser())
            .thenAnswer((_) async => tUserModel);
        tGetAllCartItemParams.userId = tUserModel.id;
        when(() => mockCartRemoteDataSource.deleteItemInCart(
            tDeleteItemInCartParams)).thenThrow(MenuItemNotExistsFailure());

        // act
        final result =
            await repository.deleteItemInCart(tDeleteItemInCartParams);

        // assert
        verify(() => mockCartRemoteDataSource
            .deleteItemInCart(tDeleteItemInCartParams)).called(1);
        expect(result, Left(MenuItemNotExistsFailure()));
      });

      test(
          'Should return Left(Failure) when remoteDataSource.deleteItemInCart throws ServerFailure',
          () async {
        // arrange
        when(() => mockLocalDataSource.getUser())
            .thenAnswer((_) async => tUserModel);
        tGetAllCartItemParams.userId = tUserModel.id;
        when(() => mockCartRemoteDataSource.deleteItemInCart(
            tDeleteItemInCartParams)).thenThrow(ServerFailure());

        // act
        final result =
            await repository.deleteItemInCart(tDeleteItemInCartParams);

        // assert
        verify(() => mockCartRemoteDataSource
            .deleteItemInCart(tDeleteItemInCartParams)).called(1);
        expect(result, Left(ServerFailure()));
      });
    });

    group('increaseItemQuantity', () {
      test(
          'Should return Right(CartItem) when remoteDataSource.increaseItemQuantity succecced',
          () async {
        // arrange
        when(() => mockLocalDataSource.getUser())
            .thenAnswer((_) async => tUserModel);
        tGetAllCartItemParams.userId = tUserModel.id;
        when(() => mockCartRemoteDataSource
                .increaseItemQuantity(tIncreaseItemQuantityParams))
            .thenAnswer((_) async => tCartItemResponseModel);

        // act
        final result =
            await repository.increaseItemQuantity(tIncreaseItemQuantityParams);

        // assert
        verify(() => mockCartRemoteDataSource
            .increaseItemQuantity(tIncreaseItemQuantityParams)).called(1);

        expect(result, Right(tCartItemResponseModel.cartItem));
      });

      test(
          'Should return Left(Failure) when remoteDataSource.increaseItemQuantity throws CredentialFailure',
          () async {
        // arrange
        when(() => mockLocalDataSource.getUser())
            .thenAnswer((_) async => tUserModel);
        tGetAllCartItemParams.userId = tUserModel.id;
        when(() => mockCartRemoteDataSource.increaseItemQuantity(
            tIncreaseItemQuantityParams)).thenThrow(CredentialFailure());

        // act
        final result =
            await repository.increaseItemQuantity(tIncreaseItemQuantityParams);

        // assert
        verify(() => mockCartRemoteDataSource
            .increaseItemQuantity(tIncreaseItemQuantityParams)).called(1);
        expect(result, Left(CredentialFailure()));
      });

      test(
          'Should return Left(Failure) when remoteDataSource.increaseItemQuantity throws MenuItemNotExistsFailure',
          () async {
        // arrange
        when(() => mockLocalDataSource.getUser())
            .thenAnswer((_) async => tUserModel);
        tGetAllCartItemParams.userId = tUserModel.id;
        when(() => mockCartRemoteDataSource.increaseItemQuantity(
            tIncreaseItemQuantityParams)).thenThrow(MenuItemNotExistsFailure());

        // act
        final result =
            await repository.increaseItemQuantity(tIncreaseItemQuantityParams);

        // assert
        verify(() => mockCartRemoteDataSource
            .increaseItemQuantity(tIncreaseItemQuantityParams)).called(1);
        expect(result, Left(MenuItemNotExistsFailure()));
      });

      test(
          'Should return Left(Failure) when remoteDataSource.increaseItemQuantity throws MenuItemOutOfStockFailure',
          () async {
        // arrange
        when(() => mockLocalDataSource.getUser())
            .thenAnswer((_) async => tUserModel);
        tGetAllCartItemParams.userId = tUserModel.id;
        when(() => mockCartRemoteDataSource
                .increaseItemQuantity(tIncreaseItemQuantityParams))
            .thenThrow(MenuItemOutOfStockFailure());

        // act
        final result =
            await repository.increaseItemQuantity(tIncreaseItemQuantityParams);

        // assert
        verify(() => mockCartRemoteDataSource
            .increaseItemQuantity(tIncreaseItemQuantityParams)).called(1);
        expect(result, Left(MenuItemOutOfStockFailure()));
      });

      test(
          'Should return Left(Failure) when remoteDataSource.increaseItemQuantity throws ServerFailure',
          () async {
        // arrange
        when(() => mockLocalDataSource.getUser())
            .thenAnswer((_) async => tUserModel);
        tGetAllCartItemParams.userId = tUserModel.id;
        when(() => mockCartRemoteDataSource.increaseItemQuantity(
            tIncreaseItemQuantityParams)).thenThrow(ServerFailure());

        // act
        final result =
            await repository.increaseItemQuantity(tIncreaseItemQuantityParams);

        // assert
        verify(() => mockCartRemoteDataSource
            .increaseItemQuantity(tIncreaseItemQuantityParams)).called(1);
        expect(result, Left(ServerFailure()));
      });
    });

    group('decreaseItemQuantity', () {
      test(
          'Should return Right(CartItem) when remoteDataSource.decreaseItemQuantity succecced',
          () async {
        // arrange
        when(() => mockLocalDataSource.getUser())
            .thenAnswer((_) async => tUserModel);
        tGetAllCartItemParams.userId = tUserModel.id;
        when(() => mockCartRemoteDataSource
                .decreaseItemQuantity(tDecreaseItemQuantityParams))
            .thenAnswer((_) async => tCartItemResponseModel);

        // act
        final result =
            await repository.decreaseItemQuantity(tDecreaseItemQuantityParams);

        // assert
        verify(() => mockCartRemoteDataSource
            .decreaseItemQuantity(tDecreaseItemQuantityParams)).called(1);

        expect(result, Right(tCartItemResponseModel.cartItem));
      });

      test(
          'Should return Left(Failure) when remoteDataSource.decreaseItemQuantity throws CredentialFailure',
          () async {
        // arrange
        when(() => mockLocalDataSource.getUser())
            .thenAnswer((_) async => tUserModel);
        tGetAllCartItemParams.userId = tUserModel.id;
        when(() => mockCartRemoteDataSource.decreaseItemQuantity(
            tDecreaseItemQuantityParams)).thenThrow(CredentialFailure());

        // act
        final result =
            await repository.decreaseItemQuantity(tDecreaseItemQuantityParams);

        // assert
        verify(() => mockCartRemoteDataSource
            .decreaseItemQuantity(tDecreaseItemQuantityParams)).called(1);
        expect(result, Left(CredentialFailure()));
      });

      test(
          'Should return Left(Failure) when remoteDataSource.decreaseItemQuantity throws MenuItemNotExistsFailure',
          () async {
        // arrange
        when(() => mockLocalDataSource.getUser())
            .thenAnswer((_) async => tUserModel);
        tGetAllCartItemParams.userId = tUserModel.id;
        when(() => mockCartRemoteDataSource.decreaseItemQuantity(
            tDecreaseItemQuantityParams)).thenThrow(MenuItemNotExistsFailure());

        // act
        final result =
            await repository.decreaseItemQuantity(tDecreaseItemQuantityParams);

        // assert
        verify(() => mockCartRemoteDataSource
            .decreaseItemQuantity(tDecreaseItemQuantityParams)).called(1);
        expect(result, Left(MenuItemNotExistsFailure()));
      });

      test(
          'Should return Left(Failure) when remoteDataSource.decreaseItemQuantity throws MenuItemOutOfStockFailure',
          () async {
        // arrange
        when(() => mockLocalDataSource.getUser())
            .thenAnswer((_) async => tUserModel);
        tGetAllCartItemParams.userId = tUserModel.id;
        when(() => mockCartRemoteDataSource
                .decreaseItemQuantity(tDecreaseItemQuantityParams))
            .thenThrow(MenuItemOutOfStockFailure());

        // act
        final result =
            await repository.decreaseItemQuantity(tDecreaseItemQuantityParams);

        // assert
        verify(() => mockCartRemoteDataSource
            .decreaseItemQuantity(tDecreaseItemQuantityParams)).called(1);
        expect(result, Left(MenuItemOutOfStockFailure()));
      });

      test(
          'Should return Left(Failure) when remoteDataSource.decreaseItemQuantity throws ServerFailure',
          () async {
        // arrange
        when(() => mockLocalDataSource.getUser())
            .thenAnswer((_) async => tUserModel);
        tGetAllCartItemParams.userId = tUserModel.id;
        when(() => mockCartRemoteDataSource.decreaseItemQuantity(
            tDecreaseItemQuantityParams)).thenThrow(ServerFailure());

        // act
        final result =
            await repository.decreaseItemQuantity(tDecreaseItemQuantityParams);

        // assert
        verify(() => mockCartRemoteDataSource
            .decreaseItemQuantity(tDecreaseItemQuantityParams)).called(1);
        expect(result, Left(ServerFailure()));
      });
    });
  });
}
