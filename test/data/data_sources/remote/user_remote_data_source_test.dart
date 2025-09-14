import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:foody_licious/core/constant/strings.dart';
import 'package:foody_licious/core/error/failures.dart';
import 'package:foody_licious/data/data_sources/remote/user_remote_data_source.dart';
import 'package:foody_licious/data/models/user/user_response_model.dart';
import 'package:foody_licious/domain/usecase/user/update_user_usecase.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

import '../../../fixtures/fixture_reader.dart';
import '../../../helpers/test_loadenv.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late UserRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUpAll(() {
    // Register fallback values for mocktail
    registerFallbackValue(Uri.parse('https://example.com'));
  });

  setUp(() async {
    await loadTestDotEnv();
    mockHttpClient = MockHttpClient();
    dataSource = UserRemoteDataSourceImpl(client: mockHttpClient);
  });

  test('use BASE_URL from env', () {
    print("Url--->$kBaseUrl");
    print("Test Url--->$kBaseUrlTest");
    expect(kBaseUrlTest, contains('http')); // ✅ now available everywhere
  });

  group('updateUser', () {
    var fakeParams = UpdateUserParams(
      id: 'RcrNpesIeKSd3afH67ndyDLUaMJ3',
      name: 'Test Name',
      phone: '+919876543210',
    );
    var expectedUrl = '$kBaseUrlTest/api/users/profile';
    final fakeResponse = fixture('user/user_response_model.json');

    test('should perform a PUT request to correct URL with params', () async {
      print("Url from updateUser--->$kBaseUrlTest");

      /// Arrange
      when(() => mockHttpClient.put(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
            encoding: any(named: 'encoding'),
          )).thenAnswer((_) async => http.Response(fakeResponse, 200));

      /// Act
      final result = await dataSource.updateUser(fakeParams);

      /// Assert
      verify(() => mockHttpClient.put(
            any(),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode(fakeParams.toJson()),
            encoding: null,
          ));
      expect(result, isA<UserResponseModel>());
    });

    test('should throw CredentialFailure on 400 or 401', () async {
      print("Url from updateUser2--->$kBaseUrlTest");

      /// Arrange
      when(() => mockHttpClient.put(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
            encoding: any(named: 'encoding'),
          )).thenAnswer((_) async => http.Response('Error', 400));

      /// Act & Assert
      expect(
        () async => await dataSource.updateUser(fakeParams),
        throwsA(isA<CredentialFailure>()),
      );
    });

    test('should throw ServerFailure on non-200 other than 400/401', () async {
      /// Arrange
      when(() => mockHttpClient.put(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
            encoding: any(named: 'encoding'),
          )).thenAnswer((_) async => http.Response('Error', 500));

      /// Act & Assert
      expect(
        () async => await dataSource.updateUser(fakeParams),
        throwsA(isA<ServerFailure>()),
      );
    });
  });

  // group('deleteUser', () {
  //   var fakeParams = "RcrNpesIeKSd3afH67ndyDLUaMJ3";
  //   var expectedUrl = '$kBaseUrlTest/api/users/delete_user';
  //   final fakeResponse = fixture('user/user_response_model.json');

  //   test('should perform a POST request to correct URL with params', () async {
  //     print("Url from updateUser--->$kBaseUrlTest");

  //     /// Arrange
  //     when(() => mockHttpClient.post(
  //           any(),
  //           headers: any(named: 'headers'),
  //           body: any(named: 'body'),
  //           encoding: any(named: 'encoding'),
  //         )).thenAnswer((_) async => http.Response(fakeResponse, 200));

  //     /// Act
  //     final result = await dataSource.deleteUser(fakeParams);

  //     /// Assert
  //     verify(() => mockHttpClient.post(
  //           any(),
  //           headers: {'Content-Type': 'application/json'},
  //           body: jsonEncode(fakeParams),
  //           encoding: null,
  //         ));
  //     expect(result, isA<UserResponseModel>());
  //   });

  //   test('should throw CredentialFailure on 400 or 401', () async {
  //     print("Url from updateUser2--->$kBaseUrlTest");

  //     /// Arrange
  //     when(() => mockHttpClient.post(
  //           any(),
  //           headers: any(named: 'headers'),
  //           body: any(named: 'body'),
  //           encoding: any(named: 'encoding'),
  //         )).thenAnswer((_) async => http.Response('Error', 400));

  //     /// Act & Assert
  //     expect(
  //       () async => await dataSource.updateUser(fakeParams),
  //       throwsA(isA<CredentialFailure>()),
  //     );
  //   });

  //   test('should throw ServerFailure on non-200 other than 400/401', () async {
  //     /// Arrange
  //     when(() => mockHttpClient.put(
  //           any(),
  //           headers: any(named: 'headers'),
  //           body: any(named: 'body'),
  //           encoding: any(named: 'encoding'),
  //         )).thenAnswer((_) async => http.Response('Error', 500));

  //     /// Act & Assert
  //     expect(
  //       () async => await dataSource.updateUser(fakeParams),
  //       throwsA(isA<ServerFailure>()),
  //     );
  //   });
  // });
}
