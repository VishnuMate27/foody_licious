import 'dart:convert';

import 'package:foody_licious/data/models/user/user_model.dart';
import 'package:foody_licious/domain/entities/restaurant/restaurant.dart';

RestaurantModel restaurantModelFromJson(String str) =>
    RestaurantModel.fromJson(json.decode(str));

String restaurantModelToJson(RestaurantModel data) =>
    json.encode(data.toJson());

class RestaurantModel extends Restaurant {
  const RestaurantModel({
    required super.id,
    required super.ownerName,
    super.name,
    super.email,
    super.phone,
    super.authProvider,
    super.address,
    super.photoUrl,
    super.description,
    super.menuItems,
    super.receivedOrders,
    super.receivedFeedback,
  });

  factory RestaurantModel.fromJson(Map<String, dynamic> json) {
    return RestaurantModel(
      id: json['_id'] as String,
      ownerName: json['ownerName'] as String,
      name: json['name'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      authProvider: json['authProvider'] as String?,
      address: AddressModel.fromJson(json['address'] ?? {}),
      photoUrl: json['photoUrl'] as String?,
      description: json['description'] as String?,
      menuItems: List<String>.from(json['menuItems'] ?? {}),
      receivedOrders: List<String>.from(json['receivedOrders'] ?? {}),
      receivedFeedback: List<String>.from(json['receivedFeedback'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ownerName': ownerName,
      'name': name,
      'email': email,
      'phone': phone,
      'authProvider': authProvider,
      'address': address != null ? (address as AddressModel).toJson() : null,
      'photoUrl': photoUrl,
      'description': description,
      'menuItems': menuItems,
      'receivedOrders': receivedOrders,
      'receivedFeedback': receivedFeedback,
    };
  }
}