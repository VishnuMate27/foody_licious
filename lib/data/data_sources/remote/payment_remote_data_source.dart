import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:foody_licious/core/constant/strings.dart';
import 'package:foody_licious/core/error/failures.dart';
import 'package:foody_licious/domain/usecase/payment/complete_payment_usecase.dart';
import 'package:http/http.dart' as http;

abstract class PaymentRemoteDataSource {
  Future<Unit> completePayment(PaymentParams params);
}

class PaymentRemoteDataSourceImpl extends PaymentRemoteDataSource {
  final http.Client client;
  PaymentRemoteDataSourceImpl({required this.client});
  @override
  Future<Unit> completePayment(PaymentParams params) {
    return sendCompletePaymentRequest(params);
  }

  Future<Unit> sendCompletePaymentRequest(PaymentParams params) async {
    final requestBody = json.encode(
        {"paymentId": params.paymentId, "paymentMode": params.paymentMode});
    final response = await client.post(
        Uri.parse("$kBaseUrl/api/users/payment/completePayment"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: requestBody);

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
