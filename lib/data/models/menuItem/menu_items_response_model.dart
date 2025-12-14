import 'dart:convert';
import 'package:foody_licious/data/models/menuItem/menu_item_model.dart';

MenuItemsResponseModel menuItemsResponseModelFromJson(String str) => MenuItemsResponseModel.fromJson(json.decode(str));

String menuItemsResponseModeltoJson(MenuItemsResponseModel data) =>
    json.encode(data.toJson());

class MenuItemsResponseModel {
  final List<MenuItemModel> menuItems;

  const MenuItemsResponseModel({required this.menuItems});

  factory MenuItemsResponseModel.fromJson(Map<String, dynamic> json) {
    final items = json['menuItems'] as List;
    return MenuItemsResponseModel(
      menuItems: items.map((e) => MenuItemModel.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {"menuItems": menuItems.map((e) => e.toJson()).toList()};
  }
}
