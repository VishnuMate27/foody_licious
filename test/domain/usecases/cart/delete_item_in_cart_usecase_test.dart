


import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foody_licious/core/error/failures.dart';
import 'package:foody_licious/domain/repositories/cart_repository.dart';
import 'package:foody_licious/domain/usecase/cart/delete_item_in_cart_usecase.dart';
import 'package:mocktail/mocktail.dart';

import '../../../fixtures/constant_objects.dart';

class MockRepository extends Mock implements CartRepository {}

void main() {
  late DeleteItemInCartUseCase usecase;
  late MockRepository mockRepository;

  setUp(() {
    mockRepository = MockRepository();
    usecase = DeleteItemInCartUseCase(mockRepository);
  });

  test(
      'Should get Unit from the repository when Cart Repository deletes item successfully',
      () async {
    // Arrange
    when(() => mockRepository.deleteItemInCart(tDeleteItemInCartParams))
        .thenAnswer((_) async => Right(unit));

    // Act
    final result = await usecase(tDeleteItemInCartParams);

    // Assert
    expect(result, Right(unit));
    verify(() => mockRepository.deleteItemInCart(tDeleteItemInCartParams));
  });

  test('Should return a Failure from the repository', () async {
    // Arrange
    final failure = NetworkFailure();
    when(() => mockRepository.deleteItemInCart(tDeleteItemInCartParams))
        .thenAnswer((_) async => Left(failure));

    // Act
    final result = await usecase(tDeleteItemInCartParams);

    // Assert
    expect(result, Left(failure));
    verify(() => mockRepository.deleteItemInCart(tDeleteItemInCartParams));
  });
}
