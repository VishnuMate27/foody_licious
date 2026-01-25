import 'dart:convert';
import 'package:foody_licious/domain/entities/checkout/place_order_details.dart';

PlaceOrderModel placeOrderModelFromJson(String str) =>
    PlaceOrderModel.fromJson(json.decode(str));

String placeOrderModelToJson(PlaceOrderModel data) =>
    json.encode(data.toJson());

class PlaceOrderModel extends PlaceOrderDetails {
  const PlaceOrderModel({
    required super.orderId,
    required super.paymentId,
    required super.amount,
  });

  factory PlaceOrderModel.fromJson(Map<String, dynamic> json) {
    return PlaceOrderModel(
      orderId: json['orderId'],
      paymentId: json['paymentId'],
      amount: json['amount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "orderId": orderId,
      "paymentId": paymentId,
      "amount": amount,
    };
  }
}
