import 'dart:convert';
import 'package:foody_licious/domain/entities/menuItem/menuItem.dart';

MenuItemModel menuItemModelFromJson(String str) =>
    MenuItemModel.fromJson(json.decode(str));

String menuItemModelToJson(MenuItemModel data) =>
    json.encode(data.toJson());

class MenuItemModel extends MenuItem {
  const MenuItemModel({
    required super.id,
    required super.restaurantId,
    required super.name,
    required super.price,
    required super.availableQuantity,
    super.restaurantName,
    super.description,
    super.images,
    super.ingredients,
  });

  factory MenuItemModel.fromJson(Map<String, dynamic> json) {
    return MenuItemModel(
      id: json['id'] ?? '',
      restaurantId: json['restaurantId'] ?? '',
      name: json['name'] ?? '',
      price: json['price'] is int
          ? json['price']
          : int.tryParse(json['price'].toString()) ?? 0,
      availableQuantity: json['availableQuantity'] is int
          ? json['availableQuantity']
          : int.tryParse(json['availableQuantity'].toString()) ?? 0, 
      restaurantName: json['restaurantName'] ?? '',       
      description: json['description'],
      images: json['images'] != null
          ? List<String>.from(json['images'])
          : <String>[], // ✅ safely defaults to empty list
      ingredients: json['ingredients'] != null
          ? List<String>.from(json['ingredients'])
          : <String>[], // ✅ safely defaults to empty list
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "restaurantId": restaurantId,
      "name": name,
      "price": price,
      "availableQuantity": availableQuantity,
      "restaurantName": restaurantName,
      "description": description,
      "images": images ?? [],
      "ingredients": ingredients ?? [],
    };
  }
}
