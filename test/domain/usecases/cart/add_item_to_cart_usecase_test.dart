import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foody_licious/core/error/failures.dart';
import 'package:foody_licious/domain/repositories/cart_repository.dart';
import 'package:foody_licious/domain/usecase/cart/add_item_to_cart_usecase.dart';
import 'package:mocktail/mocktail.dart';

import '../../../fixtures/constant_objects.dart';

class MockRepository extends Mock implements CartRepository {}

void main() {
  late AddItemToCartUseCase usecase;
  late MockRepository mockRepository;

  setUp(() {
    mockRepository = MockRepository();
    usecase = AddItemToCartUseCase(mockRepository);
  });

  test(
      'Should get Unit from the repository when Cart Repository return data successfully',
      () async {
    // Arrange
    when(() => mockRepository.addItemToCart(tAddItemToCartParams))
        .thenAnswer((_) async => Right(unit));

    // Act
    final result = await usecase(tAddItemToCartParams);

    // Assert
    expect(result, Right(unit));
    verify(() => mockRepository.addItemToCart(tAddItemToCartParams));
  });

  test('Should return a Failure from the repository', () async {
    // Arrange
    final failure = NetworkFailure();
    when(() => mockRepository.addItemToCart(tAddItemToCartParams))
        .thenAnswer((_) async => Left(failure));

    // Act
    final result = await usecase(tAddItemToCartParams);

    // Assert
    expect(result, Left(failure));
    verify(() => mockRepository.addItemToCart(tAddItemToCartParams));
  });
}
