part of 'cart_bloc.dart';

@immutable
abstract class CartEvent {}

class GetAllCartItem extends CartEvent {
  final GetAllCartItemParams params;
  GetAllCartItem(this.params);
}

class AddItemToCart extends CartEvent {
  final AddItemToCartParams params;
  AddItemToCart(this.params);
}

class DeleteItemInCart extends CartEvent {
  final DeleteItemInCartParams params;
  DeleteItemInCart(this.params);
}

class IncreaseItemQuantity extends CartEvent {
  final IncreaseItemQuantityParams params;
  IncreaseItemQuantity(this.params);
}

class DecreaseItemQuantity extends CartEvent {
  final DecreaseItemQuantityParams params;
  DecreaseItemQuantity(this.params);
}