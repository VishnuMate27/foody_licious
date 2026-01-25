import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foody_licious/core/error/failures.dart';
import 'package:foody_licious/data/data_sources/remote/payment_remote_data_source.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import '../../../fixtures/constant_objects.dart';
import '../../../fixtures/fixture_reader.dart';
import '../../../helpers/test_loadenv.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late PaymentRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUpAll(() {
    registerFallbackValue(Uri.parse('https://example.com'));
  });

  setUp(() async {
    await loadTestDotEnv();
    mockHttpClient = MockHttpClient();
    dataSource = PaymentRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('completePayment', () {
    final expectedUrl = '$kBaseUrlTest/api/users/checkout/place-order';
    final fakeResponse = fixture('checkout/place_order_response_model.json');
    final requestBody = json.encode({
      "paymentId": tPaymentParams.paymentId,
      "paymentMode": tPaymentParams.paymentMode
    });

    test('should perform a POST request to correct URL with params', () async {
      when(() => mockHttpClient.post(
            any(),
            headers: any(named: 'headers'),
            body: requestBody,
          )).thenAnswer((_) async => http.Response(fakeResponse, 200));

      final result = await dataSource.completePayment(tPaymentParams);

      verify(() => mockHttpClient.post(
            any(),
            headers: any(named: 'headers'),
            body: requestBody,
          )).called(1);
      expect(result, isA<Unit>());
    });

    test('should throw CredentialFailure on 400', () async {
      when(() => mockHttpClient.post(
            any(),
            headers: any(named: 'headers'),
            body: requestBody,
          )).thenAnswer((_) async => http.Response('Error', 400));

      final result = dataSource.completePayment(tPaymentParams);

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

    test(
        'should throw PaymentRequestNotFoundFailure on 409 and error_code=PAYMENT_REQUEST_NOT_FOUND',
        () async {
      final tCompletePaymentResponseJson = json.encode({
        "error_code": "PAYMENT_REQUEST_NOT_FOUND",
        "message": "Payment request not found."
      });
      when(() => mockHttpClient.post(
                any(),
                headers: any(named: 'headers'),
                body: requestBody,
              ))
          .thenAnswer(
              (_) async => http.Response(tCompletePaymentResponseJson, 409));

      final result = dataSource.completePayment(tPaymentParams);

      verify(() => mockHttpClient.post(
            any(),
            headers: any(named: 'headers'),
            body: requestBody,
          )).called(1);
      expect(
        result,
        throwsA(isA<PaymentRequestNotFoundFailure>()),
      );
    });

    test(
        'should throw PaymentStatusIsNotPendingFailure on 409 and error_code=PAYMENT_STATUS_IS_NOT_PENDING',
        () async {
      final tCompletePaymentResponseJson = json.encode({
        "error_code": "PAYMENT_REQUEST_NOT_FOUND",
        "message": "Payment status is not PENDING."
      });
      when(() => mockHttpClient.post(
                any(),
                headers: any(named: 'headers'),
                body: requestBody,
              ))
          .thenAnswer(
              (_) async => http.Response(tCompletePaymentResponseJson, 409));

      final result = dataSource.completePayment(tPaymentParams);

      verify(() => mockHttpClient.post(
            any(),
            headers: any(named: 'headers'),
            body: requestBody,
          )).called(1);
      expect(
        result,
        throwsA(isA<PaymentRequestNotFoundFailure>()),
      );
    });

    test(
        'should throw PaymentStatusIsNotSelectedFailure on 409 and error_code=PAYMENT_STATUS_IS_NOT_SELECTED',
        () async {
      final tCompletePaymentRequestJson = json.encode({
        "error_code": "PAYMENT_STATUS_IS_NOT_SELECTED",
        "message": "Payment mode is not NOT_SELECTED."
      });
      when(() => mockHttpClient.post(
                any(),
                headers: any(named: 'headers'),
                body: requestBody,
              ))
          .thenAnswer(
              (_) async => http.Response(tCompletePaymentRequestJson, 409));

      final result = dataSource.completePayment(tPaymentParams);

      verify(() => mockHttpClient.post(
            any(),
            headers: any(named: 'headers'),
            body: requestBody,
          )).called(1);
      expect(
        result,
        throwsA(isA<PaymentStatusIsNotSelectedFailure>()),
      );
    });

    test(
        'should throw FailedToUpdatePaymentModeFailure on 409 and error_code=FAILED_TO_UPDATE_PAYMENT_MODE',
        () async {
      final tCompletePaymentRequestJson = json.encode({
        "error_code": "FAILED_TO_UPDATE_PAYMENT_MODE",
        "message": "Failed to update payment mode to {paymentMode}."
      });
      when(() => mockHttpClient.post(
                any(),
                headers: any(named: 'headers'),
                body: requestBody,
              ))
          .thenAnswer(
              (_) async => http.Response(tCompletePaymentRequestJson, 409));

      final result = dataSource.completePayment(tPaymentParams);

      verify(() => mockHttpClient.post(
            any(),
            headers: any(named: 'headers'),
            body: requestBody,
          )).called(1);
      expect(
        result,
        throwsA(isA<FailedToUpdatePaymentModeFailure>()),
      );
    });

    test('should throw BusinessExceptionFailure on 409 and error_code=Error',
        () async {
      final tCompletePaymentRequestJson =
          json.encode({"error_code": "Error", "message": "Some Error message"});
      when(() => mockHttpClient.post(
                any(),
                headers: any(named: 'headers'),
                body: requestBody,
              ))
          .thenAnswer(
              (_) async => http.Response(tCompletePaymentRequestJson, 409));

      final result = dataSource.completePayment(tPaymentParams);

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
      when(() => mockHttpClient.post(
            any(),
            headers: any(named: 'headers'),
            body: requestBody,
          )).thenAnswer((_) async => http.Response('Error', 500));

      final result = dataSource.completePayment(tPaymentParams);

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
