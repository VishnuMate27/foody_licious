part of 'checkout_bloc.dart';

abstract class CheckoutEvent {}

// ignore: must_be_immutable
class PlaceOrder extends CheckoutEvent {
  PlaceOrderParams params;
  PlaceOrder(this.params);
}

class CancelCheckout extends CheckoutEvent {
  CancelCheckoutParams params;
  CancelCheckout(this.params);
}

