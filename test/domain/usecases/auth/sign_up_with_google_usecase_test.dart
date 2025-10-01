import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foody_licious/core/error/failures.dart';
import 'package:foody_licious/core/usecase/usecase.dart';
import 'package:foody_licious/domain/repositories/auth_repository.dart';
import 'package:foody_licious/domain/usecase/auth/sign_up_with_google_usecase.dart';
import 'package:mocktail/mocktail.dart';

import '../../../fixtures/constant_objects.dart';

class MockRepository extends Mock implements AuthRepository {}

void main() {
  late MockRepository mockRepository;
  late SignUpWithGoogleUseCase usecase;

  setUp(() {
    mockRepository = MockRepository();
    usecase = SignUpWithGoogleUseCase(mockRepository);
  });

  test(
      'Should get User from repository when mockRepository returns data successfully',
      () async {
    /// Arrange
    when(() => mockRepository.signUpWithGoogle())
        .thenAnswer((_) async => Right(tUserModel));

    /// Act
    final result = await usecase(NoParams());

    /// Assert
    expect(result, Right(tUserModel));
    verify(() => mockRepository.signUpWithGoogle()).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test('Should get failure from repository', () async {
    final failure = NetworkFailure();

    /// Arrange
    when(() => mockRepository.signUpWithGoogle())
        .thenAnswer((_) async => Left(failure));

    /// Act
    final result = await usecase(NoParams());

    /// Assert
    expect(result, Left(failure));
    verify(() => mockRepository.signUpWithGoogle()).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}