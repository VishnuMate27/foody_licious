import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foody_licious/core/error/failures.dart';
import 'package:foody_licious/domain/repositories/auth_repository.dart';
import 'package:foody_licious/domain/usecase/auth/verify_phone_number_for_registration_usecase.dart';
import 'package:mocktail/mocktail.dart';

import '../../../fixtures/constant_objects.dart';

class MockRepository extends Mock implements AuthRepository {}

void main() {
  late MockRepository mockRepository;
  late VerifyPhoneNumberForRegistrationUseCase usecase;

  setUp(() {
    mockRepository = MockRepository();
    usecase = VerifyPhoneNumberForRegistrationUseCase(mockRepository);
  });

  test(
    'Should get Unit from repository when mockRepository returns data successfully.',
    () async {
      /// Arrange
      when(() => mockRepository.verifyPhoneNumberForRegistration(
          tSignUpWithPhoneParams)).thenAnswer((_) async => Right(unit));

      /// Act
      final result = await usecase(tSignUpWithPhoneParams);

      /// Assert
      expect(result, Right(unit));
      verify(() => mockRepository
          .verifyPhoneNumberForRegistration(tSignUpWithPhoneParams)).called(1);
      verifyNoMoreInteractions(mockRepository);
    },
  );

  test(
    'Should get failure from repository',
    () async {
      final failure = NetworkFailure();

      /// Arrange
      when(() => mockRepository.verifyPhoneNumberForRegistration(
          tSignUpWithPhoneParams)).thenAnswer((_) async => Left(failure));

      /// Act
      final result = await usecase(tSignUpWithPhoneParams);

      /// Assert
      expect(result, Left(failure));
      verify(() => mockRepository
          .verifyPhoneNumberForRegistration(tSignUpWithPhoneParams)).called(1);
      verifyNoMoreInteractions(mockRepository);
    },
  );
}
