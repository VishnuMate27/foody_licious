import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foody_licious/core/error/failures.dart';
import 'package:foody_licious/data/data_sources/remote/auth_remote_data_source.dart';
import 'package:foody_licious/data/models/user/authentication_response_model.dart';
import 'package:foody_licious/data/models/user/user_response_model.dart';
import 'package:foody_licious/domain/usecase/auth/sign_in_with_email_usecase.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

import '../../../fixtures/constant_objects.dart';
import '../../../fixtures/fixture_reader.dart';
import '../../../helpers/test_loadenv.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockGoogleSignIn extends Mock implements GoogleSignIn {}

class MockUserCredential extends Mock implements UserCredential {}

class MockUser extends Mock implements User {}

void main() {
  late AuthRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;
  late MockFirebaseAuth mockFirebaseAuth;
  late MockGoogleSignIn mockGoogleSignIn;

  setUpAll(() {
    // Register fallback values for mocktail
    registerFallbackValue(Uri.parse('https://example.com'));
  });

  setUp(() async {
    await loadTestDotEnv();
    mockHttpClient = MockHttpClient();
    mockFirebaseAuth = MockFirebaseAuth();
    mockGoogleSignIn = MockGoogleSignIn();
    dataSource = AuthRemoteDataSourceImpl(
        client: mockHttpClient,
        firebaseAuth: mockFirebaseAuth,
        googleSignIn: mockGoogleSignIn);
  });

  test('use BASE_URL from env', () {
    expect(kBaseUrlTest, contains('http'));
  });
  test('dataSource is initialized', () {
    expect(dataSource, isNotNull);
  });

  group('signInWithEmail', () {
    final mockUser = MockUser();
    final mockUserCredential = MockUserCredential();

    setUp(() {
      when(() => mockUser.uid).thenReturn('123');
      when(() => mockUser.email).thenReturn(tSignInWithEmailParams.email);
      when(() => mockUser.phoneNumber).thenReturn('+919876543210');
      when(() => mockUserCredential.user).thenReturn(mockUser);

      when(() => mockFirebaseAuth.signInWithEmailAndPassword(
            email: tSignInWithEmailParams.email,
            password: tSignInWithEmailParams.password,
          )).thenAnswer((_) async => mockUserCredential);
    });

    test('should perform a POST request to correct URL with params', () async {
      // Arrange
      final fakeResponse = fixture('auth/authentication_response_model.json');

      when(() => mockHttpClient.post(
            Uri.parse('$kBaseUrlTest/api/auth/login'),
            headers: {'Content-Type': 'application/json'},
            body: any(named: 'body'),
          )).thenAnswer((_) async => http.Response(fakeResponse, 200));

      // Act
      final result = await dataSource.signInWithEmail(tSignInWithEmailParams);

      // Assert
      verify(() => mockHttpClient.post(
            Uri.parse('$kBaseUrlTest/api/auth/login'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              "email": tSignInWithEmailParams.email,
              "id": "123",
              "phone": "+919876543210",
              "authProvider": tSignInWithEmailParams.authProvider,
            }),
          ));
      expect(result, isA<AuthenticationResponseModel>());
    });

    test('should throw CredentialFailure on 400', () async {
      // Arrange
      when(() => mockHttpClient.post(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          )).thenAnswer((_) async => http.Response('Error', 400));

      // Act & Assert
      expect(
        () async => dataSource.signInWithEmail(tSignInWithEmailParams),
        throwsA(isA<CredentialFailure>()),
      );
    });

    test('should throw AuthProviderMissMatchFailure on 401', () async {
      // Arrange
      when(() => mockHttpClient.post(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          )).thenAnswer((_) async => http.Response('Error', 401));

      // Act & Assert
      expect(
        () async => dataSource.signInWithEmail(tSignInWithEmailParams),
        throwsA(isA<AuthProviderMissMatchFailure>()),
      );
    });

    test('should throw UserNotExistsFailure on 404', () async {
      // Arrange
      when(() => mockHttpClient.post(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          )).thenAnswer((_) async => http.Response('Error', 404));

      // Act & Assert
      expect(
        () async => dataSource.signInWithEmail(tSignInWithEmailParams),
        throwsA(isA<UserNotExistsFailure>()),
      );
    });

    test('should throw ServerFailure on non-200 other than 400/401/404',
        () async {
      // Arrange
      when(() => mockHttpClient.post(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          )).thenAnswer((_) async => http.Response('Error', 500));

      // Act & Assert
      expect(
        () async => dataSource.signInWithEmail(tSignInWithEmailParams),
        throwsA(isA<ServerFailure>()),
      );
    });
  });

  group('verifyPhoneNumberForLogin', () {
    final mockUser = MockUser();
    final mockUserCredential = MockUserCredential();

    test('should perform a POST request to correct URL with params', () async {
      // Arrange
      final fakeResponse = fixture('auth/authentication_response_model.json');

      when(() => mockHttpClient.post(
            Uri.parse('$kBaseUrlTest/api/auth/sendVerificationCodeForLogin'),
            headers: {'Content-Type': 'application/json'},
            body: any(named: 'body'),
          )).thenAnswer((_) async => http.Response(fakeResponse, 200));

      // Act
      final result =
          await dataSource.verifyPhoneNumberForLogin(tSignInWithPhoneParams);

      // Assert
      verify(() => mockHttpClient.post(
            Uri.parse('$kBaseUrlTest/api/auth/sendVerificationCodeForLogin'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              "phone": tSignInWithPhoneParams.phone ?? "",
            }),
          ));
      expect(result, isA<Unit>());
    });

    test('should throw CredentialFailure on 400', () async {
      // Arrange
      when(() => mockHttpClient.post(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          )).thenAnswer((_) async => http.Response('Error', 400));

      // Act & Assert
      expect(
        () async =>
            dataSource.verifyPhoneNumberForLogin(tSignInWithPhoneParams),
        throwsA(isA<CredentialFailure>()),
      );
    });

    test('should throw CredentialFailure on 401', () async {
      // Arrange
      when(() => mockHttpClient.post(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          )).thenAnswer((_) async => http.Response('Error', 401));

      // Act & Assert
      expect(
        () async =>
            dataSource.verifyPhoneNumberForLogin(tSignInWithPhoneParams),
        throwsA(isA<CredentialFailure>()),
      );
    });

    test('should throw UserNotExistsFailure on 404', () async {
      // Arrange
      when(() => mockHttpClient.post(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          )).thenAnswer((_) async => http.Response('Error', 404));

      // Act & Assert
      expect(
        () async =>
            dataSource.verifyPhoneNumberForLogin(tSignInWithPhoneParams),
        throwsA(isA<UserNotExistsFailure>()),
      );
    });

    test('should throw ServerFailure on non-200 other than 400/401/404',
        () async {
      // Arrange
      when(() => mockHttpClient.post(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          )).thenAnswer((_) async => http.Response('Error', 500));

      // Act & Assert
      expect(
        () async =>
            dataSource.verifyPhoneNumberForLogin(tSignInWithPhoneParams),
        throwsA(isA<ServerFailure>()),
      );
    });
  });

  // group('signInWithPhone', () {
  //   final mockUser = MockUser();
  //   final mockUserCredential = MockUserCredential();

  //   test('should perform a POST request to correct URL with params', () async {
  //     // Arrange
  //     final fakeResponse = fixture('auth/authentication_response_model.json');

  //     when(() => mockHttpClient.post(
  //           any(),
  //           headers: any(named: 'headers'),
  //           body: any(named: 'body'),
  //         )).thenAnswer((_) async => http.Response(fakeResponse, 200));

  //     // Act
  //     final result = await dataSource.signInWithPhone(tSignInWithPhoneParams);

  //     // Assert
  //     verify(() => mockHttpClient.post(
  //           Uri.parse(
  //               '$kBaseUrlTest/api/auth/sendVerificationCodeForLogin'), // 👈 must match datasource
  //           headers: {'Content-Type': 'application/json'},
  //           body: jsonEncode({
  //             "phone": tSignInWithPhoneParams.phone ?? "",
  //             "authProvider": tSignInWithPhoneParams.authProvider,
  //             "code": tSignInWithPhoneParams.code,
  //           }),
  //         ));
  //     expect(result, isA<AuthenticationResponseModel>());
  //   });

  //   test('should throw CredentialFailure on 400', () async {
  //     // Arrange
  //     when(() => mockHttpClient.post(
  //           any(),
  //           headers: any(named: 'headers'),
  //           body: any(named: 'body'),
  //         )).thenAnswer((_) async => http.Response('Error', 400));

  //     // Act & Assert
  //     expect(
  //       () async => dataSource.signInWithPhone(tSignInWithPhoneParams),
  //       throwsA(isA<CredentialFailure>()),
  //     );
  //   });

  //   test('should throw CredentialFailure on 401', () async {
  //     // Arrange
  //     when(() => mockHttpClient.post(
  //           any(),
  //           headers: any(named: 'headers'),
  //           body: any(named: 'body'),
  //         )).thenAnswer((_) async => http.Response('Error', 401));

  //     // Act & Assert
  //     expect(
  //       () async => dataSource.signInWithPhone(tSignInWithPhoneParams),
  //       throwsA(isA<CredentialFailure>()),
  //     );
  //   });

  //   test('should throw UserNotExistsFailure on 404', () async {
  //     // Arrange
  //     when(() => mockHttpClient.post(
  //           any(),
  //           headers: any(named: 'headers'),
  //           body: any(named: 'body'),
  //         )).thenAnswer((_) async => http.Response('Error', 404));

  //     // Act & Assert
  //     expect(
  //       () async => dataSource.signInWithPhone(tSignInWithPhoneParams),
  //       throwsA(isA<UserNotExistsFailure>()),
  //     );
  //   });

  //   test('should throw ServerFailure on non-200 other than 400/401/404',
  //       () async {
  //     // Arrange
  //     when(() => mockHttpClient.post(
  //           any(),
  //           headers: any(named: 'headers'),
  //           body: any(named: 'body'),
  //         )).thenAnswer((_) async => http.Response('Error', 500));

  //     // Act & Assert
  //     expect(
  //       () async => dataSource.signInWithPhone(tSignInWithPhoneParams),
  //       throwsA(isA<ServerFailure>()),
  //     );
  //   });
  // });
}
