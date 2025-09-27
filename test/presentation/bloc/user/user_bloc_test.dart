import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:foody_licious/core/error/exceptions.dart';
import 'package:foody_licious/core/error/failures.dart';
import 'package:foody_licious/core/usecase/usecase.dart';
import 'package:foody_licious/domain/usecase/user/check_user_usecase.dart';
import 'package:foody_licious/domain/usecase/user/delete_user_usecase.dart';
import 'package:foody_licious/domain/usecase/user/update_user_location_usecase.dart';
import 'package:foody_licious/domain/usecase/user/update_user_usecase.dart';
import 'package:foody_licious/presentation/bloc/user/user_bloc.dart';
import 'package:foody_licious/presentation/bloc/user/user_event.dart';
import 'package:foody_licious/presentation/bloc/user/user_state.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../fixtures/constant_objects.dart';

class MockCheckUserUseCase extends Mock implements CheckUserUseCase {}

class MockUpdateUserLocationUseCase extends Mock
    implements UpdateUserLocationUseCase {}

class MockUpdateUserUseCase extends Mock implements UpdateUserUseCase {}

class MockDeleteUserUseCase extends Mock implements DeleteUserUseCase {}

void main() {
  group('UserBloc', () {
    late UserBloc userBloc;
    late MockCheckUserUseCase mockCheckUserUseCase;
    late MockUpdateUserLocationUseCase mockUpdateUserLocationUseCase;
    late MockUpdateUserUseCase mockUpdateUserUseCase;
    late MockDeleteUserUseCase mockDeleteUserUseCase;
    setUp(() {
      mockCheckUserUseCase = MockCheckUserUseCase();
      mockUpdateUserLocationUseCase = MockUpdateUserLocationUseCase();
      mockUpdateUserUseCase = MockUpdateUserUseCase();
      mockDeleteUserUseCase = MockDeleteUserUseCase();
      registerFallbackValue(NoParams());

      userBloc = UserBloc(
        mockCheckUserUseCase,
        mockUpdateUserLocationUseCase,
        mockUpdateUserUseCase,
        mockDeleteUserUseCase,
      );
    });

    test('initial state should be UserInitial', () {
      expect(userBloc.state, UserInitial());
    });

    // CheckUser
    blocTest<UserBloc, UserState>(
      'emits [UserLoading, UserAuthenticated] when CheckUser is added',
      build: () {
        when(() => mockCheckUserUseCase(NoParams()))
            .thenAnswer((_) async => const Right(tUserModel));
        return userBloc;
      },
      act: (bloc) => bloc.add(CheckUser()),
      expect: () => [UserLoading(), UserAuthenticated(tUserModel)],
    );

    blocTest<UserBloc, UserState>(
      'emits [UserLoading, UserUnauthenticated] on CheckUser error',
      build: () {
        when(() => mockCheckUserUseCase(NoParams()))
            .thenAnswer((_) async => Left(CacheFailure()));
        return userBloc;
      },
      act: (bloc) => bloc.add(CheckUser()),
      expect: () => [UserLoading(), UserUnauthenticated(CacheFailure())],
    );
      
    // UpdateUser
    blocTest<UserBloc, UserState>(
      'emits [UserLoading, UserUpdateSuccess] when UpdateUser is added',
      build: () {
        when(() => mockUpdateUserUseCase(tUpdateUserParams))
            .thenAnswer((_) async => Right(tUserModel));
        return userBloc;
      },
      act: (bloc) => bloc.add(UpdateUser(tUpdateUserParams)),
      expect: () => [UserLoading(), UserUpdateSuccess(tUserModel)],
    );

    blocTest<UserBloc, UserState>(
      'emits [UserLoading, UserUpdateFailure] when UpdateUser is added',
      build: () {
        when(() => mockUpdateUserUseCase(tUpdateUserParams))
            .thenAnswer((_) async => Left(NetworkFailure()));
        return userBloc;
      },
      act: (bloc) => bloc.add(UpdateUser(tUpdateUserParams)),
      expect: () => [UserLoading(), UserUpdateFailed(NetworkFailure())],
    );

    blocTest<UserBloc, UserState>(
      'emits [UserLoading, UserUpdateFailure] when UpdateUser is added',
      build: () {
        when(() => mockUpdateUserUseCase(tUpdateUserParams))
            .thenAnswer((_) async => Left(CredentialFailure()));
        return userBloc;
      },
      act: (bloc) => bloc.add(UpdateUser(tUpdateUserParams)),
      expect: () => [UserLoading(), UserUpdateFailed(CredentialFailure())],
    );

    blocTest<UserBloc, UserState>(
      'emits [UserLoading, UserUpdateFailure] when UpdateUser is added',
      build: () {
        when(() => mockUpdateUserUseCase(tUpdateUserParams))
            .thenAnswer((_) async => Left(ServerFailure()));
        return userBloc;
      },
      act: (bloc) => bloc.add(UpdateUser(tUpdateUserParams)),
      expect: () => [UserLoading(), UserUpdateFailed(ServerFailure())],
    );

    // UpdateUserLocation
    blocTest<UserBloc, UserState>(
      'emits [UserLocationUpdating, UserUpdateLocationSuccess] when UpdateUserLocation is added',
      build: () {
        when(() => mockUpdateUserLocationUseCase(NoParams()))
            .thenAnswer((_) async => Right(tUserModel));
        return userBloc;
      },
      act: (bloc) => bloc.add(UpdateUserLocation()),
      expect: () => [UserLocationUpdating(), UserUpdateLocationSuccess(tUserModel)],
    );

    blocTest<UserBloc, UserState>(
      'emits [UserLocationUpdating, UserUpdateLocationFailed] when UpdateUserLocation is added',
      build: () {
        when(() => mockUpdateUserLocationUseCase(tUpdateUserParams))
            .thenAnswer((_) async => Left(NetworkFailure()));
        return userBloc;
      },
      act: (bloc) => bloc.add(UpdateUserLocation()),
      expect: () => [UserLocationUpdating(), UserUpdateLocationFailed(NetworkFailure())],
    );

    blocTest<UserBloc, UserState>(
      'emits [UserLocationUpdating, UserUpdateLocationFailed] when UpdateUserLocation is added',
      build: () {
        when(() => mockUpdateUserLocationUseCase(tUpdateUserParams))
            .thenAnswer((_) async => Left(CredentialFailure()));
        return userBloc;
      },
      act: (bloc) => bloc.add(UpdateUserLocation()),
      expect: () => [UserLocationUpdating(), UserUpdateLocationFailed(CredentialFailure())],
    );

    blocTest<UserBloc, UserState>(
      'emits [UserLocationUpdating, UserUpdateLocationFailed] when UpdateUserLocation is added',
      build: () {
        when(() => mockUpdateUserLocationUseCase(tUpdateUserParams))
            .thenAnswer((_) async => Left(ServerFailure()));
        return userBloc;
      },
      act: (bloc) => bloc.add(UpdateUserLocation()),
      expect: () => [UserLocationUpdating(), UserUpdateLocationFailed(ServerFailure())],
    );

    // DeleteUser
    blocTest<UserBloc, UserState>(
      'emits [UserLoading, UserDeleteSuccess] when DeleteUser is added',
      build: () {
        when(() => mockDeleteUserUseCase(NoParams()))
            .thenAnswer((_) async => Right(unit));
        return userBloc;
      },
      act: (bloc) => bloc.add(DeleteUser()),
      expect: () => [UserLoading(), UserDeleteSuccess(unit)],
    );

    blocTest<UserBloc, UserState>(
      'emits [UserLoading, UserDeleteFailed] when DeleteUser is added',
      build: () {
        when(() => mockDeleteUserUseCase(NoParams()))
            .thenAnswer((_) async => Left(NetworkFailure()));
        return userBloc;
      },
      act: (bloc) => bloc.add(DeleteUser()),
      expect: () =>
          [UserLoading(), UserDeleteFailed(NetworkFailure())],
    );

    blocTest<UserBloc, UserState>(
      'emits [UserLoading, UserDeleteFailed] when DeleteUser is added',
      build: () {
        when(() => mockDeleteUserUseCase(NoParams()))
            .thenAnswer((_) async => Left(CredentialFailure()));
        return userBloc;
      },
      act: (bloc) => bloc.add(DeleteUser()),
      expect: () => [
        UserLoading(),
        UserDeleteFailed(CredentialFailure())
      ],
    );

    blocTest<UserBloc, UserState>(
      'emits [UserLoading, UserDeleteFailed] when DeleteUser is added',
      build: () {
        when(() => mockDeleteUserUseCase(NoParams()))
            .thenAnswer((_) async => Left(ServerFailure()));
        return userBloc;
      },
      act: (bloc) => bloc.add(DeleteUser()),
      expect: () =>
          [UserLoading(), UserDeleteFailed(ServerFailure())],
    );
  });
}
