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
        when(() => mockAuthRemoteDataSource
                .signInWithPhone(tSignInWithPhoneParams))
            .thenThrow(CredentialFailure());
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
        when(() => mockAuthRemoteDataSource
                .signInWithPhone(tSignInWithPhoneParams))
            .thenThrow(UserNotExistsFailure());
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
        when(() => mockAuthRemoteDataSource
                .signInWithPhone(tSignInWithPhoneParams))
            .thenThrow(ServerFailure());
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
  });
}
