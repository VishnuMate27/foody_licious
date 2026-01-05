import 'package:dartz/dartz.dart';
import 'package:foody_licious/core/error/failures.dart';
import 'package:foody_licious/core/usecase/usecase.dart';
import 'package:foody_licious/domain/entities/cart/cartItem.dart';
import 'package:foody_licious/domain/repositories/cart_repository.dart';

class IncreaseItemQuantityUseCase
    implements UseCase<CartItem, IncreaseItemQuantityParams> {
  final CartRepository repository;
  IncreaseItemQuantityUseCase(this.repository);
  @override
  Future<Either<Failure, CartItem>> call(IncreaseItemQuantityParams params) {
    return repository.increaseItemQuantity(params);
  }
}

class IncreaseItemQuantityParams {
  String menuItemId;
  String? cartId;
  String? userId;
  IncreaseItemQuantityParams({
    required this.menuItemId,
    this.cartId,
    this.userId,
  });
}
