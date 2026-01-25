part of 'payment_bloc.dart';

abstract class PaymentState extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class PaymentInitial extends PaymentState {}

class CompletePaymentLoading extends PaymentState {}

class CompletePaymentSuccess extends PaymentState {}

// ignore: must_be_immutable
class CompletePaymentFailed extends PaymentState {
  Failure failure;
  CompletePaymentFailed(this.failure);
  @override
  List<Object> get props => [failure];
}
