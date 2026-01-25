import 'package:dartz/dartz.dart';
import 'package:foody_licious/core/error/failures.dart';
import 'package:foody_licious/domain/usecase/payment/complete_payment_usecase.dart';

abstract class PaymentRepository {
  Future<Either<Failure, Unit>> completePayment(PaymentParams params);
}
