import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foody_licious/core/error/failures.dart';
import 'package:foody_licious/core/usecase/usecase.dart';
import 'package:foody_licious/domain/entities/user/user.dart';
import 'package:foody_licious/domain/repositories/auth_repository.dart';
import 'package:foody_licious/domain/usecase/auth/send_verification_email_usecase.dart';
import 'package:mocktail/mocktail.dart';

class MockRespository extends Mock implements AuthRepository {}

void main() {
  late MockRespository mockRepository;
  late SendVerificationEmailUseCase useCase;

  setUp(() {
    mockRepository = MockRespository();
    useCase = SendVerificationEmailUseCase(mockRepository);
  });

  test(
    'Should get Unit from repository when MockAuthRepository returns data successfully',
    () async {
      /// Arrange
      when(() => mockRepository.sendVerificationEmail())
          .thenAnswer((_) async => Right(unit));

      /// Act
      final result = await useCase(NoParams());

      /// Assert
      expect(result, Right(unit));
      verify(() => mockRepository.sendVerificationEmail()).called(1);
      verifyNoMoreInteractions(mockRepository);
    },
  );

  test(
    'Should get Failure from the repository',
    () async {
      final failure = NetworkFailure();
      /// Arrange
      when(() => mockRepository.sendVerificationEmail())
          .thenAnswer((_) async => Left(failure));

      /// Act
      final result = await useCase(NoParams());

      /// Assert
      expect(result, Left(failure));
      verify(() => mockRepository.sendVerificationEmail()).called(1);
      verifyNoMoreInteractions(mockRepository);
    },
  );
}
