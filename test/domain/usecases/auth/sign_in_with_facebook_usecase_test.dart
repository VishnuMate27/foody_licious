import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foody_licious/core/error/failures.dart';
import 'package:foody_licious/core/usecase/usecase.dart';
import 'package:foody_licious/domain/repositories/auth_repository.dart';
import 'package:foody_licious/domain/usecase/auth/sign_in_with_facebook_usecase.dart';
import 'package:mocktail/mocktail.dart';
import '../../../fixtures/constant_objects.dart';

class MockRepository extends Mock implements AuthRepository {}

void main() {
  late MockRepository mockRepository;
  late SignInWithFacebookUseCase usecase;

  setUp(() {
    mockRepository = MockRepository();
    usecase = SignInWithFacebookUseCase(mockRepository);
  });

  test('Should get User when signInWithFacebook returns data successfully',
      () async {
    /// Arrange
    when(() => mockRepository.signInWithFacebook())
        .thenAnswer((_) async => Right(tUserModel));

    /// Act
    final result = await usecase(NoParams());

    /// Assert
    expect(result, Right(tUserModel));
    verify(() => mockRepository.signInWithFacebook()).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test('Should get failure from Repository', () async {
    final failure = NetworkFailure();

    /// Arrange
    when(() => mockRepository.signInWithFacebook())
        .thenAnswer((_) async => Left(failure));

    /// Act
    final result = await usecase(NoParams());

    /// Assert
    expect(result, Left(failure));
    verify(() => mockRepository.signInWithFacebook()).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
