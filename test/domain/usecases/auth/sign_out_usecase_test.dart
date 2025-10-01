import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foody_licious/core/error/failures.dart';
import 'package:foody_licious/core/usecase/usecase.dart';
import 'package:foody_licious/domain/repositories/auth_repository.dart';
import 'package:foody_licious/domain/usecase/auth/sign_out_usecase.dart';
import 'package:mocktail/mocktail.dart';

class MockRepository extends Mock implements AuthRepository {}

void main() {
  late MockRepository mockRepository;
  late SignOutUseCase usecase;

  setUp(() {
    mockRepository = MockRepository();
    usecase = SignOutUseCase(mockRepository);
  });

  test(
      'Should get Unit from repository when MockAuthRepository returns data successfully',
      () async {
    /// Arrange
    when(() => mockRepository.signOut()).thenAnswer((_) async => Right(unit));

    /// Act
    final result = await usecase(NoParams());

    /// Assert
    expect(result, Right(unit));
    verify(() => mockRepository.signOut()).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test('Should get failure from repository', () async {
    final failure = NetworkFailure();
    /// Arrange
    when(() => mockRepository.signOut()).thenAnswer((_) async => Left(failure));

    /// Act
    final result = await usecase(NoParams());

    /// Assert
    expect(result, Left(failure));
    verify(() => mockRepository.signOut()).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
