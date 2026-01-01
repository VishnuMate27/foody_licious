import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foody_licious/core/error/failures.dart';
import 'package:foody_licious/domain/repositories/restaurant_repository.dart';
import 'package:foody_licious/domain/usecase/restaurant/get_restaurant_details_usecase.dart';
import 'package:mocktail/mocktail.dart';
import '../../../fixtures/constant_objects.dart';

class MockRepository extends Mock implements RestaurantRepository {}

void main() {
  late GetRestaurantDetailsUseCase usecase;
  late MockRepository mockRepository;

  setUp(() {
    mockRepository = MockRepository();
    usecase = GetRestaurantDetailsUseCase(mockRepository);
  });

  test(
    'Should get User from the repository when User Repository return data successfully',
    () async {
      // Arrange
      when(() =>
              mockRepository.getRestaurantDetails(tGetRestaurantDetailsParams))
          .thenAnswer((_) async => Right(tRestaurantResponseModel.restaurant));

      // Act
      final result = await usecase(tGetRestaurantDetailsParams);

      // Assert
      expect(result, Right(tRestaurantResponseModel.restaurant));

      verify(() =>
          mockRepository.getRestaurantDetails(tGetRestaurantDetailsParams));
    },
  );

  test('should return a Failure from the repository', () async {
    // Arrange
    final failure = NetworkFailure();
    when(() => mockRepository.getRestaurantDetails(tGetRestaurantDetailsParams))
        .thenAnswer((_) async => Left(failure));

    // Act
    final result = await usecase(tGetRestaurantDetailsParams);

    // Assert
    expect(result, Left(failure));
    verify(
        () => mockRepository.getRestaurantDetails(tGetRestaurantDetailsParams));
  });
}
