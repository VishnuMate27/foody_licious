import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foody_licious/core/error/failures.dart';
import 'package:foody_licious/domain/repositories/menu_item_repository.dart';
import 'package:foody_licious/domain/usecase/menuItem/get_all_menu_items_usecase.dart';
import 'package:mocktail/mocktail.dart';
import '../../../fixtures/constant_objects.dart';

class MockRepository extends Mock implements MenuItemRepository {}

void main() {
  late GetAllItemsInRestaurantsOfUsersCityUseCase usecase;
  late MockRepository mockRepository;

  setUp(() {
    mockRepository = MockRepository();
    usecase = GetAllItemsInRestaurantsOfUsersCityUseCase(mockRepository);
  });

  test(
    'Should get User from the repository when User Repository return data successfully',
    () async {

          /// Arrange
      when(() => mockRepository.getAllItemsInRestaurantsOfUsersCity(tGetAllItemsInRestaurantsOfUsersCityParams))
          .thenAnswer((_) async =>  Right(tMenuItemsResponseModel.menuItems));

      // Act
      final result = await usecase(tGetAllItemsInRestaurantsOfUsersCityParams);

      // Assert
      expect(result, Right(tMenuItemsResponseModel.menuItems));
      verify(() => mockRepository
          .getAllItemsInRestaurantsOfUsersCity(tGetAllItemsInRestaurantsOfUsersCityParams));
    },
  );

  test('should return a Failure from the repository', () async {
    // Arrange
    final failure = NetworkFailure();
    when(() => mockRepository
            .getAllItemsInRestaurantsOfUsersCity(tGetAllItemsInRestaurantsOfUsersCityParams))
        .thenAnswer((_) async => Left(failure));

    // Act
    final result = await usecase(tGetAllItemsInRestaurantsOfUsersCityParams);

    // Assert
    expect(result, Left(failure));
    verify(() => mockRepository
        .getAllItemsInRestaurantsOfUsersCity(tGetAllItemsInRestaurantsOfUsersCityParams));
  });
}
