import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foody_licious/core/error/failures.dart';
import 'package:foody_licious/domain/repositories/auth_repository.dart';
import 'package:foody_licious/domain/usecase/auth/sign_in_with_phone_usecase.dart';
import 'package:mocktail/mocktail.dart';

import '../../../fixtures/constant_objects.dart';

class MockRepository extends Mock implements AuthRepository {}

void main() {
  late MockRepository mockRepository;
  late SignInWithPhoneUseCase usecase;

  setUp(() {
    mockRepository = MockRepository();
    usecase = SignInWithPhoneUseCase(mockRepository);
  });

  test(
    'Should get User from repository when MockAuthRepository returns data successfully',
    () async {
      /// Arrange
      when(() => mockRepository.signInWithPhone(tSignInWithPhoneParams))
          .thenAnswer((_) async => Right(tUserModel));

      /// Act
      final result = await usecase(tSignInWithPhoneParams);

      /// Assert
      expect(result, Right(tUserModel));
      verify(() => mockRepository.signInWithPhone(tSignInWithPhoneParams))
          .called(1);
      verifyNoMoreInteractions(mockRepository);
    },
  );

  test(
    'Should get Failure from repository',
    () async {
      final failure = NetworkFailure();

      /// Arrange
      when(() => mockRepository.signInWithPhone(tSignInWithPhoneParams))
          .thenAnswer((_) async => Left(failure));

      /// Act
      final result = await usecase(tSignInWithPhoneParams);

      /// Assert
      expect(result, Left(failure));
      verify(() => mockRepository.signInWithPhone(tSignInWithPhoneParams))
          .called(1);
      verifyNoMoreInteractions(mockRepository);
    },
  );
}
