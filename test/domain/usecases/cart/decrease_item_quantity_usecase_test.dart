import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foody_licious/core/error/failures.dart';
import 'package:foody_licious/domain/repositories/cart_repository.dart';
import 'package:foody_licious/domain/usecase/cart/decrease_item_quantity_usecase.dart';
import 'package:mocktail/mocktail.dart';
import '../../../fixtures/constant_objects.dart';

class MockRepository extends Mock implements CartRepository {}

void main() {
  late DecreaseItemQuantityUseCase usecase;
  late MockRepository mockRepository;

  setUp(() {
    mockRepository = MockRepository();
    usecase = DecreaseItemQuantityUseCase(mockRepository);
  });

  test(
      'Should get CartItem from the repository when Cart Repository return data successfully',
      () async {
    // Arrange
    when(() => mockRepository.decreaseItemQuantity(tDecreaseItemQuantityParams ))
        .thenAnswer((_) async => Right(tCartItemResponseModel.cartItem));

    // Act
    final result = await usecase(tDecreaseItemQuantityParams);

    // Assert
    expect(result, Right(tCartItemResponseModel.cartItem));
    verify(() => mockRepository.decreaseItemQuantity(tDecreaseItemQuantityParams));
  });

  test('Should return a Failure from the repository', () async {
    // Arrange
    final failure = NetworkFailure();
    when(() => mockRepository.decreaseItemQuantity(tDecreaseItemQuantityParams))
        .thenAnswer((_) async => Left(failure));

    // Act
    final result = await usecase(tDecreaseItemQuantityParams);

    // Assert
    expect(result, Left(failure));
    verify(() => mockRepository.decreaseItemQuantity(tDecreaseItemQuantityParams));
  });
}
