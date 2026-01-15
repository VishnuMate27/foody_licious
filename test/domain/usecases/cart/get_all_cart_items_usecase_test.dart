


import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foody_licious/core/error/failures.dart';
import 'package:foody_licious/domain/repositories/cart_repository.dart';
import 'package:foody_licious/domain/usecase/cart/get_all_cart_item_usecase.dart';
import 'package:mocktail/mocktail.dart';
import '../../../fixtures/constant_objects.dart';

class MockRepository extends Mock implements CartRepository {}

void main() {
  late GetAllCartItemUseCase usecase;
  late MockRepository mockRepository;

  setUp(() {
    mockRepository = MockRepository();
    usecase = GetAllCartItemUseCase(mockRepository);
  });

  test(
      'Should get all cart items from the repository when Cart Repository returns data successfully',
      () async {
    // Arrange
    when(() => mockRepository.getAllCartItem(tGetAllCartItemParams))
        .thenAnswer((_) async => Right(tCartItemsResponseModel.cartItems));

    // Act
    final result = await usecase(tGetAllCartItemParams);

    // Assert
    expect(result, Right(tCartItemsResponseModel.cartItems));
    verify(() => mockRepository.getAllCartItem(tGetAllCartItemParams));
  });

  test('Should return a Failure from the repository', () async {
    // Arrange
    final failure = NetworkFailure();
    when(() => mockRepository.getAllCartItem(tGetAllCartItemParams))
        .thenAnswer((_) async => Left(failure));

    // Act
    final result = await usecase(tGetAllCartItemParams);

    // Assert
    expect(result, Left(failure));
    verify(() => mockRepository.getAllCartItem(tGetAllCartItemParams));
  });
}
