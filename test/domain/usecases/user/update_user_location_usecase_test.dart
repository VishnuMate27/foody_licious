import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foody_licious/core/error/failures.dart';
import 'package:foody_licious/core/usecase/usecase.dart';
import 'package:foody_licious/domain/repositories/user_repository.dart';
import 'package:foody_licious/domain/usecase/user/update_user_location_usecase.dart';
import 'package:foody_licious/domain/usecase/user/update_user_usecase.dart';
import 'package:mocktail/mocktail.dart';
import '../../../fixtures/constant_objects.dart';

class MockRepository extends Mock implements UserRepository {}
void main() {
  late UpdateUserLocationUseCase usecase;
  late MockRepository mockRepository;

  setUp(() {
    mockRepository = MockRepository();
    usecase = UpdateUserLocationUseCase(mockRepository);
  });

    test(
    'Should get User from the repository when User Repository return data successfully',
        () async {
      /// Arrange
      when(() => mockRepository.updateUserLocation())
          .thenAnswer((_) async => const Right(tUserModel));

      /// Act
      final result = await usecase(NoParams());

      /// Assert
      expect(result, const Right(tUserModel));
      verify(() => mockRepository.updateUserLocation());
      verifyNoMoreInteractions(mockRepository);
    },
  );

  test('should return a Failure from the repository', () async {
    /// Arrange
    final failure = NetworkFailure();
    when(() => mockRepository.updateUserLocation())
        .thenAnswer((_) async => Left(failure));

    /// Act
    final result = await usecase(NoParams());

    /// Assert
    expect(result, Left(failure));
    verify(() => mockRepository.updateUserLocation());
    verifyNoMoreInteractions(mockRepository);
  });
}
