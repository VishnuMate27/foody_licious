import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foody_licious/core/error/failures.dart';
import 'package:foody_licious/core/usecase/usecase.dart';
import 'package:foody_licious/domain/repositories/user_repository.dart';
import 'package:foody_licious/domain/usecase/user/delete_user_usecase.dart';
import 'package:mocktail/mocktail.dart';

class MockRepository extends Mock implements UserRepository {}

void main() {
  late MockRepository mockRepository;
  late DeleteUserUseCase usecase;

  setUp(() {
    mockRepository = MockRepository();
    usecase = DeleteUserUseCase(mockRepository);
  });

  test(
    'Should get Unit from repository when mockRepository returns data successfully.',
    () async {
      /// Arrange
      when(() => mockRepository.deleteUser())
          .thenAnswer((_) async => Right(unit));

      /// Act
      final result = await usecase(NoParams());

      /// Assert
      expect(result, Right(unit));
      verify(() => mockRepository.deleteUser()).called(1);
      verifyNoMoreInteractions(mockRepository);
    },
  );

  test(
    'Should get failure from repository',
    () async {
      final failure = NetworkFailure();

      /// Arrange
      when(() => mockRepository.deleteUser())
          .thenAnswer((_) async => Left(failure));

      /// Act
      final result = await usecase(NoParams());

      /// Assert
      expect(result, Left(failure));
      verify(() => mockRepository.deleteUser()).called(1);
      verifyNoMoreInteractions(mockRepository);
    },
  );
}
