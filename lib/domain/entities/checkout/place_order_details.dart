import 'package:equatable/equatable.dart';

class PlaceOrderDetails extends Equatable {
  final String orderId;
  final String paymentId;
  final double amount;

  const PlaceOrderDetails(
      {required this.orderId, required this.paymentId, required this.amount});

  PlaceOrderDetails copyWith(
      {String? orderId, String? paymentId, double? amount}) {
    return PlaceOrderDetails(
      orderId: orderId ?? this.orderId,
      paymentId: paymentId ?? this.paymentId,
      amount: amount ?? this.amount,
    );
  }

  @override
  List<Object?> get props => [orderId, amount];
}
