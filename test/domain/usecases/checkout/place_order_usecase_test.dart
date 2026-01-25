import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foody_licious/core/error/failures.dart';
import 'package:foody_licious/domain/repositories/checkout_repository.dart';
import 'package:foody_licious/domain/usecase/checkout/place_order_usecase.dart';
import 'package:mocktail/mocktail.dart';

import '../../../fixtures/constant_objects.dart';

class MockRepository extends Mock implements CheckoutRepository {}

void main() {
  late PlaceOrderUseCase usecase;
  late MockRepository mockRepository;

  setUp(() {
    mockRepository = MockRepository();
    usecase = PlaceOrderUseCase(mockRepository);
  });

  test(
      'Should get PlaceOrderDetails from the repository when Cart Repository return data successfully',
      () async {
    // Arrange
    when(() => mockRepository.placeOrder(tPlaceOrderParams))
        .thenAnswer((_) async => Right(tPlaceOrderDetails));

    // Act
    final result = await usecase(tPlaceOrderParams);

    // Assert
    expect(result, Right(tPlaceOrderDetails));
    verify(() => mockRepository.placeOrder(tPlaceOrderParams));
  });

  test('Should return a Failure from the repository', () async {
    // Arrange
    final failure = NetworkFailure();
    when(() => mockRepository.placeOrder(tPlaceOrderParams))
        .thenAnswer((_) async => Left(failure));

    // Act
    final result = await usecase(tPlaceOrderParams);

    // Assert
    expect(result, Left(failure));
    verify(() => mockRepository.placeOrder(tPlaceOrderParams));
  });
}

