import 'package:dartz/dartz.dart';
import 'package:foody_licious/core/error/failures.dart';
import 'package:foody_licious/core/usecase/usecase.dart';
import 'package:foody_licious/domain/entities/cart/cartPricing.dart';
import 'package:foody_licious/domain/repositories/cart_repository.dart';

class GetCartPricingDetailsUseCase
    implements UseCase<CartPricingDetails, GetCartPricingDetailsParams> {
  final CartRepository repository;
  GetCartPricingDetailsUseCase(this.repository);
  @override
  Future<Either<Failure, CartPricingDetails>> call(
      GetCartPricingDetailsParams params) {
    return repository.getCartPricingDetails(params);
  }
}

class GetCartPricingDetailsParams {
  String? userId;
  GetCartPricingDetailsParams({
    this.userId,
  });
}
