part of 'checkout_bloc.dart';

abstract class CheckoutState extends Equatable {}

class CheckoutInitial extends CheckoutState {
  @override
  List<Object> get props => [];
}

// PlaceOrder
class PlaceOrderLoading extends CheckoutState {
  @override
  List<Object> get props => [];
}

class PlaceOrderSuccess extends CheckoutState {
  final PlaceOrderDetails placeOrderDetails;
  PlaceOrderSuccess(this.placeOrderDetails);
  @override
  List<Object> get props => [placeOrderDetails];
}

class PlaceOrderFailed extends CheckoutState {
  final Failure failure;
  PlaceOrderFailed(this.failure);
  @override
  List<Object> get props => [failure];
}

// CancelCheckout
class CancelCheckoutLoading extends CheckoutState {
  @override
  List<Object> get props => [];
}

class CancelCheckoutSuccess extends CheckoutState {
  @override
  List<Object> get props => [];
}

class CancelCheckoutFailed extends CheckoutState {
  final Failure failure;
  CancelCheckoutFailed(this.failure);
  @override
  List<Object> get props => [failure];
}
