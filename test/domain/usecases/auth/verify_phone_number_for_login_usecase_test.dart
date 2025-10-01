import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foody_licious/core/error/failures.dart';
import 'package:foody_licious/domain/repositories/auth_repository.dart';
import 'package:foody_licious/domain/usecase/auth/verify_phone_number_for_login_usecase.dart';
import 'package:mocktail/mocktail.dart';

import '../../../fixtures/constant_objects.dart';

class MockRepository extends Mock implements AuthRepository {}

void main() {
  late MockRepository mockRepository;
  late VerifyPhoneNumberForLoginUseCase usecase;

  setUp(() {
    mockRepository = MockRepository();
    usecase = VerifyPhoneNumberForLoginUseCase(mockRepository);
  });

  test(
      'Should get Unit from repository when mockRepository returns data successfully',
      () async {
    /// Arrange
    when(() => mockRepository.verifyPhoneNumberForLogin(tSignInWithPhoneParams))
        .thenAnswer((_) async => Right(unit));

    /// Act
    final result = await usecase(tSignInWithPhoneParams);

    /// Assert
    expect(result, Right(unit));
    verify(() =>
            mockRepository.verifyPhoneNumberForLogin(tSignInWithPhoneParams))
        .called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test('Should get failure from repository', () async {
    final failure = NetworkFailure();

    /// Arrange
    when(() => mockRepository.verifyPhoneNumberForLogin(tSignInWithPhoneParams))
        .thenAnswer((_) async => Left(failure));

    /// Act
    final result = await usecase(tSignInWithPhoneParams);

    /// Assert
    expect(result, Left(failure));
    verify(() =>
            mockRepository.verifyPhoneNumberForLogin(tSignInWithPhoneParams))
        .called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
