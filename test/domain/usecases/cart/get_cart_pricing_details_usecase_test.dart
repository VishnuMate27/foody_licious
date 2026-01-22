


import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foody_licious/core/error/failures.dart';
import 'package:foody_licious/domain/usecase/cart/get_cart_pricing_details_usecase.dart';
import 'package:mocktail/mocktail.dart';

import '../../../fixtures/constant_objects.dart';
import 'get_all_cart_items_usecase_test.dart';

void main() {
  late GetCartPricingDetailsUseCase usecase;
  late MockRepository mockRepository;

  setUp(() {
    mockRepository = MockRepository();
    usecase = GetCartPricingDetailsUseCase(mockRepository);
  });

  test(
      'Should get all cart pricing from the repository when Cart Repository returns data successfully',
      () async {
    // Arrange
    when(() => mockRepository.getCartPricingDetails(tGetCartPricingDetailsParams))
        .thenAnswer((_) async => Right(tCartPricingDetails));

    // Act
    final result = await usecase(tGetCartPricingDetailsParams);

    // Assert
    expect(result, Right(tCartPricingDetails));
    verify(() => mockRepository.getCartPricingDetails(tGetCartPricingDetailsParams));
  });

  test('Should return a Failure from the repository', () async {
    // Arrange
    final failure = NetworkFailure();
    when(() => mockRepository.getCartPricingDetails(tGetCartPricingDetailsParams))
        .thenAnswer((_) async => Left(failure));

    // Act
    final result = await usecase(tGetCartPricingDetailsParams);

    // Assert
    expect(result, Left(failure));
    verify(() => mockRepository.getCartPricingDetails(tGetCartPricingDetailsParams));
  });
}
