import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foody_licious/core/error/failures.dart';
import 'package:foody_licious/data/data_sources/remote/checkout_remote_data_source.dart';
import 'package:foody_licious/data/models/checkout/place_order_model.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

import '../../../fixtures/constant_objects.dart';
import '../../../fixtures/fixture_reader.dart';
import '../../../helpers/test_loadenv.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late CheckoutRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUpAll(() {
    registerFallbackValue(Uri.parse('https://example.com'));
  });

  setUp(() async {
    await loadTestDotEnv();
    mockHttpClient = MockHttpClient();
    dataSource = CheckoutRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('placeOrder', () {
    final expectedUrl = '$kBaseUrlTest/api/users/checkout/place-order';
    final fakeResponse = fixture('checkout/place_order_response_model.json');

    test('should perform a POST request to correct URL with params', () async {
      final requestBody = json.encode({
        "userId": tPlaceOrderParams.userId,
        "name": tPlaceOrderParams.name,
        "address": tPlaceOrderParams.address,
        "phone": tPlaceOrderParams.phone
      });
      when(() => mockHttpClient.post(
            any(),
            headers: any(named: 'headers'),
            body: requestBody,
          )).thenAnswer((_) async => http.Response(fakeResponse, 201));

      final result = await dataSource.placeOrder(tPlaceOrderParams);

      verify(() => mockHttpClient.post(
            any(),
            headers: any(named: 'headers'),
            body: requestBody,
          )).called(1);
      expect(result, isA<PlaceOrderModel>());
    });

    test('should throw CredentialFailure on 400', () async {
      final requestBody = json.encode({
        "userId": tPlaceOrderParams.userId,
        "name": tPlaceOrderParams.name,
        "address": tPlaceOrderParams.address,
        "phone": tPlaceOrderParams.phone
      });
      when(() => mockHttpClient.post(
            any(),
            headers: any(named: 'headers'),
            body: requestBody,
          )).thenAnswer((_) async => http.Response('Error', 400));

      final result = dataSource.placeOrder(tPlaceOrderParams);

      verify(() => mockHttpClient.post(
            any(),
            headers: any(named: 'headers'),
            body: requestBody,
          )).called(1);
      expect(
        result,
        throwsA(isA<CredentialFailure>()),
      );
    });

    // BusinessExceptionFailure Cases
    test('should throw CartLockedFailure on 409 and error code=CART_LOCKED',
        () async {
      final requestBody = json.encode({
        "userId": tPlaceOrderParams.userId,
        "name": tPlaceOrderParams.name,
        "address": tPlaceOrderParams.address,
        "phone": tPlaceOrderParams.phone
      });

      var tCartLockedRequestJson = json
          .encode({"error_code": "CART_LOCKED", "message": "Cart is locked"});
      when(() => mockHttpClient.post(
                any(),
                headers: any(named: 'headers'),
                body: requestBody,
              ))
          .thenAnswer((_) async => http.Response(tCartLockedRequestJson, 409));

      final result = dataSource.placeOrder(tPlaceOrderParams);

      verify(() => mockHttpClient.post(
            any(),
            headers: any(named: 'headers'),
            body: requestBody,
          )).called(1);
      expect(
        result,
        throwsA(isA<CartLockedFailure>()),
      );
    });

    test('should throw CartEmptyFailure on 409 and error code=CART_EMPTY',
        () async {
      final requestBody = json.encode({
        "userId": tPlaceOrderParams.userId,
        "name": tPlaceOrderParams.name,
        "address": tPlaceOrderParams.address,
        "phone": tPlaceOrderParams.phone
      });

      var tCartLockedRequestJson =
          json.encode({"error_code": "CART_EMPTY", "message": "Cart is empty"});
      when(() => mockHttpClient.post(
                any(),
                headers: any(named: 'headers'),
                body: requestBody,
              ))
          .thenAnswer((_) async => http.Response(tCartLockedRequestJson, 409));

      final result = dataSource.placeOrder(tPlaceOrderParams);

      verify(() => mockHttpClient.post(
            any(),
            headers: any(named: 'headers'),
            body: requestBody,
          )).called(1);
      expect(
        result,
        throwsA(isA<CartEmptyFailure>()),
      );
    });

    test(
        'should throw OldOrderPendingFailure on 409 and error code=OLD_ORDER_PENDING',
        () async {
      final requestBody = json.encode({
        "userId": tPlaceOrderParams.userId,
        "name": tPlaceOrderParams.name,
        "address": tPlaceOrderParams.address,
        "phone": tPlaceOrderParams.phone
      });

      var tCartLockedRequestJson = json.encode({
        "error_code": "OLD_ORDER_PENDING",
        "message": "Old order is still pending"
      });
      when(() => mockHttpClient.post(
                any(),
                headers: any(named: 'headers'),
                body: requestBody,
              ))
          .thenAnswer((_) async => http.Response(tCartLockedRequestJson, 409));

      final result = dataSource.placeOrder(tPlaceOrderParams);

      verify(() => mockHttpClient.post(
            any(),
            headers: any(named: 'headers'),
            body: requestBody,
          )).called(1);
      expect(
        result,
        throwsA(isA<OldOrderPendingFailure>()),
      );
    });

    test(
        'should throw CartNotExistsFailure on 409 and error code=CART_NOT_FOUND',
        () async {
      final requestBody = json.encode({
        "userId": tPlaceOrderParams.userId,
        "name": tPlaceOrderParams.name,
        "address": tPlaceOrderParams.address,
        "phone": tPlaceOrderParams.phone
      });

      var tCartLockedRequestJson = json.encode(
          {"error_code": "CART_NOT_FOUND", "message": "Cart not found"});
      when(() => mockHttpClient.post(
                any(),
                headers: any(named: 'headers'),
                body: requestBody,
              ))
          .thenAnswer((_) async => http.Response(tCartLockedRequestJson, 409));

      final result = dataSource.placeOrder(tPlaceOrderParams);

      verify(() => mockHttpClient.post(
            any(),
            headers: any(named: 'headers'),
            body: requestBody,
          )).called(1);
      expect(
        result,
        throwsA(isA<CartNotExistsFailure>()),
      );
    });

    test(
        'should throw CartLockFailedFailure on 409 and error code=CART_LOCK_FAILED',
        () async {
      final requestBody = json.encode({
        "userId": tPlaceOrderParams.userId,
        "name": tPlaceOrderParams.name,
        "address": tPlaceOrderParams.address,
        "phone": tPlaceOrderParams.phone
      });

      var tCartLockedRequestJson = json.encode(
          {"error_code": "CART_LOCK_FAILED", "message": "Failed to lock cart"});
      when(() => mockHttpClient.post(
                any(),
                headers: any(named: 'headers'),
                body: requestBody,
              ))
          .thenAnswer((_) async => http.Response(tCartLockedRequestJson, 409));

      final result = dataSource.placeOrder(tPlaceOrderParams);

      verify(() => mockHttpClient.post(
            any(),
            headers: any(named: 'headers'),
            body: requestBody,
          )).called(1);
      expect(
        result,
        throwsA(isA<CartLockFailedFailure>()),
      );
    });

    test(
        'should throw OrderNotFoundFailure on 409 and error code=ORDER_NOT_FOUND',
        () async {
      final requestBody = json.encode({
        "userId": tPlaceOrderParams.userId,
        "name": tPlaceOrderParams.name,
        "address": tPlaceOrderParams.address,
        "phone": tPlaceOrderParams.phone
      });

      var tCartLockedRequestJson = json.encode(
          {"error_code": "ORDER_NOT_FOUND", "message": "Order not found"});
      when(() => mockHttpClient.post(
                any(),
                headers: any(named: 'headers'),
                body: requestBody,
              ))
          .thenAnswer((_) async => http.Response(tCartLockedRequestJson, 409));

      final result = dataSource.placeOrder(tPlaceOrderParams);

      verify(() => mockHttpClient.post(
            any(),
            headers: any(named: 'headers'),
            body: requestBody,
          )).called(1);
      expect(
        result,
        throwsA(isA<OrderNotFoundFailure>()),
      );
    });

    test(
        'should throw OrderStatusNotPendingPaymentFailure on 409 and error code=ORDER_STATUS_NOT_PENDING_PAYMENT',
        () async {
      final requestBody = json.encode({
        "userId": tPlaceOrderParams.userId,
        "name": tPlaceOrderParams.name,
        "address": tPlaceOrderParams.address,
        "phone": tPlaceOrderParams.phone
      });

      var tCartLockedRequestJson = json.encode({
        "error_code": "ORDER_STATUS_NOT_PENDING_PAYMENT",
        "message": "Order status is not PENDING_PAYMENT"
      });
      when(() => mockHttpClient.post(
                any(),
                headers: any(named: 'headers'),
                body: requestBody,
              ))
          .thenAnswer((_) async => http.Response(tCartLockedRequestJson, 409));

      final result = dataSource.placeOrder(tPlaceOrderParams);

      verify(() => mockHttpClient.post(
            any(),
            headers: any(named: 'headers'),
            body: requestBody,
          )).called(1);
      expect(
        result,
        throwsA(isA<OrderStatusNotPendingPaymentFailure>()),
      );
    });

    test(
        'should throw PaymentStatusAlreadySuccessFailure on 409 and error code=PAYMENT_STATUS_ALREADY_SUCCESS',
        () async {
      final requestBody = json.encode({
        "userId": tPlaceOrderParams.userId,
        "name": tPlaceOrderParams.name,
        "address": tPlaceOrderParams.address,
        "phone": tPlaceOrderParams.phone
      });

      var tCartLockedRequestJson = json.encode({
        "error_code": "PAYMENT_STATUS_ALREADY_SUCCESS",
        "message": "Payment status is already success!"
      });
      when(() => mockHttpClient.post(
                any(),
                headers: any(named: 'headers'),
                body: requestBody,
              ))
          .thenAnswer((_) async => http.Response(tCartLockedRequestJson, 409));

      final result = dataSource.placeOrder(tPlaceOrderParams);

      verify(() => mockHttpClient.post(
            any(),
            headers: any(named: 'headers'),
            body: requestBody,
          )).called(1);
      expect(
        result,
        throwsA(isA<PaymentStatusAlreadySuccessFailure>()),
      );
    });

    test(
        'should throw OldPaymentStatusAlreadyPendingFailure on 409 and error code=OLD_PAYMENT_STATUS_ALREADY_PENDING',
        () async {
      final requestBody = json.encode({
        "userId": tPlaceOrderParams.userId,
        "name": tPlaceOrderParams.name,
        "address": tPlaceOrderParams.address,
        "phone": tPlaceOrderParams.phone
      });

      var tCartLockedRequestJson = json.encode({
        "error_code": "OLD_PAYMENT_STATUS_ALREADY_PENDING",
        "message":
            "Payment status is already pending! You can retry after old payment window is expired!"
      });
      when(() => mockHttpClient.post(
                any(),
                headers: any(named: 'headers'),
                body: requestBody,
              ))
          .thenAnswer((_) async => http.Response(tCartLockedRequestJson, 409));

      final result = dataSource.placeOrder(tPlaceOrderParams);

      verify(() => mockHttpClient.post(
            any(),
            headers: any(named: 'headers'),
            body: requestBody,
          )).called(1);
      expect(
        result,
        throwsA(isA<OldPaymentStatusAlreadyPendingFailure>()),
      );
    });

    test('should throw BusinessExceptionFailure on 409 and error code=Error',
        () async {
      final requestBody = json.encode({
        "userId": tPlaceOrderParams.userId,
        "name": tPlaceOrderParams.name,
        "address": tPlaceOrderParams.address,
        "phone": tPlaceOrderParams.phone
      });

      var tCartLockedRequestJson = json.encode(
          {"error_code": "Error", "message": "Some fatal error from backend"});
      when(() => mockHttpClient.post(
                any(),
                headers: any(named: 'headers'),
                body: requestBody,
              ))
          .thenAnswer((_) async => http.Response(tCartLockedRequestJson, 409));

      final result = dataSource.placeOrder(tPlaceOrderParams);

      verify(() => mockHttpClient.post(
            any(),
            headers: any(named: 'headers'),
            body: requestBody,
          )).called(1);
      expect(
        result,
        throwsA(isA<BusinessExceptionFailure>()),
      );
    });

    test('should throw ServerFailure on 500 and others', () async {
      final requestBody = json.encode({
        "userId": tPlaceOrderParams.userId,
        "name": tPlaceOrderParams.name,
        "address": tPlaceOrderParams.address,
        "phone": tPlaceOrderParams.phone
      });
      when(() => mockHttpClient.post(
            any(),
            headers: any(named: 'headers'),
            body: requestBody,
          )).thenAnswer((_) async => http.Response('Error', 500));

      final result = dataSource.placeOrder(tPlaceOrderParams);

      verify(() => mockHttpClient.post(
            any(),
            headers: any(named: 'headers'),
            body: requestBody,
          )).called(1);
      expect(
        result,
        throwsA(isA<ServerFailure>()),
      );
    });
  });

  group('cancelCheckout', () {
    final expectedUrl = '$kBaseUrlTest/api/users/checkout/cancel';
    final fakeResponse =
        fixture('checkout/cancel_checkout_response_model.json');

    test('should perform a POST request to correct URL with params', () async {
      final requestBody = json.encode({
        "orderId": tCancelCheckoutParams.orderId,
      });
      when(() => mockHttpClient.post(
            any(),
            headers: any(named: 'headers'),
            body: requestBody,
          )).thenAnswer((_) async => http.Response(fakeResponse, 200));

      final result = await dataSource.cancelCheckout(tCancelCheckoutParams);

      verify(() => mockHttpClient.post(
            any(),
            headers: any(named: 'headers'),
            body: requestBody,
          )).called(1);
      expect(result, isA<Unit>());
    });

    test('should throw CredentialFailure on 400', () async {
      final requestBody = json.encode({
        "orderId": tCancelCheckoutParams.orderId,
      });
      when(() => mockHttpClient.post(
            any(),
            headers: any(named: 'headers'),
            body: requestBody,
          )).thenAnswer((_) async => http.Response('Error', 400));

      final result = dataSource.cancelCheckout(tCancelCheckoutParams);

      verify(() => mockHttpClient.post(
            any(),
            headers: any(named: 'headers'),
            body: requestBody,
          )).called(1);
      expect(
        result,
        throwsA(isA<CredentialFailure>()),
      );
    });

    // BusinessExceptionFailure Cases
    test(
        'should throw OrderStatusNotPendingPaymentFailure on 409 and error code=PAYMENT_REQUEST_NOT_FOUND',
        () async {
      final requestBody = json.encode({
        "orderId": tCancelCheckoutParams.orderId,
      });

      var tCartLockedRequestJson = json.encode({
        "error_code": "ORDER_STATUS_NOT_PENDING_PAYMENT",
        "message": "Order status is not PENDING_PAYMENT."
      });
      when(() => mockHttpClient.post(
                any(),
                headers: any(named: 'headers'),
                body: requestBody,
              ))
          .thenAnswer((_) async => http.Response(tCartLockedRequestJson, 409));

      final result = dataSource.cancelCheckout(tCancelCheckoutParams);

      verify(() => mockHttpClient.post(
            any(),
            headers: any(named: 'headers'),
            body: requestBody,
          )).called(1);
      expect(
        result,
        throwsA(isA<OrderStatusNotPendingPaymentFailure>()),
      );
    });

    test(
        'should throw PaymentDeleteFailedFailure on 409 and error code=PAYMENT_DELETE_FAILED',
        () async {
      final requestBody = json.encode({
        "orderId": tCancelCheckoutParams.orderId,
      });

      var tCartLockedRequestJson = json.encode({
        "error_code": "PAYMENT_DELETE_FAILED",
        "message": "Failed to delete payment."
      });
      when(() => mockHttpClient.post(
                any(),
                headers: any(named: 'headers'),
                body: requestBody,
              ))
          .thenAnswer((_) async => http.Response(tCartLockedRequestJson, 409));

      final result = dataSource.cancelCheckout(tCancelCheckoutParams);

      verify(() => mockHttpClient.post(
            any(),
            headers: any(named: 'headers'),
            body: requestBody,
          )).called(1);
      expect(
        result,
        throwsA(isA<PaymentDeleteFailedFailure>()),
      );
    });

    test(
        'should throw OrderDeleteFailedFailure on 409 and error code=ORDER_DELETE_FAILED',
        () async {
      final requestBody = json.encode({
        "orderId": tCancelCheckoutParams.orderId,
      });

      var tCartLockedRequestJson = json.encode({
        "error_code": "ORDER_DELETE_FAILED",
        "message": "Failed to delete order."
      });
      when(() => mockHttpClient.post(
                any(),
                headers: any(named: 'headers'),
                body: requestBody,
              ))
          .thenAnswer((_) async => http.Response(tCartLockedRequestJson, 409));

      final result = dataSource.cancelCheckout(tCancelCheckoutParams);

      verify(() => mockHttpClient.post(
            any(),
            headers: any(named: 'headers'),
            body: requestBody,
          )).called(1);
      expect(
        result,
        throwsA(isA<OrderDeleteFailedFailure>()),
      );
    });

    test(
        'should throw CartUnlockFailedFailure on 409 and error code=CART_UNLOCK_FAILED',
        () async {
      final requestBody = json.encode({
        "orderId": tCancelCheckoutParams.orderId,
      });

      var tCartLockedRequestJson = json.encode({
        "error_code": "CART_UNLOCK_FAILED",
        "message": "Failed to unlock cart."
      });
      when(() => mockHttpClient.post(
                any(),
                headers: any(named: 'headers'),
                body: requestBody,
              ))
          .thenAnswer((_) async => http.Response(tCartLockedRequestJson, 409));

      final result = dataSource.cancelCheckout(tCancelCheckoutParams);

      verify(() => mockHttpClient.post(
            any(),
            headers: any(named: 'headers'),
            body: requestBody,
          )).called(1);
      expect(
        result,
        throwsA(isA<CartUnlockFailedFailure>()),
      );
    });

    test('should throw BusinessExceptionFailure on 409 and error code=Error',
        () async {
      final requestBody = json.encode({
        "orderId": tCancelCheckoutParams.orderId,
      });

      var tCartLockedRequestJson = json.encode(
          {"error_code": "Error", "message": "Some fatal error from backend"});
      when(() => mockHttpClient.post(
                any(),
                headers: any(named: 'headers'),
                body: requestBody,
              ))
          .thenAnswer((_) async => http.Response(tCartLockedRequestJson, 409));

      final result = dataSource.cancelCheckout(tCancelCheckoutParams);

      verify(() => mockHttpClient.post(
            any(),
            headers: any(named: 'headers'),
            body: requestBody,
          )).called(1);
      expect(
        result,
        throwsA(isA<BusinessExceptionFailure>()),
      );
    });

    test('should throw ServerFailure on 500 and others', () async {
      final requestBody = json.encode({
        "orderId": tCancelCheckoutParams.orderId,
      });
      when(() => mockHttpClient.post(
            any(),
            headers: any(named: 'headers'),
            body: requestBody,
          )).thenAnswer((_) async => http.Response('Error', 500));

      final result = dataSource.cancelCheckout(tCancelCheckoutParams);

      verify(() => mockHttpClient.post(
            any(),
            headers: any(named: 'headers'),
            body: requestBody,
          )).called(1);
      expect(
        result,
        throwsA(isA<ServerFailure>()),
      );
    });
  });
}
