import 'dart:convert';
import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
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

class MockGoogleSignInAccount extends Mock implements GoogleSignInAccount {}

class MockGoogleSignInAuthentication extends Mock
    implements GoogleSignInAuthentication {}

class FakeAuthCredential extends Mock implements AuthCredential {}

class MockFacebookAuth extends Mock implements FacebookAuth {}

class MockLoginResult extends Mock implements LoginResult {}

class MockFacebookAuthProvider extends Mock implements FacebookAuthProvider {}

class MockAccessToken extends Mock implements AccessToken {}

void main() {
  late AuthRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;
  late MockFirebaseAuth mockFirebaseAuth;
  late MockGoogleSignIn mockGoogleSignIn;
  late MockFacebookAuth mockFacebookAuth;

  setUpAll(() {
    // Register fallback values for mocktail
    registerFallbackValue(Uri.parse('https://example.com'));
    registerFallbackValue(FakeAuthCredential());
  });

  setUp(() async {
    await loadTestDotEnv();
    mockHttpClient = MockHttpClient();
    mockFirebaseAuth = MockFirebaseAuth();
    mockGoogleSignIn = MockGoogleSignIn();
    mockFacebookAuth = MockFacebookAuth();
    dataSource = AuthRemoteDataSourceImpl(
        client: mockHttpClient,
        firebaseAuth: mockFirebaseAuth,
        googleSignIn: mockGoogleSignIn,
        facebookAuth: mockFacebookAuth);
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

  group('signInWithPhone', () {
    final mockUser = MockUser();
    final mockUserCredential = MockUserCredential();

    test('should perform a POST request to correct URL with params', () async {
      // Arrange
      final fakeResponse = fixture('auth/authentication_response_model.json');

      when(() => mockHttpClient.post(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          )).thenAnswer((_) async => http.Response(fakeResponse, 200));

      // Act
      final result = await dataSource.signInWithPhone(tSignInWithPhoneParams);

      // Assert
      verify(() => mockHttpClient.post(
            Uri.parse(
                '$kBaseUrlTest/api/auth/verifyCodeAndLoginWithPhone'), // 👈 must match datasource
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              "phone": tSignInWithPhoneParams.phone ?? "",
              "authProvider": tSignInWithPhoneParams.authProvider,
              "code": tSignInWithPhoneParams.code,
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
        () async => dataSource.signInWithPhone(tSignInWithPhoneParams),
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
        () async => dataSource.signInWithPhone(tSignInWithPhoneParams),
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
        () async => dataSource.signInWithPhone(tSignInWithPhoneParams),
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
        () async => dataSource.signInWithPhone(tSignInWithPhoneParams),
        throwsA(isA<ServerFailure>()),
      );
    });
  });

  group('signInWithGoogle', () {
    final mockUser = MockUser();
    final mockUserCredential = MockUserCredential();
    final mockGoogleUser = MockGoogleSignInAccount();
    final mockGoogleAuth = MockGoogleSignInAuthentication();

    test('should sign in with Google and return AuthenticationResponseModel',
        () async {
      // Arrange
      when(() => mockGoogleSignIn.initialize(
              serverClientId: any(named: 'serverClientId')))
          .thenAnswer((_) async => {});

      when(() => mockGoogleSignIn.authenticate())
          .thenAnswer((_) async => mockGoogleUser);

      when(() => mockGoogleUser.authentication)
          .thenAnswer((_) => mockGoogleAuth);

      when(() => mockGoogleAuth.idToken).thenReturn("fake_id_token");

      when(() => mockFirebaseAuth.signInWithCredential(any()))
          .thenAnswer((_) async => mockUserCredential);

      when(() => mockUserCredential.user).thenReturn(mockUser);
      when(() => mockUser.uid).thenReturn("uid_123");
      when(() => mockUser.email).thenReturn("test@example.com");

      final fakeResponse = fixture('auth/authentication_response_model.json');
      when(() => mockHttpClient.post(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          )).thenAnswer((_) async => http.Response(fakeResponse, 200));

      // Act
      final result = await dataSource.signInWithGoogle();

      // Assert
      expect(result, isA<AuthenticationResponseModel>());
      verify(() => mockGoogleSignIn.authenticate()).called(1);
      verify(() => mockFirebaseAuth.signInWithCredential(any())).called(1);
      verify(() => mockHttpClient.post(
            Uri.parse('$kBaseUrlTest/api/auth/login'),
            headers: {'Content-Type': 'application/json'},
            body: any(named: 'body'),
          )).called(1);
    });

    test('should throw ExceptionFailure when Google user is null', () async {
      // Arrange
      when(() => mockGoogleSignIn.initialize(
              serverClientId: any(named: 'serverClientId')))
          .thenAnswer((_) async => {});
      when(() => mockGoogleSignIn.authenticate())
          .thenAnswer((_) => Future.value(null));

      // Act
      final call = dataSource.signInWithGoogle;

      // Assert
      expect(() => call(), throwsA(isA<ExceptionFailure>()));
    });

    test('should throw ExceptionFailure when firebase user is null', () async {
      // Arrange
      when(() => mockGoogleSignIn.initialize(
              serverClientId: any(named: 'serverClientId')))
          .thenAnswer((_) async => {});
      when(() => mockGoogleSignIn.authenticate())
          .thenAnswer((_) async => mockGoogleUser);
      when(() => mockGoogleUser.authentication)
          .thenAnswer((_) => mockGoogleAuth);
      when(() => mockGoogleAuth.idToken).thenReturn("fake_id_token");
      when(() => mockFirebaseAuth.signInWithCredential(any()))
          .thenAnswer((_) async => mockUserCredential);
      when(() => mockUserCredential.user).thenReturn(null);

      // Act
      final call = dataSource.signInWithGoogle;

      // Assert
      expect(() => call(), throwsA(isA<ExceptionFailure>()));
    });
  });

  group('signInWithFacebook', () {
    final mockUser = MockUser();
    final mockUserCredential = MockUserCredential();
    final mockLoginResult = MockLoginResult();
    final mockAccessToken = MockAccessToken();

    test('should sign in with Facebook and return AuthenticationResponseModel',
        () async {
      // Arrange
      when(() => mockFacebookAuth.login())
          .thenAnswer((_) async => mockLoginResult);

      when(() => mockLoginResult.status).thenReturn(LoginStatus.success);

      when(() => mockLoginResult.accessToken).thenReturn(mockAccessToken);

      when(() => mockAccessToken.tokenString).thenReturn("fake_id_token");

      when(() => mockFirebaseAuth.signInWithCredential(any()))
          .thenAnswer((_) async => mockUserCredential);

      when(() => mockUserCredential.user).thenReturn(mockUser);
      when(() => mockUser.uid).thenReturn("uid_123");
      when(() => mockUser.email).thenReturn("test@example.com");

      final fakeResponse = fixture('auth/authentication_response_model.json');
      when(() => mockHttpClient.post(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          )).thenAnswer((_) async => http.Response(fakeResponse, 200));

      // Act
      final result = await dataSource.signInWithFacebook();

      // Assert
      expect(result, isA<AuthenticationResponseModel>());
      verify(() => mockFacebookAuth.login()).called(1);
      verify(() => mockFirebaseAuth.signInWithCredential(any())).called(1);
      verify(() => mockHttpClient.post(
            Uri.parse('$kBaseUrlTest/api/auth/login'),
            headers: {'Content-Type': 'application/json'},
            body: any(named: 'body'),
          )).called(1);
    });

    test('should throw ExceptionFailure when Facebook user is null', () async {
      // Arrange
      when(() => mockFacebookAuth.login())
          .thenAnswer((_) async => mockLoginResult);
      when(() => mockLoginResult.status).thenAnswer((_) => LoginStatus.failed);

      // Act
      final call = dataSource.signInWithFacebook;

      // Assert
      expect(() => call(), throwsA(isA<ExceptionFailure>()));
    });

    test('should throw ExceptionFailure when firebase user is null', () async {
      // Arrange
      when(() => mockFacebookAuth.login())
          .thenAnswer((_) async => mockLoginResult);

      when(() => mockLoginResult.status).thenReturn(LoginStatus.success);

      when(() => mockLoginResult.accessToken).thenReturn(mockAccessToken);

      when(() => mockAccessToken.tokenString).thenReturn("fake_id_token");

      when(() => mockFirebaseAuth.signInWithCredential(any()))
          .thenAnswer((_) async => mockUserCredential);

      when(() => mockUserCredential.user).thenReturn(null);

      // Act
      final call = dataSource.signInWithFacebook;

      // Assert
      expect(() => call(), throwsA(isA<ExceptionFailure>()));
    });
  });

  group('sendPasswordResetEmail', () {
    test('should send password reset email and return unit', () async {
      // Arrange
      when(() => mockFirebaseAuth.sendPasswordResetEmail(
              email: tSendPasswordResetEmailParams.email))
          .thenAnswer((_) => Future.value(unit));

      // Act
      final result = await dataSource
          .sendPasswordResetEmail(tSendPasswordResetEmailParams);

      // Assert
      expect(result, isA<Unit>());
      verify(() => mockFirebaseAuth.sendPasswordResetEmail(
          email: tSendPasswordResetEmailParams.email)).called(1);
      verifyNoMoreInteractions(mockFirebaseAuth);
    });

    test(
        'should throw UserNotExistsFailure when FirebaseAuthException is thrown with code = user-not-found',
        () async {
      // Arrange
      when(() => mockFirebaseAuth.sendPasswordResetEmail(
              email: tSendPasswordResetEmailParams.email))
          .thenThrow(FirebaseAuthException(code: 'user-not-found'));

      // Act
      final call =
          dataSource.sendPasswordResetEmail(tSendPasswordResetEmailParams);

      // Assert
      expect(() => call, throwsA(isA<UserNotExistsFailure>()));
    });

    test(
        'should throw AuthenticationFailure when FirebaseAuthException with other code',
        () async {
      // arrange
      when(() => mockFirebaseAuth.sendPasswordResetEmail(
              email: tSendPasswordResetEmailParams.email))
          .thenThrow(FirebaseAuthException(
        code: 'invalid-email',
        message: 'Invalid email',
      ));

      // act
      final call =
          dataSource.sendPasswordResetEmail(tSendPasswordResetEmailParams);

      // assert
      expect(
          () => call,
          throwsA(isA<AuthenticationFailure>()
              .having((f) => f.failureMessage, 'message', 'Invalid email')));
    });

    test('should throw AuthenticationFailure when unknown exception occurs',
        () async {
      // arrange
      when(() => mockFirebaseAuth.sendPasswordResetEmail(
              email: tSendPasswordResetEmailParams.email))
          .thenThrow(Exception('Some random error'));

      // act
      final call =
          dataSource.sendPasswordResetEmail(tSendPasswordResetEmailParams);

      // assert
      expect(
          () => call,
          throwsA(isA<AuthenticationFailure>().having((f) => f.failureMessage,
              'message', contains('Some random error'))));
    });
  });

  group('signUpWithEmail', () {
    final mockUser = MockUser();
    final mockUserCredential = MockUserCredential();

    setUp(() {
      when(() => mockUser.uid).thenReturn('123');
      when(() => mockUser.email).thenReturn(tSignInWithEmailParams.email);
      when(() => mockUser.phoneNumber).thenReturn('+919876543210');
      when(() => mockUserCredential.user).thenReturn(mockUser);
      when(() => mockFirebaseAuth.createUserWithEmailAndPassword(
            email: tSignInWithEmailParams.email,
            password: tSignInWithEmailParams.password,
          )).thenAnswer((_) async => mockUserCredential);
    });

    test('should perform a POST request to correct URL with params', () async {
      // Arrange
      final fakeResponse = fixture('auth/authentication_response_model.json');

      when(() => mockHttpClient.post(
            Uri.parse('$kBaseUrlTest/api/auth/register'),
            headers: {'Content-Type': 'application/json'},
            body: any(named: 'body'),
          )).thenAnswer((_) async => http.Response(fakeResponse, 201));

      // Act
      final result = await dataSource.signUpWithEmail(tSignUpWithEmailParams);

      // Assert
      verify(() => mockHttpClient.post(
            Uri.parse('$kBaseUrlTest/api/auth/register'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              "email": tSignUpWithEmailParams.email,
              "id": "123",
              "name": tSignUpWithEmailParams.name,
              "phone": "+919876543210",
              "authProvider": tSignUpWithEmailParams.authProvider,
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
        () async => dataSource.signUpWithEmail(tSignUpWithEmailParams),
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
        () async => dataSource.signUpWithEmail(tSignUpWithEmailParams),
        throwsA(isA<CredentialFailure>()),
      );
    });

    test('should throw UserAlreadyExistsFailure on 404', () async {
      // Arrange
      when(() => mockHttpClient.post(
            any(),
            headers: any(named: 'headers'),
            body: any(named: 'body'),
          )).thenAnswer((_) async => http.Response('Error', 409));

      // Act & Assert
      expect(
        () async => dataSource.signUpWithEmail(tSignUpWithEmailParams),
        throwsA(isA<UserAlreadyExistsFailure>()),
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
        () async => dataSource.signUpWithEmail(tSignUpWithEmailParams),
        throwsA(isA<ServerFailure>()),
      );
    });
  });

  group('sendVerificationEmail', () {
    final mockUser = MockUser();
    test('should return unit when reload and sendEmailVerification succeed',
        () async {
      // arrange
      when(() => mockFirebaseAuth.currentUser).thenReturn(mockUser);
      when(() => mockUser.reload()).thenAnswer((_) async => Future.value());
      when(() => mockUser.sendEmailVerification())
          .thenAnswer((_) async => Future.value());

      // act
      final result = await dataSource.sendVerificationEmail();

      // assert
      expect(result, unit);
      verify(() => mockFirebaseAuth.currentUser).called(1);
      verify(() => mockUser.reload()).called(1);
      verify(() => mockUser.sendEmailVerification()).called(1);
    });

    test('should throw UserNotExistsFailure when currentUser is null',
        () async {
      // arrange
      when(() => mockFirebaseAuth.currentUser).thenReturn(null);

      // act
      final call = dataSource.sendVerificationEmail;

      // assert
      expect(() => call(), throwsA(isA<UserNotExistsFailure>()));
    });

    test(
        'should throw TooManyRequestsFailure when FirebaseAuthException with too-many-requests code',
        () async {
      // arrange
      when(() => mockFirebaseAuth.currentUser).thenReturn(mockUser);
      when(() => mockUser.reload()).thenAnswer((_) async => Future.value());
      when(() => mockUser.sendEmailVerification())
          .thenThrow(FirebaseAuthException(code: 'too-many-requests'));

      // act
      final call = dataSource.sendVerificationEmail;

      // assert
      expect(() => call(), throwsA(isA<TooManyRequestsFailure>()));
    });

    test(
        'should throw ServerFailure when FirebaseAuthException with other code',
        () async {
      // arrange
      when(() => mockFirebaseAuth.currentUser).thenReturn(mockUser);
      when(() => mockUser.reload()).thenAnswer((_) async => Future.value());
      when(() => mockUser.sendEmailVerification())
          .thenThrow(FirebaseAuthException(code: 'network-request-failed'));

      // act
      final call = dataSource.sendVerificationEmail;

      // assert
      expect(() => call(), throwsA(isA<ServerFailure>()));
    });

    test('should throw ServerFailure when unknown exception occurs', () async {
      // arrange
      when(() => mockFirebaseAuth.currentUser).thenReturn(mockUser);
      when(() => mockUser.reload()).thenAnswer((_) async => Future.value());
      when(() => mockUser.sendEmailVerification())
          .thenThrow(Exception('Random error'));

      // act
      final call = dataSource.sendVerificationEmail;

      // assert
      expect(() => call(), throwsA(isA<ServerFailure>()));
    });
  });
}
