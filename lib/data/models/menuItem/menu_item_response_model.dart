import 'dart:convert';
import 'package:foody_licious/data/models/menuItem/menu_item_model.dart';

MenuItemResponseModel menuItemResponseModelFromJson(String str) =>
    MenuItemResponseModel.fromJson(json.decode(str));

String menuItemResponseModelToJson(MenuItemResponseModel data) =>
    json.encode(data.toJson());

class MenuItemResponseModel {
  final MenuItemModel menuItemResponseModel;
  const MenuItemResponseModel({required this.menuItemResponseModel});

  factory MenuItemResponseModel.fromJson(Map<String, dynamic> json) {
    return MenuItemResponseModel(menuItemResponseModel: MenuItemModel.fromJson(json['menuItem']));
  }

  Map<String, dynamic> toJson() {
    return {"menuItem": menuItemResponseModel};
  }
}
