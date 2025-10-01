import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foody_licious/core/error/failures.dart';
import 'package:foody_licious/domain/repositories/auth_repository.dart';
import 'package:foody_licious/domain/usecase/auth/send_password_reset_email_usecase.dart';
import 'package:mocktail/mocktail.dart';

import '../../../fixtures/constant_objects.dart';

class MockRepository extends Mock implements AuthRepository {}

void main() {
  late MockRepository mockRepository;
  late SendPasswordResetEmailUseCase usecase;
  setUp(() {
    mockRepository = MockRepository();
    usecase = SendPasswordResetEmailUseCase(mockRepository);
  });

  test(
    'Should get Unit from repository when MockAuthRepository returns data successfully',
    () async {
      /// Arrange
      when(() => mockRepository.sendPasswordResetEmail(
          tSendPasswordResetEmailParams)).thenAnswer((_) async => Right(unit));

      /// Act
      final result = await mockRepository
          .sendPasswordResetEmail(tSendPasswordResetEmailParams);

      /// Assert
      expect(result, Right(unit));
      verify(() => mockRepository
          .sendPasswordResetEmail(tSendPasswordResetEmailParams)).called(1);
      verifyNoMoreInteractions(mockRepository);
    },
  );

  test(
    'Should get Failure from the repository',
    () async {
      final failure = NetworkFailure();

      /// Arrange
      when(() => mockRepository.sendPasswordResetEmail(
          tSendPasswordResetEmailParams)).thenAnswer((_) async => Left(failure));

      /// Act
      final result = await mockRepository
          .sendPasswordResetEmail(tSendPasswordResetEmailParams);

      /// Assert
      expect(result, Left(failure));
      verify(() => mockRepository
          .sendPasswordResetEmail(tSendPasswordResetEmailParams)).called(1);
      verifyNoMoreInteractions(mockRepository);
    },
  );
}
