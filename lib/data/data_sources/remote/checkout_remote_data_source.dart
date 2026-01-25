import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:foody_licious/core/constant/strings.dart';
import 'package:foody_licious/core/error/failures.dart';
import 'package:foody_licious/data/models/checkout/place_order_model.dart';
import 'package:foody_licious/domain/usecase/checkout/cancel_checkout_usecase.dart';
import 'package:foody_licious/domain/usecase/checkout/place_order_usecase.dart';
import 'package:http/http.dart' as http;

abstract class CheckoutRemoteDataSource {
  Future<PlaceOrderModel> placeOrder(PlaceOrderParams params);
  Future<Unit> cancelCheckout(CancelCheckoutParams params);
}

class CheckoutRemoteDataSourceImpl extends CheckoutRemoteDataSource {
  final http.Client client;
  CheckoutRemoteDataSourceImpl({required this.client});
  @override
  Future<PlaceOrderModel> placeOrder(PlaceOrderParams params) {
    return _sendPlaceOrderRequest(params);
  }

  @override
  Future<Unit> cancelCheckout(CancelCheckoutParams params) {
    return _sendCancelCheckoutRequest(params);
  }

  Future<PlaceOrderModel> _sendPlaceOrderRequest(
      PlaceOrderParams params) async {
    final requestBody = json.encode({
      "userId": params.userId,
      "name": params.name,
      "address": params.address,
      "phone": params.phone
    });

    final response = await client.post(
      Uri.parse(
        "$kBaseUrl/api/users/checkout/place-order",
      ),
      headers: {
        'Content-Type': 'application/json',
      },
      body: requestBody,
    );

    if (response.statusCode == 201) {
      return placeOrderModelFromJson(response.body);
    } else if (response.statusCode == 400) {
      throw CredentialFailure();
    } else if (response.statusCode == 409) {
      final body = json.decode(response.body);

      switch (body['error_code']) {
        case 'CART_LOCKED':
          throw CartLockedFailure();
        case 'CART_EMPTY':
          throw CartEmptyFailure();
        case 'OLD_ORDER_PENDING':
          throw OldOrderPendingFailure();
        case 'CART_NOT_FOUND':
          throw CartNotExistsFailure();
        case 'CART_LOCK_FAILED':
          throw CartLockFailedFailure();
        case 'ORDER_NOT_FOUND':
          throw OrderNotFoundFailure();
        case 'ORDER_STATUS_NOT_PENDING_PAYMENT':
          throw OrderStatusNotPendingPaymentFailure();
        case 'PAYMENT_STATUS_ALREADY_SUCCESS':
          throw PaymentStatusAlreadySuccessFailure();
        case 'OLD_PAYMENT_STATUS_ALREADY_PENDING':
          throw OldPaymentStatusAlreadyPendingFailure();
        default:
          throw BusinessExceptionFailure(body['message']);
      }
    } else {
      throw ServerFailure();
    }
  }

  Future<Unit> _sendCancelCheckoutRequest(CancelCheckoutParams params) async {
    final requestBody = json.encode({
      "orderId": params.orderId,
    });

    final response = await client.post(
      Uri.parse(
        "$kBaseUrl/api/users/checkout/cancel",
      ),
      headers: {
        'Content-Type': 'application/json',
      },
      body: requestBody,
    );

    if (response.statusCode == 200) {
      return unit;
    } else if (response.statusCode == 400) {
      throw CredentialFailure();
    } else if (response.statusCode == 409) {
      final body = json.decode(response.body);

      switch (body['error_code']) {
        case 'PAYMENT_REQUEST_NOT_FOUND':
          throw PaymentRequestNotFoundFailure();
        case 'PAYMENT_STATUS_IS_NOT_PENDING':
          throw PaymentStatusIsNotPendingFailure();
        case 'PAYMENT_STATUS_IS_NOT_SELECTED':
          throw PaymentStatusIsNotSelectedFailure();
        case 'FAILED_TO_UPDATE_PAYMENT_MODE':
          throw FailedToUpdatePaymentModeFailure();
        default:
          throw BusinessExceptionFailure(body['message']);
      }
    } else {
      throw ServerFailure();
    }
  }
}
