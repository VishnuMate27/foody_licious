import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foody_licious/core/error/failures.dart';
import 'package:foody_licious/core/network/network_info.dart';
import 'package:foody_licious/data/data_sources/local/user_local_data_source.dart';
import 'package:foody_licious/data/data_sources/remote/auth_remote_data_source.dart';
import 'package:foody_licious/data/models/user/authentication_response_model.dart';
import 'package:foody_licious/data/repositories/auth_repository_impl.dart';
import 'package:mocktail/mocktail.dart';

import '../../fixtures/constant_objects.dart';

class MockAuthRemoteDataSource extends Mock implements AuthRemoteDataSource {}

class MockUserLocalDataSource extends Mock implements UserLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late AuthRepositoryImpl repository;
  late MockAuthRemoteDataSource mockAuthRemoteDataSource;
  late MockUserLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUpAll(() {
    mockAuthRemoteDataSource = MockAuthRemoteDataSource();
    mockLocalDataSource = MockUserLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = AuthRepositoryImpl(
      networkInfo: mockNetworkInfo,
      remoteDataSource: mockAuthRemoteDataSource,
      localDataSource: mockLocalDataSource,
    );
  });

  void runTestsOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      body();
    });
  }

  void runTestsOffline(Function body) {
    group('device is offline', () {
      setUp(() {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      body();
    });
  }

  runTestsOnline(() {
    group('signInWithEmail', () {
      test(
          'Should return Right(User) when remoteDataSource.signInWithEmail succecced',
          () async {
        // arrange
        when(() => mockAuthRemoteDataSource
                .signInWithEmail(tSignInWithEmailParams))
            .thenAnswer((_) async => tAuthenticationResponseModel);
        when(() =>
                mockLocalDataSource.saveUser(tAuthenticationResponseModel.user))
            .thenAnswer((_) async {});

        // act
        final result = await repository.signInWithEmail(tSignInWithEmailParams);

        // assert
        verify(() => mockAuthRemoteDataSource
            .signInWithEmail(tSignInWithEmailParams)).called(1);
        verify(() =>
                mockLocalDataSource.saveUser(tAuthenticationResponseModel.user))
            .called(1);
        expect(result, Right(tUserModel));
      });

      test(
          'Should return Left(Failure) when remoteDataSource.signInWithEmail throws UserNotExistsFailure',
          () async {
        // arrange
        when(() => mockAuthRemoteDataSource.signInWithEmail(
            tSignInWithEmailParams)).thenThrow(UserNotExistsFailure());
        when(() =>
                mockLocalDataSource.saveUser(tAuthenticationResponseModel.user))
            .thenAnswer((_) async {});

        // act
        final result = await repository.signInWithEmail(tSignInWithEmailParams);

        // assert
        verify(() => mockAuthRemoteDataSource
            .signInWithEmail(tSignInWithEmailParams)).called(1);
        expect(result, Left(UserNotExistsFailure()));
      });

      test(
          'Should return Left(Failure) when remoteDataSource.signInWithEmail throws CredentialFailure',
          () async {
        // arrange
        when(() => mockAuthRemoteDataSource.signInWithEmail(
            tSignInWithEmailParams)).thenThrow(CredentialFailure());
        when(() =>
                mockLocalDataSource.saveUser(tAuthenticationResponseModel.user))
            .thenAnswer((_) async {});

        // act
        final result = await repository.signInWithEmail(tSignInWithEmailParams);

        // assert
        verify(() => mockAuthRemoteDataSource
            .signInWithEmail(tSignInWithEmailParams)).called(1);
        expect(result, Left(CredentialFailure()));
      });

      test(
          'Should return Left(Failure) when remoteDataSource.signInWithEmail throws AuthenticationFailure',
          () async {
        // arrange
        when(() => mockAuthRemoteDataSource
                .signInWithEmail(tSignInWithEmailParams))
            .thenThrow(AuthenticationFailure(
                "Failure Message")); //.thenThrow(AuthenticationFailure());
        when(() =>
                mockLocalDataSource.saveUser(tAuthenticationResponseModel.user))
            .thenAnswer((_) async {});

        // act
        final result = await repository.signInWithEmail(tSignInWithEmailParams);

        // assert
        verify(() => mockAuthRemoteDataSource
            .signInWithEmail(tSignInWithEmailParams)).called(1);
        expect(result, Left(AuthenticationFailure("Failure Message")));
      });

      test(
          'Should return Left(Failure) when remoteDataSource.signInWithEmail throws AuthProviderMissMatchFailure',
          () async {
        // arrange
        when(() => mockAuthRemoteDataSource.signInWithEmail(
            tSignInWithEmailParams)).thenThrow(AuthProviderMissMatchFailure());
        when(() =>
                mockLocalDataSource.saveUser(tAuthenticationResponseModel.user))
            .thenAnswer((_) async {});

        // act
        final result = await repository.signInWithEmail(tSignInWithEmailParams);

        // assert
        verify(() => mockAuthRemoteDataSource
            .signInWithEmail(tSignInWithEmailParams)).called(1);
        expect(result, Left(AuthProviderMissMatchFailure()));
      });

      test(
          'Should return Left(Failure) when remoteDataSource.signInWithEmail throws ServerFailure',
          () async {
        // arrange
        when(() => mockAuthRemoteDataSource
                .signInWithEmail(tSignInWithEmailParams))
            .thenThrow(ServerFailure()); //.thenThrow(AuthenticationFailure());
        when(() =>
                mockLocalDataSource.saveUser(tAuthenticationResponseModel.user))
            .thenAnswer((_) async {});

        // act
        final result = await repository.signInWithEmail(tSignInWithEmailParams);

        // assert
        verify(() => mockAuthRemoteDataSource
            .signInWithEmail(tSignInWithEmailParams)).called(1);
        expect(result, Left(ServerFailure()));
      });

      test(
          'Should return Left(Failure) when remoteDataSource.signInWithEmail throws AuthenticationFailure',
          () async {
        // arrange
        when(() => mockAuthRemoteDataSource
                .signInWithEmail(tSignInWithEmailParams))
            .thenThrow(AuthenticationFailure(
                "Failure Message")); //.thenThrow(AuthenticationFailure());
        when(() =>
                mockLocalDataSource.saveUser(tAuthenticationResponseModel.user))
            .thenAnswer((_) async {});

        // act
        final result = await repository.signInWithEmail(tSignInWithEmailParams);

        // assert
        verify(() => mockAuthRemoteDataSource
            .signInWithEmail(tSignInWithEmailParams)).called(1);
        expect(result, Left(AuthenticationFailure("Failure Message")));
      });
    });

    group('verifyPhoneNumberForLogin', () {
      test(
          'Should return Right(Unit) when remoteDataSource.verifyPhoneNumberForLogin succecced',
          () async {
        // arrange
        when(() => mockAuthRemoteDataSource.verifyPhoneNumberForLogin(
            tSignInWithPhoneParams)).thenAnswer((_) async => unit);

        // act
        final result =
            await repository.verifyPhoneNumberForLogin(tSignInWithPhoneParams);

        // assert
        verify(() => mockAuthRemoteDataSource
            .verifyPhoneNumberForLogin(tSignInWithPhoneParams)).called(1);
        expect(result, Right(unit));
      });

      test(
          'Should return Left(Failure) when remoteDataSource.verifyPhoneNumberForLogin throws CredentialFailure',
          () async {
        // arrange
        when(() => mockAuthRemoteDataSource.verifyPhoneNumberForLogin(
            tSignInWithPhoneParams)).thenThrow(CredentialFailure());

        // act
        final result =
            await repository.verifyPhoneNumberForLogin(tSignInWithPhoneParams);

        // assert
        verify(() => mockAuthRemoteDataSource
            .verifyPhoneNumberForLogin(tSignInWithPhoneParams)).called(1);
        expect(result, Left(CredentialFailure()));
      });

      test(
          'Should return Left(Failure) when remoteDataSource.verifyPhoneNumberForLogin throws UserNotExistsFailure',
          () async {
        // arrange
        when(() => mockAuthRemoteDataSource.verifyPhoneNumberForLogin(
            tSignInWithPhoneParams)).thenThrow(UserNotExistsFailure());

        // act
        final result =
            await repository.verifyPhoneNumberForLogin(tSignInWithPhoneParams);

        // assert
        verify(() => mockAuthRemoteDataSource
            .verifyPhoneNumberForLogin(tSignInWithPhoneParams)).called(1);
        expect(result, Left(UserNotExistsFailure()));
      });

      test(
          'Should return Left(Failure) when remoteDataSource.verifyPhoneNumberForLogin throws ServerFailure',
          () async {
        // arrange
        when(() => mockAuthRemoteDataSource.verifyPhoneNumberForLogin(
            tSignInWithPhoneParams)).thenThrow(ServerFailure());

        // act
        final result =
            await repository.verifyPhoneNumberForLogin(tSignInWithPhoneParams);

        // assert
        verify(() => mockAuthRemoteDataSource
            .verifyPhoneNumberForLogin(tSignInWithPhoneParams)).called(1);
        expect(result, Left(ServerFailure()));
      });
    });

    group('signInWithPhone', () {
      test(
          'Should return Right(Unit) when remoteDataSource.signInWithPhone succecced',
          () async {
        // arrange
        when(() => mockAuthRemoteDataSource
                .signInWithPhone(tSignInWithPhoneParams))
            .thenAnswer((_) async => tAuthenticationResponseModel);
        when(() => mockLocalDataSource.saveUser(tUserModel))
            .thenAnswer((_) async {});

        // act
        final result = await repository.signInWithPhone(tSignInWithPhoneParams);

        // assert
        verify(() => mockAuthRemoteDataSource
            .signInWithPhone(tSignInWithPhoneParams)).called(1);
        expect(result, Right(tAuthenticationResponseModel.user));
      });

      test(
          'Should return Left(Failure) when remoteDataSource.signInWithPhone throws CredentialFailure',
          () async {
        // arrange
        when(() => mockAuthRemoteDataSource.signInWithPhone(
            tSignInWithPhoneParams)).thenThrow(CredentialFailure());
        when(() => mockLocalDataSource.saveUser(tUserModel))
            .thenAnswer((_) async {});

        // act
        final result = await repository.signInWithPhone(tSignInWithPhoneParams);

        // assert
        verify(() => mockAuthRemoteDataSource
            .signInWithPhone(tSignInWithPhoneParams)).called(1);
        expect(result, Left(CredentialFailure()));
      });

      test(
          'Should return Left(Failure) when remoteDataSource.signInWithPhone throws UserNotExistsFailure',
          () async {
        // arrange
        when(() => mockAuthRemoteDataSource.signInWithPhone(
            tSignInWithPhoneParams)).thenThrow(UserNotExistsFailure());
        when(() => mockLocalDataSource.saveUser(tUserModel))
            .thenAnswer((_) async {});

        // act
        final result = await repository.signInWithPhone(tSignInWithPhoneParams);

        // assert
        verify(() => mockAuthRemoteDataSource
            .signInWithPhone(tSignInWithPhoneParams)).called(1);
        expect(result, Left(UserNotExistsFailure()));
      });
      test(
          'Should return Left(Failure) when remoteDataSource.signInWithPhone throws ServerFailure',
          () async {
        // arrange
        when(() => mockAuthRemoteDataSource.signInWithPhone(
            tSignInWithPhoneParams)).thenThrow(ServerFailure());
        when(() => mockLocalDataSource.saveUser(tUserModel))
            .thenAnswer((_) async {});

        // act
        final result = await repository.signInWithPhone(tSignInWithPhoneParams);

        // assert
        verify(() => mockAuthRemoteDataSource
            .signInWithPhone(tSignInWithPhoneParams)).called(1);
        expect(result, Left(ServerFailure()));
      });
    });
    group('signInWithGoogle', () {
      test(
          'Should return Right(User) when remoteDataSource.signInWithGoogle succecced',
          () async {
        // arrange
        when(() => mockAuthRemoteDataSource.signInWithGoogle())
            .thenAnswer((_) async => tAuthenticationResponseModel);
        when(() => mockLocalDataSource.saveUser(tUserModel))
            .thenAnswer((_) async {});

        // act
        final result = await repository.signInWithGoogle();

        // assert
        verify(() => mockAuthRemoteDataSource.signInWithGoogle()).called(1);
        expect(result, Right(tAuthenticationResponseModel.user));
      });

      test(
          'Should return Left(Failure) when remoteDataSource.signInWithGoogle throws CredentialFailure',
          () async {
        // arrange
        when(() => mockAuthRemoteDataSource.signInWithGoogle())
            .thenThrow(CredentialFailure());
        when(() => mockLocalDataSource.saveUser(tUserModel))
            .thenAnswer((_) async {});

        // act
        final result = await repository.signInWithGoogle();

        // assert
        verify(() => mockAuthRemoteDataSource.signInWithGoogle()).called(1);
        expect(result, Left(CredentialFailure()));
      });

      test(
          'Should return Left(Failure) when remoteDataSource.signInWithGoogle throws UserNotExistsFailure',
          () async {
        // arrange
        when(() => mockAuthRemoteDataSource.signInWithGoogle())
            .thenThrow(UserNotExistsFailure());
        when(() => mockLocalDataSource.saveUser(tUserModel))
            .thenAnswer((_) async {});

        // act
        final result = await repository.signInWithGoogle();

        // assert
        verify(() => mockAuthRemoteDataSource.signInWithGoogle()).called(1);
        expect(result, Left(UserNotExistsFailure()));
      });
      test(
          'Should return Left(Failure) when remoteDataSource.signInWithGoogle throws ServerFailure',
          () async {
        // arrange
        when(() => mockAuthRemoteDataSource.signInWithGoogle())
            .thenThrow(ServerFailure());
        when(() => mockLocalDataSource.saveUser(tUserModel))
            .thenAnswer((_) async {});

        // act
        final result = await repository.signInWithGoogle();

        // assert
        verify(() => mockAuthRemoteDataSource.signInWithGoogle()).called(1);
        expect(result, Left(ServerFailure()));
      });
    });
    group('signInWithFacebook', () {
      test(
          'Should return Right(User) when remoteDataSource.signInWithFacebook succecced',
          () async {
        // arrange
        when(() => mockAuthRemoteDataSource.signInWithFacebook())
            .thenAnswer((_) async => tAuthenticationResponseModel);
        when(() => mockLocalDataSource.saveUser(tUserModel))
            .thenAnswer((_) async {});

        // act
        final result = await repository.signInWithFacebook();

        // assert
        verify(() => mockAuthRemoteDataSource.signInWithFacebook()).called(1);
        expect(result, Right(tAuthenticationResponseModel.user));
      });

      test(
          'Should return Left(Failure) when remoteDataSource.signInWithFacebook throws CredentialFailure',
          () async {
        // arrange
        when(() => mockAuthRemoteDataSource.signInWithGoogle())
            .thenThrow(CredentialFailure());
        when(() => mockLocalDataSource.saveUser(tUserModel))
            .thenAnswer((_) async {});

        // act
        final result = await repository.signInWithGoogle();

        // assert
        verify(() => mockAuthRemoteDataSource.signInWithGoogle()).called(1);
        expect(result, Left(CredentialFailure()));
      });

      test(
          'Should return Left(Failure) when remoteDataSource.signInWithGoogle throws UserNotExistsFailure',
          () async {
        // arrange
        when(() => mockAuthRemoteDataSource.signInWithGoogle())
            .thenThrow(UserNotExistsFailure());
        when(() => mockLocalDataSource.saveUser(tUserModel))
            .thenAnswer((_) async {});

        // act
        final result = await repository.signInWithGoogle();

        // assert
        verify(() => mockAuthRemoteDataSource.signInWithGoogle()).called(1);
        expect(result, Left(UserNotExistsFailure()));
      });
      test(
          'Should return Left(Failure) when remoteDataSource.signInWithGoogle throws ServerFailure',
          () async {
        // arrange
        when(() => mockAuthRemoteDataSource.signInWithGoogle())
            .thenThrow(ServerFailure());
        when(() => mockLocalDataSource.saveUser(tUserModel))
            .thenAnswer((_) async {});

        // act
        final result = await repository.signInWithGoogle();

        // assert
        verify(() => mockAuthRemoteDataSource.signInWithGoogle()).called(1);
        expect(result, Left(ServerFailure()));
      });
    });

    group('sendPasswordResetEmail', () {
      test(
          'Should return Right(Unit) when remoteDataSource.sendPasswordResetEmail succecced',
          () async {
        // Arrange
        when(() => mockAuthRemoteDataSource.sendPasswordResetEmail(
            tSendPasswordResetEmailParams)).thenAnswer((_) async => unit);

        // Act
        final result = await repository
            .sendPasswordResetEmail(tSendPasswordResetEmailParams);

        // Assert
        verify(() => mockAuthRemoteDataSource
            .sendPasswordResetEmail(tSendPasswordResetEmailParams)).called(1);
        expect(result, Right(unit));
      });

      test(
          'Should return Left(Failure) when remoteDataSource.sendPasswordResetEmail throws UserNotExistsFailure',
          () async {
        // Arrange
        when(() => mockAuthRemoteDataSource.sendPasswordResetEmail(
            tSendPasswordResetEmailParams)).thenThrow(UserNotExistsFailure());

        // Act
        final result = await repository
            .sendPasswordResetEmail(tSendPasswordResetEmailParams);

        // Assert
        verify(() => mockAuthRemoteDataSource
            .sendPasswordResetEmail(tSendPasswordResetEmailParams)).called(1);
        expect(result, Left(UserNotExistsFailure()));
      });

      test(
          'Should return Left(Failure) when remoteDataSource.sendPasswordResetEmail throws AuthenticationFailure',
          () async {
        // Arrange
        when(() => mockAuthRemoteDataSource
                .sendPasswordResetEmail(tSendPasswordResetEmailParams))
            .thenThrow(AuthenticationFailure("Failure Message"));

        // Act
        final result = await repository
            .sendPasswordResetEmail(tSendPasswordResetEmailParams);

        // Assert
        verify(() => mockAuthRemoteDataSource
            .sendPasswordResetEmail(tSendPasswordResetEmailParams)).called(1);
        expect(result, Left(AuthenticationFailure("Failure Message")));
      });
    });

    group('signUpWithEmail', () {
      test(
          'should return Right(User) when remoteDataSource.signUpWithEmail successed',
          () async {
        // Arrange
        when(() => mockAuthRemoteDataSource
                .signUpWithEmail(tSignUpWithEmailParams))
            .thenAnswer((_) async => tAuthenticationResponseModel);
        when(() =>
                mockLocalDataSource.saveUser(tAuthenticationResponseModel.user))
            .thenAnswer((_) async => tAuthenticationResponseModel.user);

        // Act
        final result = await repository.signUpWithEmail(tSignUpWithEmailParams);

        // Assert
        expect(result, Right(tUserModel));
        verify(() => mockAuthRemoteDataSource
            .signUpWithEmail(tSignUpWithEmailParams)).called(1);
        verify(() =>
            mockLocalDataSource.saveUser(tAuthenticationResponseModel.user));
      });

      test(
          'should return Left(Failure) when remoteDataSource.signUpWithEmail throws CredentialFailure',
          () async {
        // Arrange
        when(() => mockAuthRemoteDataSource.signUpWithEmail(
            tSignUpWithEmailParams)).thenThrow(CredentialFailure());
        when(() =>
                mockLocalDataSource.saveUser(tAuthenticationResponseModel.user))
            .thenAnswer((_) async => tAuthenticationResponseModel.user);

        // Act
        final result = await repository.signUpWithEmail(tSignUpWithEmailParams);

        // Assert
        verify(() => mockAuthRemoteDataSource
            .signUpWithEmail(tSignUpWithEmailParams)).called(1);
        verifyNever(() =>
            mockLocalDataSource.saveUser(tAuthenticationResponseModel.user));
        expect(result, Left(CredentialFailure()));
      });

      test(
          'should return Left(Failure) when remoteDataSource.signUpWithEmail throws UserAlreadyExistsFailure',
          () async {
        // Arrange
        when(() => mockAuthRemoteDataSource.signUpWithEmail(
            tSignUpWithEmailParams)).thenThrow(UserAlreadyExistsFailure());
        when(() =>
                mockLocalDataSource.saveUser(tAuthenticationResponseModel.user))
            .thenAnswer((_) async => tAuthenticationResponseModel.user);

        // Act
        final result = await repository.signUpWithEmail(tSignUpWithEmailParams);

        // Assert
        expect(result, Left(UserAlreadyExistsFailure()));
        verify(() => mockAuthRemoteDataSource
            .signUpWithEmail(tSignUpWithEmailParams)).called(1);
        verifyNever(() =>
            mockLocalDataSource.saveUser(tAuthenticationResponseModel.user));
      });
    });

    group('sendVerificationEmail', () {
      test(
          'should return Right(Unit) when remoteDataSource.sendVerificationEmail sucessed',
          () async {
        // Arrange
        when(() => mockAuthRemoteDataSource.sendVerificationEmail())
            .thenAnswer((_) async => unit);

        // Act
        final result = await repository.sendVerificationEmail();

        // Assert
        expect(result, Right(unit));
        verify(() => mockAuthRemoteDataSource.sendVerificationEmail())
            .called(1);
      });

      test(
          'should return Left(Failure) when remoteDataSource.sendVerificationEmail throws TooManyRequestsFailure',
          () async {
        // Arrange
        when(() => mockAuthRemoteDataSource.sendVerificationEmail())
            .thenThrow(TooManyRequestsFailure());

        // Act
        final result = await repository.sendVerificationEmail();

        // Assert
        expect(result, Left(TooManyRequestsFailure()));
        verify(() => mockAuthRemoteDataSource.sendVerificationEmail())
            .called(1);
      });

      test(
          'should return Left(Failure) when remoteDataSource.sendVerificationEmail throws UserNotExistsFailure',
          () async {
        // Arrange
        when(() => mockAuthRemoteDataSource.sendVerificationEmail())
            .thenThrow(UserNotExistsFailure());

        // Act
        final result = await repository.sendVerificationEmail();

        // Assert
        expect(result, Left(UserNotExistsFailure()));
        verify(() => mockAuthRemoteDataSource.sendVerificationEmail())
            .called(1);
      });

      test(
          'should return Left(Failure) when remoteDataSource.sendVerificationEmail throws ServerFailure',
          () async {
        // Arrange
        when(() => mockAuthRemoteDataSource.sendVerificationEmail())
            .thenThrow(ServerFailure());

        // Act
        final result = await repository.sendVerificationEmail();

        // Assert
        expect(result, Left(ServerFailure()));
        verify(() => mockAuthRemoteDataSource.sendVerificationEmail())
            .called(1);
      });
    });

    group('waitForEmailVerification', () {
      test(
          'should return Right(Unit) when remoteDataSource.waitForEmailVerification sucessed',
          () async {
        // Arrange
        when(() => mockAuthRemoteDataSource.waitForEmailVerification())
            .thenAnswer((_) async => unit);

        // Act
        final result = await repository.waitForEmailVerification();

        // Assert
        expect(result, Right(unit));
        verify(() => mockAuthRemoteDataSource.waitForEmailVerification())
            .called(1);
      });

      test(
          'should return Left(Failure) when remoteDataSource.waitForEmailVerification throws TimeOutFailure',
          () async {
        // Arrange
        when(() => mockAuthRemoteDataSource.waitForEmailVerification())
            .thenThrow(TimeOutFailure());

        // Act
        final result = await repository.waitForEmailVerification();

        // Assert
        expect(result, Left(TimeOutFailure()));
        verify(() => mockAuthRemoteDataSource.waitForEmailVerification())
            .called(1);
      });

      test(
          'should return Left(Failure) when remoteDataSource.waitForEmailVerification throws UserNotExistsFailure',
          () async {
        // Arrange
        when(() => mockAuthRemoteDataSource.waitForEmailVerification())
            .thenThrow(UserNotExistsFailure());

        // Act
        final result = await repository.waitForEmailVerification();

        // Assert
        expect(result, Left(UserNotExistsFailure()));
        verify(() => mockAuthRemoteDataSource.waitForEmailVerification())
            .called(1);
      });
    });

    group('verifyPhoneNumberForRegistration', () {
      test(
          'should return Right(Unit) when remoteDataSource.verifyPhoneNumberForRegistration sucessed',
          () async {
        // Arrange
        when(() => mockAuthRemoteDataSource.verifyPhoneNumberForRegistration(
            tSignUpWithPhoneParams)).thenAnswer((_) async => unit);

        // Act
        final result = await repository
            .verifyPhoneNumberForRegistration(tSignUpWithPhoneParams);

        // Assert
        expect(result, Right(unit));
        verify(() => mockAuthRemoteDataSource.verifyPhoneNumberForRegistration(
            tSignUpWithPhoneParams)).called(1);
      });

      test(
          'should return Left(Failure) when remoteDataSource.verifyPhoneNumberForRegistration throws CredentialFailure',
          () async {
        // Arrange
        when(() => mockAuthRemoteDataSource.verifyPhoneNumberForRegistration(
            tSignUpWithPhoneParams)).thenThrow(CredentialFailure());

        // Act
        final result = await repository
            .verifyPhoneNumberForRegistration(tSignUpWithPhoneParams);

        // Assert
        expect(result, Left(CredentialFailure()));
        verify(() => mockAuthRemoteDataSource.verifyPhoneNumberForRegistration(
            tSignUpWithPhoneParams)).called(1);
      });

      test(
          'should return Left(Failure) when remoteDataSource.verifyPhoneNumberForRegistration throws UserAlreadyExistsFailure',
          () async {
        // Arrange
        when(() => mockAuthRemoteDataSource.verifyPhoneNumberForRegistration(
            tSignUpWithPhoneParams)).thenThrow(UserAlreadyExistsFailure());

        // Act
        final result = await repository
            .verifyPhoneNumberForRegistration(tSignUpWithPhoneParams);

        // Assert
        expect(result, Left(UserAlreadyExistsFailure()));
        verify(() => mockAuthRemoteDataSource.verifyPhoneNumberForRegistration(
            tSignUpWithPhoneParams)).called(1);
      });

      test(
          'should return Left(Failure) when remoteDataSource.verifyPhoneNumberForRegistration throws ServerFailure',
          () async {
        // Arrange
        when(() => mockAuthRemoteDataSource.verifyPhoneNumberForRegistration(
            tSignUpWithPhoneParams)).thenThrow(ServerFailure());

        // Act
        final result = await repository
            .verifyPhoneNumberForRegistration(tSignUpWithPhoneParams);

        // Assert
        expect(result, Left(ServerFailure()));
        verify(() => mockAuthRemoteDataSource.verifyPhoneNumberForRegistration(
            tSignUpWithPhoneParams)).called(1);
      });
    });

    group('signUpWithPhone', () {
      test(
          'Should return Right(User) when remoteDataSource.signUpWithPhone successed',
          () async {
        // Arrange
        when(() => mockAuthRemoteDataSource
                .signUpWithPhone(tSignUpWithPhoneParams))
            .thenAnswer((_) async => tAuthenticationResponseModel);
        when(() =>
                mockLocalDataSource.saveUser(tAuthenticationResponseModel.user))
            .thenAnswer((_) async {});

        // Act
        final result = await repository.signUpWithPhone(tSignUpWithPhoneParams);

        // Assert
        expect(result, Right(tUserModel));
        verify(() => mockAuthRemoteDataSource
            .signUpWithPhone(tSignUpWithPhoneParams)).called(1);
        verify(() =>
                mockLocalDataSource.saveUser(tAuthenticationResponseModel.user))
            .called(1);
      });

      test(
          'Should return Left(Failure) when remoteDataSource.signUpWithPhone throws CredentialFailure',
          () async {
        // Arrange
        when(() => mockAuthRemoteDataSource.signUpWithPhone(
            tSignUpWithPhoneParams)).thenThrow(CredentialFailure());
        when(() =>
                mockLocalDataSource.saveUser(tAuthenticationResponseModel.user))
            .thenAnswer((_) async {});

        // Act
        final result = await repository.signUpWithPhone(tSignUpWithPhoneParams);

        // Assert
        expect(result, Left(CredentialFailure()));
        verify(() => mockAuthRemoteDataSource
            .signUpWithPhone(tSignUpWithPhoneParams)).called(1);
        verifyNever(() =>
            mockLocalDataSource.saveUser(tAuthenticationResponseModel.user));
      });

      test(
          'Should return Left(Failure) when remoteDataSource.signUpWithPhone throws UserAlreadyExistsFailure',
          () async {
        // Arrange
        when(() => mockAuthRemoteDataSource.signUpWithPhone(
            tSignUpWithPhoneParams)).thenThrow(UserAlreadyExistsFailure());
        when(() =>
                mockLocalDataSource.saveUser(tAuthenticationResponseModel.user))
            .thenAnswer((_) async {});

        // Act
        final result = await repository.signUpWithPhone(tSignUpWithPhoneParams);

        // Assert
        expect(result, Left(UserAlreadyExistsFailure()));
        verify(() => mockAuthRemoteDataSource
            .signUpWithPhone(tSignUpWithPhoneParams)).called(1);
        verifyNever(() =>
            mockLocalDataSource.saveUser(tAuthenticationResponseModel.user));
      });

      test(
          'Should return Left(Failure) when remoteDataSource.signUpWithPhone throws ServerFailure',
          () async {
        // Arrange
        when(() => mockAuthRemoteDataSource.signUpWithPhone(
            tSignUpWithPhoneParams)).thenThrow(ServerFailure());
        when(() =>
                mockLocalDataSource.saveUser(tAuthenticationResponseModel.user))
            .thenAnswer((_) async {});

        // Act
        final result = await repository.signUpWithPhone(tSignUpWithPhoneParams);

        // Assert
        expect(result, Left(ServerFailure()));
        verify(() => mockAuthRemoteDataSource
            .signUpWithPhone(tSignUpWithPhoneParams)).called(1);
        verifyNever(() =>
            mockLocalDataSource.saveUser(tAuthenticationResponseModel.user));
      });
    });

    group('signUpWithGoogle', () {
      test(
          'Should return Right(User) when remoteDataSource.signUpWithGoogle successed',
          () async {
        // Arrange
        when(() => mockAuthRemoteDataSource.signUpWithGoogle())
            .thenAnswer((_) async => tAuthenticationResponseModel);
        when(() =>
                mockLocalDataSource.saveUser(tAuthenticationResponseModel.user))
            .thenAnswer((_) async {});

        // Act
        final result = await repository.signUpWithGoogle();

        // Assert
        expect(result, Right(tUserModel));
        verify(() => mockAuthRemoteDataSource.signUpWithGoogle()).called(1);
        verify(() =>
                mockLocalDataSource.saveUser(tAuthenticationResponseModel.user))
            .called(1);
      });

      test(
          'Should return Left(Failure) when remoteDataSource.signUpWithGoogle throws ExceptionFailure',
          () async {
        // Arrange
        when(() => mockAuthRemoteDataSource.signUpWithGoogle())
            .thenThrow(ExceptionFailure("Failure message"));
        when(() =>
                mockLocalDataSource.saveUser(tAuthenticationResponseModel.user))
            .thenAnswer((_) async {});

        // Act
        final result = await repository.signUpWithGoogle();

        // Assert
        expect(result, Left(ExceptionFailure("Failure Message")));
        verify(() => mockAuthRemoteDataSource.signUpWithGoogle()).called(1);
        verifyNever(() =>
            mockLocalDataSource.saveUser(tAuthenticationResponseModel.user));
      });

      test(
          'Should return Left(Failure) when remoteDataSource.signUpWithGoogle throws CredentialFailure',
          () async {
        // Arrange
        when(() => mockAuthRemoteDataSource.signUpWithGoogle())
            .thenThrow(CredentialFailure());
        when(() =>
                mockLocalDataSource.saveUser(tAuthenticationResponseModel.user))
            .thenAnswer((_) async {});

        // Act
        final result = await repository.signUpWithGoogle();

        // Assert
        expect(result, Left(CredentialFailure()));
        verify(() => mockAuthRemoteDataSource.signUpWithGoogle()).called(1);
        verifyNever(() =>
            mockLocalDataSource.saveUser(tAuthenticationResponseModel.user));
      });

      test(
          'Should return Left(Failure) when remoteDataSource.signUpWithGoogle throws UserAlreadyExistsFailure',
          () async {
        // Arrange
        when(() => mockAuthRemoteDataSource.signUpWithGoogle())
            .thenThrow(UserAlreadyExistsFailure());
        when(() =>
                mockLocalDataSource.saveUser(tAuthenticationResponseModel.user))
            .thenAnswer((_) async {});

        // Act
        final result = await repository.signUpWithGoogle();

        // Assert
        expect(result, Left(UserAlreadyExistsFailure()));
        verify(() => mockAuthRemoteDataSource.signUpWithGoogle()).called(1);
        verifyNever(() =>
            mockLocalDataSource.saveUser(tAuthenticationResponseModel.user));
      });

      test(
          'Should return Left(Failure) when remoteDataSource.signUpWithGoogle throws ServerFailure',
          () async {
        // Arrange
        when(() => mockAuthRemoteDataSource.signUpWithGoogle())
            .thenThrow(ServerFailure());
        when(() =>
                mockLocalDataSource.saveUser(tAuthenticationResponseModel.user))
            .thenAnswer((_) async {});

        // Act
        final result = await repository.signUpWithGoogle();

        // Assert
        expect(result, Left(ServerFailure()));
        verify(() => mockAuthRemoteDataSource.signUpWithGoogle()).called(1);
        verifyNever(() =>
            mockLocalDataSource.saveUser(tAuthenticationResponseModel.user));
      });
    });

    group('signUpWithFacebook', () {
      test(
          'Should Return Right(User) when remoteDataSource.signUpWithFacebook sucessed',
          () async {
        // Arrange
        when(() => mockAuthRemoteDataSource.signUpWithFacebook())
            .thenAnswer((_) async => tAuthenticationResponseModel);
        when(() =>
                mockLocalDataSource.saveUser(tAuthenticationResponseModel.user))
            .thenAnswer((_) async {});

        // Act
        final result = await repository.signUpWithFacebook();

        expect(result, Right(tUserModel));
        verify(() => mockAuthRemoteDataSource.signUpWithFacebook()).called(1);
        verify(() =>
                mockLocalDataSource.saveUser(tAuthenticationResponseModel.user))
            .called(1);
      });

      test(
          'Should Return Left(Failure) when remoteDataSource.signUpWithFacebook throws ExceptionFailure',
          () async {
        // Arrange
        when(() => mockAuthRemoteDataSource.signUpWithFacebook())
            .thenThrow(ExceptionFailure("Failure Message"));
        when(() =>
                mockLocalDataSource.saveUser(tAuthenticationResponseModel.user))
            .thenAnswer((_) async {});

        // Act
        final result = await repository.signUpWithFacebook();

        expect(result, Left(ExceptionFailure("Failure Message")));
        verify(() => mockAuthRemoteDataSource.signUpWithFacebook()).called(1);
        verifyNever(() =>
            mockLocalDataSource.saveUser(tAuthenticationResponseModel.user));
      });

      test(
          'Should Return Left(Failure) when remoteDataSource.signUpWithFacebook throws CredentialFailure',
          () async {
        // Arrange
        when(() => mockAuthRemoteDataSource.signUpWithFacebook())
            .thenThrow(CredentialFailure());
        when(() =>
                mockLocalDataSource.saveUser(tAuthenticationResponseModel.user))
            .thenAnswer((_) async {});

        // Act
        final result = await repository.signUpWithFacebook();

        expect(result, Left(CredentialFailure()));
        verify(() => mockAuthRemoteDataSource.signUpWithFacebook()).called(1);
        verifyNever(() =>
            mockLocalDataSource.saveUser(tAuthenticationResponseModel.user));
      });

      test(
          'Should Return Left(Failure) when remoteDataSource.signUpWithFacebook throws UserAlreadyExistsFailure',
          () async {
        // Arrange
        when(() => mockAuthRemoteDataSource.signUpWithFacebook())
            .thenThrow(UserAlreadyExistsFailure());
        when(() =>
                mockLocalDataSource.saveUser(tAuthenticationResponseModel.user))
            .thenAnswer((_) async {});

        // Act
        final result = await repository.signUpWithFacebook();

        expect(result, Left(UserAlreadyExistsFailure()));
        verify(() => mockAuthRemoteDataSource.signUpWithFacebook()).called(1);
        verifyNever(() =>
            mockLocalDataSource.saveUser(tAuthenticationResponseModel.user));
      });

      test(
          'Should Return Left(Failure) when remoteDataSource.signUpWithFacebook throws ServerFailure',
          () async {
        // Arrange
        when(() => mockAuthRemoteDataSource.signUpWithFacebook())
            .thenThrow(ServerFailure());
        when(() =>
                mockLocalDataSource.saveUser(tAuthenticationResponseModel.user))
            .thenAnswer((_) async {});

        // Act
        final result = await repository.signUpWithFacebook();

        expect(result, Left(ServerFailure()));
        verify(() => mockAuthRemoteDataSource.signUpWithFacebook()).called(1);
        verifyNever(() =>
            mockLocalDataSource.saveUser(tAuthenticationResponseModel.user));
      });
    });
  });
}
