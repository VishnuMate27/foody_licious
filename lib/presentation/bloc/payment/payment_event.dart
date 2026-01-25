part of 'payment_bloc.dart';

abstract class PaymentEvent {}

class CompletePayment extends PaymentEvent {
  final PaymentParams params;
  CompletePayment(this.params);
}
