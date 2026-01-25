import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foody_licious/core/error/failures.dart';
import 'package:foody_licious/domain/repositories/payment_repository.dart';
import 'package:foody_licious/domain/usecase/payment/complete_payment_usecase.dart';
import 'package:mocktail/mocktail.dart';

import '../../../fixtures/constant_objects.dart';

class MockPaymentRepository extends Mock implements PaymentRepository {}

void main() {
  late CompletePaymentUseCase usecase;
  late MockPaymentRepository mockRepository;

  setUp(() {
    mockRepository = MockPaymentRepository();
    usecase = CompletePaymentUseCase(mockRepository);
  });

  test(
    'Should get Unit from the repository when Payment Repository return data successfully',
    () async {
      // Arrange
      when(() => mockRepository.completePayment(tPaymentParams))
          .thenAnswer((_) async => Right(unit));

      // Act
      final result = await usecase(tPaymentParams);

      // Assert
      expect(result, Right(unit));
      verify(() => mockRepository
          .completePayment(tPaymentParams));
    },
  );

  test('should return a Failure from the repository', () async {
    // Arrange
    final failure = NetworkFailure();
    when(() => mockRepository
            .completePayment(tPaymentParams))
        .thenAnswer((_) async => Left(failure));

    // Act
    final result = await usecase(tPaymentParams);

    // Assert
    expect(result, Left(failure));
    verify(() => mockRepository.completePayment(tPaymentParams));
  });


}
