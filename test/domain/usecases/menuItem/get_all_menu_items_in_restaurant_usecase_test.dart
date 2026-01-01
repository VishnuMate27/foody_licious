import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foody_licious/core/error/failures.dart';
import 'package:foody_licious/domain/repositories/menu_item_repository.dart';
import 'package:foody_licious/domain/usecase/menuItem/get_all_menu_items_in_restaurant_usecase.dart';
import 'package:mocktail/mocktail.dart';
import '../../../fixtures/constant_objects.dart';

class MockRepository extends Mock implements MenuItemRepository {}

void main() {
  late GetAllMenuItemsInRestaurantUseCase usecase;
  late MockRepository mockRepository;

  setUp(() {
    mockRepository = MockRepository();
    usecase = GetAllMenuItemsInRestaurantUseCase(mockRepository);
  });

  test(
    'Should get User from the repository when User Repository return data successfully',
    () async {
      // Arrange
      when(() => mockRepository
              .getAllItemsInRestaurant(tGetAllMenuItemsInRestaurantParams))
          .thenAnswer((_) async => Right(tMenuItemsResponseModel.menuItems));

      // Act
      final result = await usecase(tGetAllMenuItemsInRestaurantParams);

      // Assert
      expect(result, Right(tMenuItemsResponseModel.menuItems));
      verify(() => mockRepository
          .getAllItemsInRestaurant(tGetAllMenuItemsInRestaurantParams));
    },
  );

  test('should return a Failure from the repository', () async {
    // Arrange
    final failure = NetworkFailure();
    when(() => mockRepository
            .getAllItemsInRestaurant(tGetAllMenuItemsInRestaurantParams))
        .thenAnswer((_) async => Left(failure));

    // Act
    final result = await usecase(tGetAllMenuItemsInRestaurantParams);

    // Assert
    expect(result, Left(failure));
    verify(() => mockRepository
        .getAllItemsInRestaurant(tGetAllMenuItemsInRestaurantParams));
  });
}
