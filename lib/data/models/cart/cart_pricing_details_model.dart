import 'dart:convert';
import 'package:foody_licious/domain/entities/cart/cartPricing.dart';

CartPricingDetailsModel cartPricingDetailsModelFromJson(String str) =>
    CartPricingDetailsModel.fromJson(json.decode(str));

String cartPricingDetailsModelToJson(CartPricingDetailsModel data) =>
    json.encode(data.toJson());

class CartPricingDetailsModel extends CartPricingDetails {
  const CartPricingDetailsModel({
    required super.totalCartAmount,
    required super.gstCharges,
    required super.platformFees,
    required super.deliveryCharges,
    required super.grandTotalAmount,
  });

  factory CartPricingDetailsModel.fromJson(Map<String, dynamic> json) {
    print("CartPricingDetailsModel $json");
    return CartPricingDetailsModel(
      totalCartAmount: (json["totalCartAmount"] as num).toDouble(),
      gstCharges: (json["gstCharges"] as num).toDouble(),
      platformFees: (json["platformFees"] as num).toDouble(),
      deliveryCharges: (json["deliveryCharges"] as num).toDouble(),
      grandTotalAmount: (json["grandTotalAmount"] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "totalCartAmount": totalCartAmount,
      "gstCharges": gstCharges,
      "platformFees": platformFees,
      "deliveryCharges": deliveryCharges,
      "grandTotalAmount": grandTotalAmount,
    };
  }
}
