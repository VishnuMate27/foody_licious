import 'dart:convert';
import 'package:foody_licious/domain/entities/user/user.dart';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.name,
    super.email,
    super.phone,
    super.address,
    super.orderHistory,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      address: AddressModel.fromJson(json['address'] ?? {}),
      orderHistory: List<String>.from(json['orderHistory'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'address': address!.toJson(),
      'orderHistory': orderHistory,
    };
  }
}

class AddressModel extends Address {
  const AddressModel({
    super.addressText,
    super.coordinates,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      addressText: json['addressText'] as String?,
      coordinates: CoordinatesModel.fromJson(json['coordinates'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'addressText': addressText,
      'coordinates': coordinates,
    };
  }
}

class CoordinatesModel extends Coordinates {
  const CoordinatesModel({
    super.type,
    super.coordinates,
  });

  factory CoordinatesModel.fromJson(Map<String, dynamic> json) {
    return CoordinatesModel(
      type: json['type'] as String?,
      coordinates: json['coordinates'] != null
          ? List<double>.from(
              (json['coordinates'] as List).map((e) => (e as num).toDouble()),
            )
          : <double>[],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'coordinates': coordinates,
    };
  }
}
