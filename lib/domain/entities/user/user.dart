import 'package:equatable/equatable.dart';
import 'package:foody_licious/data/models/user/user_model.dart';

class User extends Equatable {
  final String id;
  final String name;
  final String? email;
  final String? phone;
  final AddressModel? address;
  final List<String>? orderHistory;

  const User({
    required this.id,
    required this.name,
    this.email,
    this.phone,
    this.address,
    this.orderHistory,
  });

  @override
  List<Object?> get props => [id, name, email, phone, address, orderHistory];
}

class Address extends Equatable {
  final String? addressText;
  final Coordinates? coordinates;

  const Address({
    this.addressText,
    this.coordinates,
  });

  @override
  List<Object?> get props => [addressText, coordinates];
}

class Coordinates extends Equatable {
  final String? type;
  final List<double>? coordinates;

  const Coordinates({
    this.type,
    this.coordinates,
  });

  @override
  List<Object?> get props => [type, coordinates];
}