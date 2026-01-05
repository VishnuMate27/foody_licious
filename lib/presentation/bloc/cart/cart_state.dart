part of 'cart_bloc.dart';

abstract class CartState extends Equatable {}

// Initial
class CartInitial extends CartState {
  @override
  List<Object> get props => [];
}

// GetAllCartItem
class GetAllCartItemLoading extends CartState {
  @override
  List<Object> get props => [];
}

class GetAllCartItemSuccess extends CartState {
  final List<CartItem> cartItems;
  GetAllCartItemSuccess(this.cartItems);
  @override
  List<Object> get props => [cartItems];
}

class GetAllCartItemFailed extends CartState {
  final Failure failure;
  GetAllCartItemFailed(this.failure);
  @override
  List<Object> get props => [];
}

// AddItemToCart
class AddItemToCartLoading extends CartState {
  @override
  List<Object> get props => [];
}

class AddItemToCartSuccess extends CartState {
  final Unit unit;
  AddItemToCartSuccess(this.unit);
  @override
  List<Object> get props => [unit];
}

class AddItemToCartFailed extends CartState {
  final Failure failure;
  AddItemToCartFailed(this.failure);
  @override
  List<Object> get props => [];
}

// DeleteItemInCart
class DeleteItemInCartLoading extends CartState {
  @override
  List<Object> get props => [];
}

class DeleteItemInCartSuccess extends CartState {
  final Unit unit;
  DeleteItemInCartSuccess(this.unit);
  @override
  List<Object> get props => [unit];
}

class DeleteItemInCartFailed extends CartState {
  final Failure failure;
  DeleteItemInCartFailed(this.failure);
  @override
  List<Object> get props => [];
}

// IncreaseItemQuantity
class IncreaseItemQuantityLoading extends CartState {
  @override
  List<Object> get props => [];
}

// class IncreaseItemQuantitySuccess extends CartState {
//   final Unit unit;
//   IncreaseItemQuantitySuccess(this.unit);
//   @override
//   List<Object> get props => [unit];
// }

class IncreaseItemQuantityFailed extends CartState {
  final Failure failure;
  IncreaseItemQuantityFailed(this.failure);
  @override
  List<Object> get props => [];
}

// DecreaseItemQuantity
class DecreaseItemQuantityLoading extends CartState {
  @override
  List<Object> get props => [];
}

// class DecreaseItemQuantitySuccess extends CartState {
//   final Unit unit;
//   DecreaseItemQuantitySuccess(this.unit);
//   @override
//   List<Object> get props => [unit];
// }

class DecreaseItemQuantityFailed extends CartState {
  final Failure failure;
  DecreaseItemQuantityFailed(this.failure);
  @override
  List<Object> get props => [];
}
