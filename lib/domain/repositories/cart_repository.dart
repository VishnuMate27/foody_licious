import 'package:dartz/dartz.dart';
import 'package:foody_licious/core/error/failures.dart';
import 'package:foody_licious/domain/entities/cart/cartItem.dart';
import 'package:foody_licious/domain/usecase/cart/add_item_to_cart_usecase.dart';
import 'package:foody_licious/domain/usecase/cart/decrease_item_quantity_usecase.dart';
import 'package:foody_licious/domain/usecase/cart/delete_item_in_cart_usecase.dart';
import 'package:foody_licious/domain/usecase/cart/get_all_cart_item_usecase.dart';
import 'package:foody_licious/domain/usecase/cart/increase_item_quantity_usecase.dart';

abstract class CartRepository {
  Future<Either<Failure, Unit>> addItemToCart(AddItemToCartParams params);
  Future<Either<Failure, Unit>> deleteItemInCart(DeleteItemInCartParams params);
  Future<Either<Failure, CartItem>> increaseItemQuantity(IncreaseItemQuantityParams params);
  Future<Either<Failure, CartItem?>> decreaseItemQuantity(DecreaseItemQuantityParams params);
  Future<Either<Failure, List<CartItem>>> getAllCartItem(GetAllCartItemParams params);
}
