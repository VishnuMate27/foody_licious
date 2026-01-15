import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foody_licious/core/error/failures.dart';
import 'package:foody_licious/core/usecase/usecase.dart';
import 'package:foody_licious/domain/usecase/cart/add_item_to_cart_usecase.dart';
import 'package:foody_licious/domain/usecase/cart/decrease_item_quantity_usecase.dart';
import 'package:foody_licious/domain/usecase/cart/delete_item_in_cart_usecase.dart';
import 'package:foody_licious/domain/usecase/cart/get_all_cart_item_usecase.dart';
import 'package:foody_licious/domain/usecase/cart/increase_item_quantity_usecase.dart';
import 'package:foody_licious/presentation/bloc/cart/cart_bloc.dart';
import 'package:mocktail/mocktail.dart';

import '../../../fixtures/constant_objects.dart';

class MockAddItemToCartUseCase extends Mock implements AddItemToCartUseCase {}

class MockDeleteItemInCartUseCase extends Mock
    implements DeleteItemInCartUseCase {}

class MockGetAllCartItemUseCase extends Mock implements GetAllCartItemUseCase {}

class MockIncreaseItemQuantityUseCase extends Mock
    implements IncreaseItemQuantityUseCase {}

class MockDecreaseItemQuantityUseCase extends Mock
    implements DecreaseItemQuantityUseCase {}

