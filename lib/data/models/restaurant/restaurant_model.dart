import 'dart:convert';

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
      id: json['id'] as String,
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

class AddressModel extends Address {
  const AddressModel({super.addressText, super.city, super.coordinates});

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      addressText: json['addressText'] as String?,
      city: json['city'] as String?,
      coordinates: CoordinatesModel.fromJson(json['coordinates'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (addressText != null) data['addressText'] = addressText;
    if (city != null) data['city'] = city;
    if (coordinates != null) data['coordinates'] = coordinates;
    return data;
  }
}

class CoordinatesModel extends Coordinates {
  const CoordinatesModel({super.type, super.coordinates});

  factory CoordinatesModel.fromJson(Map<String, dynamic> json) {
    return CoordinatesModel(
      type: json['type'] as String?,
      coordinates:
          json['coordinates'] != null
              ? List<double>.from(
                (json['coordinates'] as List).map((e) => (e as num).toDouble()),
              )
              : <double>[],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (type != null) data['type'] = type;
    if (coordinates != null) data['coordinates'] = coordinates;
    return data;
  }
}
