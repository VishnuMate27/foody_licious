import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foody_licious/core/constant/strings.dart';
import 'package:foody_licious/core/error/failures.dart';
import 'package:foody_licious/data/data_sources/remote/user_remote_data_source.dart';
import 'package:foody_licious/data/models/user/user_response_model.dart';
import 'package:foody_licious/data/services/location_service.dart';
import 'package:foody_licious/domain/usecase/user/update_user_usecase.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

import '../../../fixtures/constant_objects.dart';
import '../../../fixtures/fixture_reader.dart';
import '../../../helpers/test_loadenv.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockLocationService extends Mock implements LocationService {}

void main() {
  late UserRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;
  late MockLocationService mockLocationService;
  // Create a fake position
  final fakePosition = Position(
    latitude: 70.0,
    longitude: 75.0,
    timestamp: DateTime.now(),
    accuracy: 5.0,
    altitude: 10.0,
    altitudeAccuracy: 5.0,
    heading: 90.0,
    headingAccuracy: 1.0,
    speed: 0.0,
    speedAccuracy: 0.0,
    isMocked: true,
  );

  setUpAll(() {
    // Register fallback values for mocktail
    registerFallbackValue(Uri.parse('https://example.com'));
  });

  setUp(() async {
    await loadTestDotEnv();
    mockHttpClient = MockHttpClient();
    mockLocationService = MockLocationService();
    dataSource = UserRemoteDataSourceImpl(
        client: mockHttpClient, locationService: mockLocationService);
  });

  test('use BASE_URL from env', () {
    expect(kBaseUrlTest, contains('http')); // ✅ now available everywhere
  });

  group('updateUser', () {
    var expectedUrl = '$kBaseUrlTest/api/users/profile';
    final fakeResponse = fixture('user/user_response_model.json');

    test('should perform a PUT request to correct URL with params', () async {
      /// Arrange
      when(() => mockHttpClient.put(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
            encoding: any(named: 'encoding'),
          )).thenAnswer((_) async => http.Response(fakeResponse, 200));

      /// Act
      final result = await dataSource.updateUser(tUpdateUserParams);

      /// Assert
      verify(() => mockHttpClient.put(
            any(),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode(tUpdateUserParams.toJson()),
            encoding: null,
          ));
      expect(result, isA<UserResponseModel>());
    });

    test('should throw CredentialFailure on 400 or 401', () async {
      /// Arrange
      when(() => mockHttpClient.put(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
            encoding: any(named: 'encoding'),
          )).thenAnswer((_) async => http.Response('Error', 400));

      /// Act & Assert
      expect(
        () async => await dataSource.updateUser(tUpdateUserParams),
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
        () async => await dataSource.updateUser(tUpdateUserParams),
        throwsA(isA<ServerFailure>()),
      );
    });
  });

  group('updateUserLocation', () {
    String userId = "RcrNpesIeKSd3afH67ndyDLUaMJ3";
    var expectedUrl = '$kBaseUrlTest/api/users/profile';
    final fakeResponse = fixture('user/user_response_model.json');

    setUp(() {
      // Stub the location service
      when(() => mockLocationService.determinePosition())
          .thenAnswer((_) async => fakePosition);
    });

    test('should perform a PUT request to correct URL with params', () async {
      final fakeParams = {
        "id": userId,
        "address": {
          "coordinates": {
            "type": "Point",
            "coordinates": [70.0, 75.0], // must match fakePosition
          }
        }
      };

      when(() => mockHttpClient.put(
            Uri.parse('$kBaseUrl/api/users/profile'),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
            encoding: any(named: 'encoding'),
          )).thenAnswer((_) async => http.Response(fakeResponse, 200));

      final result = await dataSource.updateUserLocation(userId);

      verify(() => mockHttpClient.put(
            Uri.parse('$kBaseUrl/api/users/profile'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode(fakeParams),
            encoding: null,
          ));
      expect(result, isA<UserResponseModel>());
    });

    test('should throw CredentialFailure on 400 or 401', () async {
      when(() => mockHttpClient.put(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
            encoding: any(named: 'encoding'),
          )).thenAnswer((_) async => http.Response('Error', 400));

      expect(
        () async => await dataSource.updateUserLocation(userId),
        throwsA(isA<CredentialFailure>()),
      );
    });

    test('should throw ServerFailure on non-200 other than 400/401', () async {
      when(() => mockHttpClient.put(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
            encoding: any(named: 'encoding'),
          )).thenAnswer((_) async => http.Response('Error', 500));

      expect(
        () async => await dataSource.updateUserLocation(userId),
        throwsA(isA<ServerFailure>()),
      );
    });
  });

  group('deleteUser', () {
    String userId = "RcrNpesIeKSd3afH67ndyDLUaMJ3";
    var expectedUrl = '$kBaseUrlTest/api/users/delete_user';

    test('should perform a POST request to correct URL with params', () async {
      final fakeParams = {
        "id": userId,
      };

      when(() => mockHttpClient.post(
            Uri.parse('$kBaseUrl/api/users/delete_user'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode(fakeParams),
            encoding: any(named: 'encoding'),
          )).thenAnswer((_) async => http.Response("Response", 200));

      final result = await dataSource.deleteUser(userId);

      verify(() => mockHttpClient.post(
            Uri.parse('$kBaseUrl/api/users/delete_user'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode(fakeParams),
            encoding: null,
          ));
      expect(result, isA<Unit>());
    });

    test('should throw CredentialFailure on 400 or 401', () async {
      when(() => mockHttpClient.post(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
            encoding: any(named: 'encoding'),
          )).thenAnswer((_) async => http.Response('Error', 400));

      expect(
        () async => await dataSource.deleteUser(userId),
        throwsA(isA<CredentialFailure>()),
      );
    });

    test('should throw UserNotExistsFailure on 404', () async {
      when(() => mockHttpClient.post(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
            encoding: any(named: 'encoding'),
          )).thenAnswer((_) async => http.Response('Error', 404));

      expect(
        () async => await dataSource.deleteUser(userId),
        throwsA(isA<UserNotExistsFailure>()),
      );
    });

    test('should throw ServerFailure on non-200 other than 400/401', () async {
      when(() => mockHttpClient.post(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
            encoding: any(named: 'encoding'),
          )).thenAnswer((_) async => http.Response('Error', 500));

      expect(
        () async => await dataSource.deleteUser(userId),
        throwsA(isA<ServerFailure>()),
      );
    });
  });
}
