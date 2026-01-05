import 'package:dartz/dartz.dart';
import 'package:foody_licious/core/error/failures.dart';
import 'package:foody_licious/core/usecase/usecase.dart';
import 'package:foody_licious/domain/entities/cart/cartItem.dart';
import 'package:foody_licious/domain/repositories/cart_repository.dart';

class DecreaseItemQuantityUseCase
    implements UseCase<CartItem?, DecreaseItemQuantityParams> {
  final CartRepository repository;
  DecreaseItemQuantityUseCase(this.repository);
  @override
  Future<Either<Failure, CartItem?>> call(
      DecreaseItemQuantityParams params) async {
    return await repository.decreaseItemQuantity(params);
  }
}

class DecreaseItemQuantityParams {
  String? cartId;
  String? userId;
  String menuItemId;
  DecreaseItemQuantityParams({
    this.cartId,
    this.userId,
    required this.menuItemId,
  });
}
