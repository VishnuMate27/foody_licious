import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foody_licious/core/error/failures.dart';
import 'package:foody_licious/core/usecase/usecase.dart';
import 'package:foody_licious/domain/repositories/auth_repository.dart';
import 'package:foody_licious/domain/usecase/auth/wait_for_email_verification_usecase.dart';
import 'package:mocktail/mocktail.dart';

class MockRepository extends Mock implements AuthRepository {}

void main() {
  late MockRepository mockRepository;
  late WaitForEmailVerificationUsecase usecase;

  setUp(() {
    mockRepository = MockRepository();
    usecase = WaitForEmailVerificationUsecase(mockRepository);
  });

  test(
    'Should get Unit from repository when mockRepository returns data successfully',
    () async {
      /// Arrange
      when(() => mockRepository.waitForEmailVerification())
          .thenAnswer((_) async => Right(unit));

      /// Act
      final result = await usecase(NoParams());

      /// Assert
      expect(result, Right(unit));
      verify(() => mockRepository.waitForEmailVerification()).called(1);
      verifyNoMoreInteractions(mockRepository);
    },
  );

  test(
    'Should get failure from repository',
    () async {
      final failure = NetworkFailure();

      /// Arrange
      when(() => mockRepository.waitForEmailVerification())
          .thenAnswer((_) async => Left(failure));

      /// Act
      final result = await usecase(NoParams());

      /// Assert
      expect(result, Left(failure));
      verify(() => mockRepository.waitForEmailVerification()).called(1);
      verifyNoMoreInteractions(mockRepository);
    },
  );
}
