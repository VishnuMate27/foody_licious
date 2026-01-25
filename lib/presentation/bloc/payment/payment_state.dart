part of 'payment_bloc.dart';

abstract class PaymentState extends Equatable {}

class PaymentInitial extends PaymentState {
  @override
  List<Object> get props => [];
}

class CompletePaymentLoading extends PaymentState {
  @override
  List<Object> get props => [];
}

class CompletePaymentSuccess extends PaymentState {
  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class CompletePaymentFailed extends PaymentState {
  Failure failure;
  CompletePaymentFailed(this.failure);
  @override
  List<Object> get props => [failure];
}
