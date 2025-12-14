import 'package:equatable/equatable.dart';

class MenuItem extends Equatable {
  final String id;
  final String restaurantId;
  final String name;
  final int price;
  final int availableQuantity;
  final String? restaurantName;
  final String? description;
  final List<String>? images;
  final List<String>? ingredients;

  const MenuItem({
    required this.id,
    required this.restaurantId,
    required this.name,
    required this.price,
    required this.availableQuantity,
    this.restaurantName,
    this.description,
    this.images,
    this.ingredients,
  });

  MenuItem copyWith({
    String? id,
    String? restaurantId,
    String? name,
    int? price,
    int? availableQuantity,
    String? restaurantName,
    String? description,
    List<String>? images,
    List<String>? ingredients,
  }) {
    return MenuItem(
      id: id ?? this.id,
      restaurantId: restaurantId ?? this.restaurantId,
      name: name ?? this.name,
      price: price ?? this.price,
      availableQuantity: availableQuantity ?? this.availableQuantity,
      restaurantName: restaurantName ?? this.restaurantName,
      description: description ?? this.description,
      images: images ?? this.images,
      ingredients: ingredients ?? this.ingredients,
    );
  }

  @override
  List<Object?> get props => [
    id,
    restaurantId,
    name,
    price,
    availableQuantity,
    restaurantName,
    description,
    images,
    ingredients,
  ];
}
