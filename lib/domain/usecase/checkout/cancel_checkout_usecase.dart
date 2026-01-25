import 'package:dartz/dartz.dart';
import 'package:foody_licious/core/error/failures.dart';
import 'package:foody_licious/core/usecase/usecase.dart';
import 'package:foody_licious/domain/repositories/checkout_repository.dart';

class CancelCheckoutUseCase extends UseCase<Unit, CancelCheckoutParams> {
  final CheckoutRepository repository;
  CancelCheckoutUseCase(this.repository);
  @override
  Future<Either<Failure, Unit>> call(
      CancelCheckoutParams params) async {
    return await repository.cancelCheckout(params);
  }
}

class CancelCheckoutParams {
  String orderId;
  CancelCheckoutParams({
    required this.orderId,
  });
}
