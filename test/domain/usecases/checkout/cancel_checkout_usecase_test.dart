import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foody_licious/core/error/failures.dart';
import 'package:foody_licious/domain/repositories/checkout_repository.dart';
import 'package:foody_licious/domain/usecase/checkout/cancel_checkout_usecase.dart';
import 'package:mocktail/mocktail.dart';
import '../../../fixtures/constant_objects.dart';

class MockRepository extends Mock implements CheckoutRepository {}

void main() {
  late CancelCheckoutUseCase usecase;
  late MockRepository mockRepository;

  setUp(() {
    mockRepository = MockRepository();
    usecase = CancelCheckoutUseCase(mockRepository);
  });

  test(
      'Should get Unit from the repository when Checkout Repository return data successfully',
      () async {
    // Arrange
    when(() => mockRepository.cancelCheckout(tCancelCheckoutParams))
        .thenAnswer((_) async => Right(unit));

    // Act
    final result = await usecase(tCancelCheckoutParams);

    // Assert
    expect(result, Right(unit));
    verify(() => mockRepository.cancelCheckout(tCancelCheckoutParams));
  });

  test('Should return a Failure from the repository', () async {
    // Arrange
    final failure = NetworkFailure();
    when(() => mockRepository.cancelCheckout(tCancelCheckoutParams))
        .thenAnswer((_) async => Left(failure));

    // Act
    final result = await usecase(tCancelCheckoutParams);

    // Assert
    expect(result, Left(failure));
    verify(() => mockRepository.cancelCheckout(tCancelCheckoutParams));
  });
}

