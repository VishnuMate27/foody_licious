import 'dart:convert';

import 'restaurant_model.dart';

RestaurantResponseModel restaurantResponseModelFromJson(String str) =>
    RestaurantResponseModel.fromJson(json.decode(str));

String restaurantResponseModelToJson(RestaurantResponseModel data) =>
    json.encode(data.toJson());

class RestaurantResponseModel {
  final RestaurantModel restaurant;

  const RestaurantResponseModel({
    required this.restaurant,
  });

  factory RestaurantResponseModel.fromJson(Map<String, dynamic> json) {
    return RestaurantResponseModel(
      restaurant: RestaurantModel.fromJson(json["restaurant"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "restaurant": restaurant.toJson(),
      };
}
