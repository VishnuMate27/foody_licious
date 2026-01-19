import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foody_licious/core/constant/strings.dart';
import 'package:foody_licious/core/error/failures.dart';
import 'package:foody_licious/data/data_sources/remote/cart_remote_data_source.dart';
import 'package:foody_licious/data/models/cart/cart_item_response_model.dart';
import 'package:foody_licious/data/models/cart/cart_items_response_model.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;
import '../../../fixtures/constant_objects.dart';
import '../../../fixtures/fixture_reader.dart';
import '../../../helpers/test_loadenv.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late CartRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUpAll(() {
    // Register fallback values for mocktail
    registerFallbackValue(Uri.parse('https://example.com'));
  });

  setUp(() async {
    await loadTestDotEnv();
    mockHttpClient = MockHttpClient();
    dataSource = CartRemoteDataSourceImpl(client: mockHttpClient);
  });

  test('use BASE_URL from env', () {
    expect(kBaseUrlTest, contains('http'));
  });
  test('dataSource is initialized', () {
    expect(dataSource, isNotNull);
  });

  group('getAllCartItem', () {
    test('should perform a POST request to correct URL with params', () async {
      // Arrange
      final fakeResponse = fixture('cart/cart_items_response_model.json');

      when(() => mockHttpClient.get(
            Uri.parse(
                '$kBaseUrlTest/api/users/cart/allMenuItems?userId=${tGetAllCartItemParams.userId}&page=${tGetAllCartItemParams.page}&page_size=${tGetAllCartItemParams.limit}'),
            headers: {'Content-Type': 'application/json'},
          )).thenAnswer((_) async => http.Response(fakeResponse, 200));

      // Act
      final result = await dataSource.getAllCartItem(tGetAllCartItemParams);

      // Assert
      verify(() => mockHttpClient.get(
            Uri.parse(
                '$kBaseUrlTest/api/users/cart/allMenuItems?userId=${tGetAllCartItemParams.userId}&page=${tGetAllCartItemParams.page}&page_size=${tGetAllCartItemParams.limit}'),
            headers: {'Content-Type': 'application/json'},
          ));
      expect(result, isA<CartItemsResponseModel>());
    });

    test('should throw CredentialFailure on 400', () async {
      // Arrange
      when(() => mockHttpClient.get(
            any(),
            headers: any(named: 'headers'),
          )).thenAnswer((_) async => http.Response('Error', 400));

      final result = dataSource.getAllCartItem(tGetAllCartItemParams);

      // Act & Assert
      expect(
        result,
        throwsA(isA<CredentialFailure>()),
      );
    });

    test('should throw CartNotExistsFailure on 404', () async {
      // Arrange
      when(() => mockHttpClient.get(
            any(),
            headers: any(named: 'headers'),
          )).thenAnswer((_) async => http.Response('Error', 404));

      final result = dataSource.getAllCartItem(tGetAllCartItemParams);

      // Act & Assert
      expect(
        result,
        throwsA(isA<CartNotExistsFailure>()),
      );
    });

    test('should throw ServerFailure on non-200 other than 400/401/404',
        () async {
      // Arrange
      when(() => mockHttpClient.get(
            any(),
            headers: any(named: 'headers'),
          )).thenAnswer((_) async => http.Response('Error', 500));

      final result = dataSource.getAllCartItem(tGetAllCartItemParams);

      // Act & Assert
      expect(
        result,
        throwsA(isA<ServerFailure>()),
      );
    });
  });

  group('addItemToCart', () {
    final requestBody = json.encode({
      "menuItemId": tAddItemToCartParams.menuItemId,
      "restaurantId": tAddItemToCartParams.restaurantId,
      "userId": tAddItemToCartParams.userId
    });
    test('should perform a POST request to correct URL with params', () async {
      // Arrange
      final fakeResponse = fixture('cart/cart_response_model.json');
      when(() => mockHttpClient.post(
            Uri.parse("$kBaseUrl/api/users/cart/addNewItem"),
            headers: {'Content-Type': 'application/json'},
            body: requestBody,
          )).thenAnswer((_) async => http.Response(fakeResponse, 200));

      // Act
      final result = await dataSource.addItemToCart(tAddItemToCartParams);

      // Assert
      verify(() => mockHttpClient.post(
            Uri.parse("$kBaseUrl/api/users/cart/addNewItem"),
            headers: {'Content-Type': 'application/json'},
            body: requestBody,
          ));
      expect(result, isA<Unit>());
    });

    test('should throw CredentialFailure on 400', () async {
      // Arrange
      when(() => mockHttpClient.post(
            any(),
            headers: any(named: 'headers'),
            body: requestBody,
          )).thenAnswer((_) async => http.Response('Error', 400));

      final result = dataSource.addItemToCart(tAddItemToCartParams);

      // Act & Assert
      expect(
        result,
        throwsA(isA<CredentialFailure>()),
      );
    });

    test('should throw MenuItemNotExistsFailure on 404', () async {
      // Arrange
      when(() => mockHttpClient.post(
            any(),
            headers: any(named: 'headers'),
            body: requestBody,
          )).thenAnswer((_) async => http.Response('Error', 404));

      final result = dataSource.addItemToCart(tAddItemToCartParams);

      // Act & Assert
      expect(
        result,
        throwsA(isA<MenuItemNotExistsFailure>()),
      );
    });

    test('should throw MenuItemOutOfStockFailure on 409', () async {
      // Arrange
      when(() => mockHttpClient.post(
            any(),
            headers: any(named: 'headers'),
            body: requestBody,
          )).thenAnswer((_) async => http.Response('Error', 409));

      final result = dataSource.addItemToCart(tAddItemToCartParams);

      // Act & Assert
      expect(
        result,
        throwsA(isA<MenuItemOutOfStockFailure>()),
      );
    });

    test('should throw CartLockedFailure on 405', () async {
      // Arrange
      when(() => mockHttpClient.post(
            any(),
            headers: any(named: 'headers'),
            body: requestBody,
          )).thenAnswer((_) async => http.Response('Error', 405));

      final result = dataSource.addItemToCart(tAddItemToCartParams);

      // Act & Assert
      expect(
        result,
        throwsA(isA<CartLockedFailure>()),
      );
    });

    test('should throw MenuItemNotExistsFailure on 404', () async {
      // Arrange
      when(() => mockHttpClient.post(
            any(),
            headers: any(named: 'headers'),
            body: requestBody,
          )).thenAnswer((_) async => http.Response('Error', 404));

      final result = dataSource.addItemToCart(tAddItemToCartParams);

      // Act & Assert
      expect(
        result,
        throwsA(isA<MenuItemNotExistsFailure>()),
      );
    });

    test('should throw ServerFailure on non-200 other than 400/401/404',
        () async {
      // Arrange
      when(() => mockHttpClient.post(
            any(),
            headers: any(named: 'headers'),
            body: requestBody,
          )).thenAnswer((_) async => http.Response('Error', 500));

      final result = dataSource.addItemToCart(tAddItemToCartParams);

      // Act & Assert
      expect(
        result,
        throwsA(isA<ServerFailure>()),
      );
    });
  });

  group('deleteItemInCart', () {
    final requestBody = json.encode({
      "menuItemId": tDeleteItemInCartParams.menuItemId,
      "userId": tDeleteItemInCartParams.userId
    });

    test('should perform a DELETE request to correct URL with params',
        () async {
      // Arrange
      final fakeResponse = fixture('cart/cart_response_model.json');
      when(() => mockHttpClient.delete(
            Uri.parse("$kBaseUrlTest/api/users/cart/deleteItem"),
            headers: {'Content-Type': 'application/json'},
            body: requestBody,
          )).thenAnswer((_) async => http.Response(fakeResponse, 200));

      // Act
      final result = await dataSource.deleteItemInCart(tDeleteItemInCartParams);

      // Assert
      verify(() => mockHttpClient.delete(
            Uri.parse("$kBaseUrlTest/api/users/cart/deleteItem"),
            headers: {'Content-Type': 'application/json'},
            body: requestBody,
          ));
      expect(result, isA<Unit>());
    });

    test('should throw CredentialFailure on 400', () async {
      // Arrange
      when(() => mockHttpClient.delete(
            any(),
            headers: any(named: 'headers'),
            body: requestBody,
          )).thenAnswer((_) async => http.Response('Error', 400));

      final result = dataSource.deleteItemInCart(tDeleteItemInCartParams);

      // Act & Assert
      expect(
        result,
        throwsA(isA<CredentialFailure>()),
      );
    });

    test('should throw MenuItemNotExistsFailure on 404', () async {
      // Arrange
      when(() => mockHttpClient.delete(
            any(),
            headers: any(named: 'headers'),
            body: requestBody,
          )).thenAnswer((_) async => http.Response('Error', 404));

      final result = dataSource.deleteItemInCart(tDeleteItemInCartParams);

      // Act & Assert
      expect(
        result,
        throwsA(isA<MenuItemNotExistsFailure>()),
      );
    });

    test('should throw CartLockedFailure on 405', () async {
      // Arrange
      when(() => mockHttpClient.delete(
            any(),
            headers: any(named: 'headers'),
            body: requestBody,
          )).thenAnswer((_) async => http.Response('Error', 405));

      final result = dataSource.deleteItemInCart(tDeleteItemInCartParams);

      // Act & Assert
      expect(
        result,
        throwsA(isA<CartLockedFailure>()),
      );
    });

    test('should throw ServerFailure on non-200 other than 400/401/404',
        () async {
      // Arrange
      when(() => mockHttpClient.delete(
            any(),
            headers: any(named: 'headers'),
            body: requestBody,
          )).thenAnswer((_) async => http.Response('Error', 500));

      final result = dataSource.deleteItemInCart(tDeleteItemInCartParams);

      // Act & Assert
      expect(
        result,
        throwsA(isA<ServerFailure>()),
      );
    });
  });

  group('increaseItemQuantity', () {
    final requestBody = json.encode({
      "menuItemId": tDeleteItemInCartParams.menuItemId,
      "userId": tDeleteItemInCartParams.userId
    });

    test('should perform a PUT request to correct URL with params', () async {
      // Arrange
      final fakeResponse = fixture('cart/cart_item_response_model.json');
      when(() => mockHttpClient.put(
            Uri.parse("$kBaseUrl/api/users/cart/increaseItemQuantity"),
            headers: {'Content-Type': 'application/json'},
            body: requestBody,
          )).thenAnswer((_) async => http.Response(fakeResponse, 200));

      // Act
      final result =
          await dataSource.increaseItemQuantity(tIncreaseItemQuantityParams);

      // Assert
      verify(() => mockHttpClient.put(
            Uri.parse("$kBaseUrl/api/users/cart/increaseItemQuantity"),
            headers: {'Content-Type': 'application/json'},
            body: requestBody,
          ));
      expect(result, isA<CartItemResponseModel>());
    });

    test('should throw CredentialFailure on 400', () async {
      // Arrange
      when(() => mockHttpClient.put(
            any(),
            headers: any(named: 'headers'),
            body: requestBody,
          )).thenAnswer((_) async => http.Response('Error', 400));

      final result =
          dataSource.increaseItemQuantity(tIncreaseItemQuantityParams);

      // Act & Assert
      expect(
        result,
        throwsA(isA<CredentialFailure>()),
      );
    });

    test('should throw MenuItemNotExistsFailure on 404', () async {
      // Arrange
      when(() => mockHttpClient.put(
            any(),
            headers: any(named: 'headers'),
            body: requestBody,
          )).thenAnswer((_) async => http.Response('Error', 404));

      final result =
          dataSource.increaseItemQuantity(tIncreaseItemQuantityParams);

      // Act & Assert
      expect(
        result,
        throwsA(isA<MenuItemNotExistsFailure>()),
      );
    });

    test('should throw CartLockedFailure on 405', () async {
      // Arrange
      when(() => mockHttpClient.put(
            any(),
            headers: any(named: 'headers'),
            body: requestBody,
          )).thenAnswer((_) async => http.Response('Error', 405));

      final result =
          dataSource.increaseItemQuantity(tIncreaseItemQuantityParams);

      // Act & Assert
      expect(
        result,
        throwsA(isA<CartLockedFailure>()),
      );
    });

    test('should throw MenuItemOutOfStockFailure on 409', () async {
      // Arrange
      when(() => mockHttpClient.put(
            any(),
            headers: any(named: 'headers'),
            body: requestBody,
          )).thenAnswer((_) async => http.Response('Error', 409));

      final result =
          dataSource.increaseItemQuantity(tIncreaseItemQuantityParams);

      // Act & Assert
      expect(
        result,
        throwsA(isA<MenuItemOutOfStockFailure>()),
      );
    });

    test('should throw ServerFailure on non-200 other than 400/401/404',
        () async {
      // Arrange
      when(() => mockHttpClient.put(
            any(),
            headers: any(named: 'headers'),
            body: requestBody,
          )).thenAnswer((_) async => http.Response('Error', 500));

      final result =
          dataSource.increaseItemQuantity(tIncreaseItemQuantityParams);

      // Act & Assert
      expect(
        result,
        throwsA(isA<ServerFailure>()),
      );
    });
  });

  group('decreaseItemQuantity', () {
    final requestBody = json.encode({
      "menuItemId": tDeleteItemInCartParams.menuItemId,
      "userId": tDeleteItemInCartParams.userId
    });

    test('should perform a PUT request to correct URL with params', () async {
      // Arrange
      final fakeResponse = fixture('cart/cart_item_response_model.json');
      when(() => mockHttpClient.put(
            Uri.parse("$kBaseUrl/api/users/cart/decreaseItemQuantity"),
            headers: {'Content-Type': 'application/json'},
            body: requestBody,
          )).thenAnswer((_) async => http.Response(fakeResponse, 200));

      // Act
      final result =
          await dataSource.decreaseItemQuantity(tDecreaseItemQuantityParams);

      // Assert
      verify(() => mockHttpClient.put(
            Uri.parse("$kBaseUrl/api/users/cart/decreaseItemQuantity"),
            headers: {'Content-Type': 'application/json'},
            body: requestBody,
          ));
      expect(result, isA<CartItemResponseModel>());
    });

    test('should throw CredentialFailure on 400', () async {
      // Arrange
      when(() => mockHttpClient.put(
            any(),
            headers: any(named: 'headers'),
            body: requestBody,
          )).thenAnswer((_) async => http.Response('Error', 400));

      final result =
          dataSource.decreaseItemQuantity(tDecreaseItemQuantityParams);

      // Act & Assert
      expect(
        result,
        throwsA(isA<CredentialFailure>()),
      );
    });

    test('should throw MenuItemNotExistsFailure on 404', () async {
      // Arrange
      when(() => mockHttpClient.put(
            any(),
            headers: any(named: 'headers'),
            body: requestBody,
          )).thenAnswer((_) async => http.Response('Error', 404));

      final result =
          dataSource.decreaseItemQuantity(tDecreaseItemQuantityParams);

      // Act & Assert
      expect(
        result,
        throwsA(isA<MenuItemNotExistsFailure>()),
      );
    });

    test('should throw CartLockedFailure on 405', () async {
      // Arrange
      when(() => mockHttpClient.put(
            any(),
            headers: any(named: 'headers'),
            body: requestBody,
          )).thenAnswer((_) async => http.Response('Error', 405));

      final result =
          dataSource.decreaseItemQuantity(tDecreaseItemQuantityParams);

      // Act & Assert
      expect(
        result,
        throwsA(isA<CartLockedFailure>()),
      );
    });

    test('should throw MenuItemOutOfStockFailure on 409', () async {
      // Arrange
      when(() => mockHttpClient.put(
            any(),
            headers: any(named: 'headers'),
            body: requestBody,
          )).thenAnswer((_) async => http.Response('Error', 409));

      final result =
          dataSource.decreaseItemQuantity(tDecreaseItemQuantityParams);

      // Act & Assert
      expect(
        result,
        throwsA(isA<MenuItemOutOfStockFailure>()),
      );
    });

    test('should throw ServerFailure on non-200 other than 400/401/404',
        () async {
      // Arrange
      when(() => mockHttpClient.put(
            any(),
            headers: any(named: 'headers'),
            body: requestBody,
          )).thenAnswer((_) async => http.Response('Error', 500));

      final result =
          dataSource.decreaseItemQuantity(tDecreaseItemQuantityParams);

      // Act & Assert
      expect(
        result,
        throwsA(isA<ServerFailure>()),
      );
    });
  });
}
