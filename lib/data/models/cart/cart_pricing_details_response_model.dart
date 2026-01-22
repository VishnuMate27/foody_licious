import 'dart:convert';

import 'package:foody_licious/data/models/cart/cart_pricing_details_model.dart';

CartPricingDetailsResponseModel cartPricingDetailsResponseModelFromJson(
    String str) {
  return CartPricingDetailsResponseModel.fromJson(json.decode(str));
}

String cartPricingResponseModelToJson(CartPricingDetailsResponseModel data) =>
    json.encode(data.toJson());

class CartPricingDetailsResponseModel {
  final CartPricingDetailsModel? cartPricingDetails;

  const CartPricingDetailsResponseModel({this.cartPricingDetails});

  factory CartPricingDetailsResponseModel.fromJson(Map<String, dynamic> json) {
    print(json);
    return CartPricingDetailsResponseModel(
      cartPricingDetails: json['pricing'] == null
          ? null
          : CartPricingDetailsModel.fromJson(
              json['pricing'] as Map<String, dynamic>,
            ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "pricing": cartPricingDetails?.toJson(),
    };
  }
}
