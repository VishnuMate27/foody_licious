import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foody_licious/core/error/failures.dart';
import 'package:foody_licious/domain/entities/user/user.dart';
import 'package:foody_licious/domain/repositories/auth_repository.dart';
import 'package:foody_licious/domain/usecase/auth/sign_in_with_email_usecase.dart';
import 'package:mocktail/mocktail.dart';

import '../../../fixtures/constant_objects.dart';

class MockRepository extends Mock implements AuthRepository {}

void main() {
  late MockRepository mockRepository;
  late SignInWithEmailUseCase usecase;

  setUp(() {
    mockRepository = MockRepository();
    usecase = SignInWithEmailUseCase(mockRepository);
  });

  test(
    'Should get User when signInWithEmail return data successfully',
    () async {
      /// Arrange
      when(() => mockRepository.signInWithEmail(tSignInWithEmailParams))
          .thenAnswer((_) async => Right(tUserModel));

      /// Act
      final result = await usecase(tSignInWithEmailParams);

      /// Assert
      expect(result, Right(tUserModel));
      verify(() => mockRepository.signInWithEmail(tSignInWithEmailParams))
          .called(1);
      verifyNoMoreInteractions(mockRepository);
    },
  );

  test(
    'Should get Failure from Repository',
    () async {
      final failure = NetworkFailure();
      /// Arrange
      when(() => mockRepository.signInWithEmail(tSignInWithEmailParams))
          .thenAnswer((_) async => Left(failure));

      /// Act
      final result = await usecase(tSignInWithEmailParams);

      /// Assert
      expect(result, Left(failure));
      verify(() => mockRepository.signInWithEmail(tSignInWithEmailParams))
          .called(1);
      verifyNoMoreInteractions(mockRepository);
    },
  );
}