void main() {
  group('CartBloc', () {
    late CartBloc cartBloc;
    late MockGetAllCartItemUseCase mockGetAllCartItemUseCase;
    late MockAddItemToCartUseCase mockAddItemToCartUseCase;
    late MockDeleteItemInCartUseCase mockDeleteItemInCartUseCase;
    late MockIncreaseItemQuantityUseCase mockIncreaseItemQuantityUseCase;
    late MockDecreaseItemQuantityUseCase mockDecreaseItemQuantityUseCase;
    setUp(() {
      mockGetAllCartItemUseCase = MockGetAllCartItemUseCase();
      mockAddItemToCartUseCase = MockAddItemToCartUseCase();
      mockDeleteItemInCartUseCase = MockDeleteItemInCartUseCase();
      mockIncreaseItemQuantityUseCase = MockIncreaseItemQuantityUseCase();
      mockDecreaseItemQuantityUseCase = MockDecreaseItemQuantityUseCase();
      registerFallbackValue(NoParams());

      cartBloc = CartBloc(
          mockGetAllCartItemUseCase,
          mockAddItemToCartUseCase,
          mockDeleteItemInCartUseCase,
          mockIncreaseItemQuantityUseCase,
          mockDecreaseItemQuantityUseCase);
    });

    test('initial state should be CartInitial', () {
      expect(cartBloc.state, CartInitial());
    });

    // _onGetAllCartItem
    blocTest<CartBloc, CartState>(
      'emits [GetAllCartItemLoading, GetAllCartItemSuccess] when GetAllCartItem is added',
      build: () {
        when(() => mockGetAllCartItemUseCase(tGetAllCartItemParams))
            .thenAnswer((_) async => Right(tCartItemsResponseModel.cartItems));
        return cartBloc;
      },
      act: (bloc) => bloc.add(GetAllCartItem(tGetAllCartItemParams)),
      expect: () => [
        GetAllCartItemLoading(),
        GetAllCartItemSuccess(tCartItemsResponseModel.cartItems)
      ],
    );

    blocTest<CartBloc, CartState>(
      'emits [GetAllCartItemLoading, GetAllCartItemFailed] on GetAllCartItem error',
      build: () {
        when(() => mockGetAllCartItemUseCase(tGetAllCartItemParams))
            .thenAnswer((_) async => Left(CredentialFailure()));
        return cartBloc;
      },
      act: (bloc) => bloc.add(GetAllCartItem(tGetAllCartItemParams)),
      expect: () =>
          [GetAllCartItemLoading(), GetAllCartItemFailed(CredentialFailure())],
    );

    blocTest<CartBloc, CartState>(
      'emits [GetAllCartItemLoading, GetAllCartItemFailed] on GetAllCartItem error',
      build: () {
        when(() => mockGetAllCartItemUseCase(tGetAllCartItemParams))
            .thenAnswer((_) async => Left(CartNotExistsFailure()));
        return cartBloc;
      },
      act: (bloc) => bloc.add(GetAllCartItem(tGetAllCartItemParams)),
      expect: () => [
        GetAllCartItemLoading(),
        GetAllCartItemFailed(CartNotExistsFailure())
      ],
    );

    blocTest<CartBloc, CartState>(
      'emits [GetAllCartItemLoading, GetAllCartItemFailed] on GetAllCartItem error',
      build: () {
        when(() => mockGetAllCartItemUseCase(tGetAllCartItemParams))
            .thenAnswer((_) async => Left(ServerFailure()));
        return cartBloc;
      },
      act: (bloc) => bloc.add(GetAllCartItem(tGetAllCartItemParams)),
      expect: () =>
          [GetAllCartItemLoading(), GetAllCartItemFailed(ServerFailure())],
    );

    // _onAddItemToCart
    blocTest<CartBloc, CartState>(
      'emits [AddItemToCartLoading, AddItemToCartSuccess] when AddItemToCart is added',
      build: () {
        when(() => mockAddItemToCartUseCase(tAddItemToCartParams))
            .thenAnswer((_) async => Right(unit));
        return cartBloc;
      },
      act: (bloc) => bloc.add(AddItemToCart(tAddItemToCartParams)),
      expect: () => [AddItemToCartLoading(), AddItemToCartSuccess(unit)],
    );

    blocTest<CartBloc, CartState>(
      'emits [AddItemToCartLoading, AddItemToCartFailed] on AddItemToCart error',
      build: () {
        when(() => mockAddItemToCartUseCase(tAddItemToCartParams))
            .thenAnswer((_) async => Left(CredentialFailure()));
        return cartBloc;
      },
      act: (bloc) => bloc.add(AddItemToCart(tAddItemToCartParams)),
      expect: () =>
          [AddItemToCartLoading(), AddItemToCartFailed(CredentialFailure())],
    );

    blocTest<CartBloc, CartState>(
      'emits [AddItemToCartLoading, AddItemToCartFailed] on AddItemToCart error',
      build: () {
        when(() => mockAddItemToCartUseCase(tAddItemToCartParams))
            .thenAnswer((_) async => Left(MenuItemNotExistsFailure()));
        return cartBloc;
      },
      act: (bloc) => bloc.add(AddItemToCart(tAddItemToCartParams)),
      expect: () => [
        AddItemToCartLoading(),
        AddItemToCartFailed(MenuItemNotExistsFailure())
      ],
    );

    blocTest<CartBloc, CartState>(
      'emits [AddItemToCartLoading, AddItemToCartFailed] on AddItemToCart error',
      build: () {
        when(() => mockAddItemToCartUseCase(tAddItemToCartParams))
            .thenAnswer((_) async => Left(MenuItemOutOfStockFailure()));
        return cartBloc;
      },
      act: (bloc) => bloc.add(AddItemToCart(tAddItemToCartParams)),
      expect: () => [
        AddItemToCartLoading(),
        AddItemToCartFailed(MenuItemOutOfStockFailure())
      ],
    );

    blocTest<CartBloc, CartState>(
      'emits [AddItemToCartLoading, AddItemToCartFailed] on AddItemToCart error',
      build: () {
        when(() => mockAddItemToCartUseCase(tAddItemToCartParams))
            .thenAnswer((_) async => Left(ServerFailure()));
        return cartBloc;
      },
      act: (bloc) => bloc.add(AddItemToCart(tAddItemToCartParams)),
      expect: () =>
          [AddItemToCartLoading(), AddItemToCartFailed(ServerFailure())],
    );

    // _onDeleteItemInCart
    blocTest<CartBloc, CartState>(
      'emits [DeleteItemInCartSuccess, GetAllCartItemSuccess] on DeleteItemInCart error',
      build: () {
        when(() => mockDeleteItemInCartUseCase(tDeleteItemInCartParams))
            .thenAnswer((_) async => Right(unit));
        return cartBloc;
      },
      seed: () => GetAllCartItemSuccess(tCartItemsResponseModel.cartItems),
      act: (bloc) => bloc.add(DeleteItemInCart(tDeleteItemInCartParams)),
      expect: () => [
        DeleteItemInCartSuccess(unit),
        GetAllCartItemSuccess(tCartItemsResponseModel.cartItems)
      ],
    );

    blocTest<CartBloc, CartState>(
      'emits [DeleteItemInCartFailed, GetAllCartItemSuccess] on DeleteItemInCart error',
      build: () {
        when(() => mockDeleteItemInCartUseCase(tDeleteItemInCartParams))
            .thenAnswer((_) async => Left(CredentialFailure()));
        return cartBloc;
      },
      seed: () => GetAllCartItemSuccess(tCartItemsResponseModel.cartItems),
      act: (bloc) => bloc.add(DeleteItemInCart(tDeleteItemInCartParams)),
      expect: () => [
        DeleteItemInCartFailed(CredentialFailure()),
        GetAllCartItemSuccess(tCartItemsResponseModel.cartItems)
      ],
    );

    blocTest<CartBloc, CartState>(
      'emits [DeleteItemInCartFailed, GetAllCartItemSuccess] on DeleteItemInCart error',
      build: () {
        when(() => mockDeleteItemInCartUseCase(tDeleteItemInCartParams))
            .thenAnswer((_) async => Left(MenuItemNotExistsFailure()));
        return cartBloc;
      },
      seed: () => GetAllCartItemSuccess(tCartItemsResponseModel.cartItems),
      act: (bloc) => bloc.add(DeleteItemInCart(tDeleteItemInCartParams)),
      expect: () => [
        DeleteItemInCartFailed(MenuItemNotExistsFailure()),
        GetAllCartItemSuccess(tCartItemsResponseModel.cartItems)
      ],
    );

    blocTest<CartBloc, CartState>(
      'emits [DeleteItemInCartFailed, GetAllCartItemSuccess] on DeleteItemInCart error',
      build: () {
        when(() => mockDeleteItemInCartUseCase(tDeleteItemInCartParams))
            .thenAnswer((_) async => Left(ServerFailure()));
        return cartBloc;
      },
      seed: () => GetAllCartItemSuccess(tCartItemsResponseModel.cartItems),
      act: (bloc) => bloc.add(DeleteItemInCart(tDeleteItemInCartParams)),
      expect: () => [
        DeleteItemInCartFailed(ServerFailure()),
        GetAllCartItemSuccess(tCartItemsResponseModel.cartItems)
      ],
    );

    blocTest<CartBloc, CartState>(
      'emits [DeleteItemInCartFailed, GetAllCartItemSuccess] on DeleteItemInCart error',
      build: () {
        when(() => mockDeleteItemInCartUseCase(tDeleteItemInCartParams))
            .thenAnswer((_) async => Left(ExceptionFailure('Error')));
        return cartBloc;
      },
      seed: () => GetAllCartItemSuccess(tCartItemsResponseModel.cartItems),
      act: (bloc) => bloc.add(DeleteItemInCart(tDeleteItemInCartParams)),
      expect: () => [
        DeleteItemInCartFailed(ExceptionFailure('Error')),
        GetAllCartItemSuccess(tCartItemsResponseModel.cartItems)
      ],
    );

    // _onIncreaseItemQuantity
    blocTest<CartBloc, CartState>(
      'emits [GetAllCartItemSuccess] when IncreaseItemQuantity is added',
      build: () {
        when(() => mockIncreaseItemQuantityUseCase(tIncreaseItemQuantityParams))
            .thenAnswer((_) async => Right(tIncreasedQuantityCartItem));
        return cartBloc;
      },
      seed: () => GetAllCartItemSuccess(tCartItemsResponseModel.cartItems),
      act: (bloc) =>
          bloc.add(IncreaseItemQuantity(tIncreaseItemQuantityParams)),
      expect: () => [
        GetAllCartItemSuccess([tIncreasedQuantityCartItem])
      ],
    );

    blocTest<CartBloc, CartState>(
      'emits [IncreaseItemQuantityFailed, GetAllCartItemSuccess] on IncreaseItemQuantity is error',
      build: () {
        when(() => mockIncreaseItemQuantityUseCase(tIncreaseItemQuantityParams))
            .thenAnswer((_) async => Left(CredentialFailure()));
        return cartBloc;
      },
      seed: () => GetAllCartItemSuccess(tCartItemsResponseModel.cartItems),
      act: (bloc) =>
          bloc.add(IncreaseItemQuantity(tIncreaseItemQuantityParams)),
      expect: () => [
        IncreaseItemQuantityFailed(CredentialFailure()),
        GetAllCartItemSuccess([tCartItemModel])
      ],
    );

    blocTest<CartBloc, CartState>(
      'emits [IncreaseItemQuantityFailed, GetAllCartItemSuccess] on IncreaseItemQuantity is error',
      build: () {
        when(() => mockIncreaseItemQuantityUseCase(tIncreaseItemQuantityParams))
            .thenAnswer((_) async => Left(MenuItemNotExistsFailure()));
        return cartBloc;
      },
      seed: () => GetAllCartItemSuccess(tCartItemsResponseModel.cartItems),
      act: (bloc) =>
          bloc.add(IncreaseItemQuantity(tIncreaseItemQuantityParams)),
      expect: () => [
        IncreaseItemQuantityFailed(MenuItemNotExistsFailure()),
        GetAllCartItemSuccess([tCartItemModel])
      ],
    );

    blocTest<CartBloc, CartState>(
      'emits [IncreaseItemQuantityFailed, GetAllCartItemSuccess] on IncreaseItemQuantity is error',
      build: () {
        when(() => mockIncreaseItemQuantityUseCase(tIncreaseItemQuantityParams))
            .thenAnswer((_) async => Left(MenuItemOutOfStockFailure()));
        return cartBloc;
      },
      seed: () => GetAllCartItemSuccess(tCartItemsResponseModel.cartItems),
      act: (bloc) =>
          bloc.add(IncreaseItemQuantity(tIncreaseItemQuantityParams)),
      expect: () => [
        IncreaseItemQuantityFailed(MenuItemOutOfStockFailure()),
        GetAllCartItemSuccess([tCartItemModel])
      ],
    );

    blocTest<CartBloc, CartState>(
      'emits [IncreaseItemQuantityFailed, GetAllCartItemSuccess] on IncreaseItemQuantity is error',
      build: () {
        when(() => mockIncreaseItemQuantityUseCase(tIncreaseItemQuantityParams))
            .thenAnswer((_) async => Left(ServerFailure()));
        return cartBloc;
      },
      seed: () => GetAllCartItemSuccess(tCartItemsResponseModel.cartItems),
      act: (bloc) =>
          bloc.add(IncreaseItemQuantity(tIncreaseItemQuantityParams)),
      expect: () => [
        IncreaseItemQuantityFailed(ServerFailure()),
        GetAllCartItemSuccess([tCartItemModel])
      ],
    );

    // _onDecreaseItemQuantity
    blocTest<CartBloc, CartState>(
      'emits [GetAllCartItemSuccess] when DecreaseItemQuantity is added',
      build: () {
        when(() => mockDecreaseItemQuantityUseCase(tDecreaseItemQuantityParams))
            .thenAnswer((_) async => Right(tDecreasedQuantityCartItem));
        return cartBloc;
      },
      seed: () => GetAllCartItemSuccess(tCartItemsResponseModel.cartItems),
      act: (bloc) =>
          bloc.add(DecreaseItemQuantity(tDecreaseItemQuantityParams)),
      expect: () => [
        GetAllCartItemSuccess([tDecreasedQuantityCartItem])
      ],
    );

    blocTest<CartBloc, CartState>(
      'emits [DecreaseItemQuantityFailed, GetAllCartItemSuccess] on DecreaseItemQuantity is error',
      build: () {
        when(() => mockDecreaseItemQuantityUseCase(tDecreaseItemQuantityParams))
            .thenAnswer((_) async => Left(CredentialFailure()));
        return cartBloc;
      },
      seed: () => GetAllCartItemSuccess(tCartItemsResponseModel.cartItems),
      act: (bloc) =>
          bloc.add(DecreaseItemQuantity(tDecreaseItemQuantityParams)),
      expect: () => [
        DecreaseItemQuantityFailed(CredentialFailure()),
        GetAllCartItemSuccess([tCartItemModel])
      ],
    );

    blocTest<CartBloc, CartState>(
      'emits [DecreaseItemQuantityFailed, GetAllCartItemSuccess] on DecreaseItemQuantity is error',
      build: () {
        when(() => mockDecreaseItemQuantityUseCase(tDecreaseItemQuantityParams))
            .thenAnswer((_) async => Left(MenuItemNotExistsFailure()));
        return cartBloc;
      },
      seed: () => GetAllCartItemSuccess(tCartItemsResponseModel.cartItems),
      act: (bloc) =>
          bloc.add(DecreaseItemQuantity(tDecreaseItemQuantityParams)),
      expect: () => [
        DecreaseItemQuantityFailed(MenuItemNotExistsFailure()),
        GetAllCartItemSuccess([tCartItemModel])
      ],
    );


    blocTest<CartBloc, CartState>(
      'emits [DecreaseItemQuantityFailed, GetAllCartItemSuccess] on DecreaseItemQuantity is error',
      build: () {
        when(() => mockDecreaseItemQuantityUseCase(tDecreaseItemQuantityParams))
            .thenAnswer((_) async => Left(MenuItemOutOfStockFailure()));
        return cartBloc;
      },
      seed: () => GetAllCartItemSuccess(tCartItemsResponseModel.cartItems),
      act: (bloc) =>
          bloc.add(DecreaseItemQuantity(tDecreaseItemQuantityParams)),
      expect: () => [
        DecreaseItemQuantityFailed(MenuItemOutOfStockFailure()),
        GetAllCartItemSuccess([tCartItemModel])
      ],
    );

    blocTest<CartBloc, CartState>(
      'emits [DecreaseItemQuantityFailed, GetAllCartItemSuccess] on DecreaseItemQuantity is error',
      build: () {
        when(() => mockDecreaseItemQuantityUseCase(tDecreaseItemQuantityParams))
            .thenAnswer((_) async => Left(ServerFailure()));
        return cartBloc;
      },
      seed: () => GetAllCartItemSuccess(tCartItemsResponseModel.cartItems),
      act: (bloc) =>
          bloc.add(DecreaseItemQuantity(tDecreaseItemQuantityParams)),
      expect: () => [
        DecreaseItemQuantityFailed(ServerFailure()),
        GetAllCartItemSuccess([tCartItemModel])
      ],
    );

  });
}
