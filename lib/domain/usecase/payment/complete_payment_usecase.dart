import 'package:dartz/dartz.dart';
import 'package:foody_licious/core/error/failures.dart';
import 'package:foody_licious/core/usecase/usecase.dart';
import 'package:foody_licious/domain/repositories/payment_repository.dart';

class CompletePaymentUseCase extends UseCase<Unit, PaymentParams> {
  final PaymentRepository repository;
  CompletePaymentUseCase(this.repository);

  @override
  Future<Either<Failure, Unit>> call(PaymentParams params) {
    return repository.completePayment(params);
  }
}

class PaymentParams {
  final String paymentId;
  final String paymentMode;
  PaymentParams({
    required this.paymentId,
    required this.paymentMode,
  });
}
