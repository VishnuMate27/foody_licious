
import 'package:foody_licious/domain/usecase/cart/increase_item_quantity_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foody_licious/core/error/failures.dart';
import 'package:foody_licious/domain/repositories/cart_repository.dart';
import 'package:mocktail/mocktail.dart';
import '../../../fixtures/constant_objects.dart';

class MockRepository extends Mock implements CartRepository {}

void main() {
  late IncreaseItemQuantityUseCase usecase;
  late MockRepository mockRepository;

  setUp(() {
    mockRepository = MockRepository();
    usecase = IncreaseItemQuantityUseCase(mockRepository);
  });

  test(
      'Should get CartItem from the repository when Cart Repository return data successfully',
      () async {
    // Arrange
    when(() => mockRepository.increaseItemQuantity(tIncreaseItemQuantityParams ))
        .thenAnswer((_) async => Right(tCartItemModel));

    // Act
    final result = await usecase(tIncreaseItemQuantityParams);

    // Assert
    expect(result, Right(tCartItemResponseModel.cartItem));
    verify(() => mockRepository.increaseItemQuantity(tIncreaseItemQuantityParams));
  });

  test('Should return a Failure from the repository', () async {
    // Arrange
    final failure = NetworkFailure();
    when(() => mockRepository.increaseItemQuantity(tIncreaseItemQuantityParams))
        .thenAnswer((_) async => Left(failure));

    // Act
    final result = await usecase(tIncreaseItemQuantityParams);

    // Assert
    expect(result, Left(failure));
    verify(() => mockRepository.increaseItemQuantity(tIncreaseItemQuantityParams));
  });
}
