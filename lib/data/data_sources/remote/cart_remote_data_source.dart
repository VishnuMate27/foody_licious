import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:foody_licious/core/constant/strings.dart';
import 'package:foody_licious/core/error/failures.dart';
import 'package:foody_licious/data/models/cart/cart_item_response_model.dart';
import 'package:foody_licious/data/models/cart/cart_items_response_model.dart';
import 'package:foody_licious/data/models/cart/cart_pricing_details_response_model.dart';
import 'package:foody_licious/data/models/cart/cart_response_model.dart';
import 'package:foody_licious/domain/usecase/cart/add_item_to_cart_usecase.dart';
import 'package:foody_licious/domain/usecase/cart/decrease_item_quantity_usecase.dart';
import 'package:foody_licious/domain/usecase/cart/delete_item_in_cart_usecase.dart';
import 'package:foody_licious/domain/usecase/cart/get_all_cart_item_usecase.dart';
import 'package:foody_licious/domain/usecase/cart/get_cart_pricing_details_usecase.dart';
import 'package:foody_licious/domain/usecase/cart/increase_item_quantity_usecase.dart';
import 'package:http/http.dart' as http;

abstract class CartRemoteDataSource {
  Future<CartItemsResponseModel> getAllCartItem(GetAllCartItemParams params);
  Future<CartPricingDetailsResponseModel> getCartPricingDetails(
      GetCartPricingDetailsParams params);
  Future<Unit> addItemToCart(AddItemToCartParams params);
  Future<Unit> deleteItemInCart(DeleteItemInCartParams params);
  Future<CartItemResponseModel> increaseItemQuantity(
      IncreaseItemQuantityParams params);
  Future<CartItemResponseModel> decreaseItemQuantity(
      DecreaseItemQuantityParams params);
}

class CartRemoteDataSourceImpl extends CartRemoteDataSource {
  final http.Client client;
  CartRemoteDataSourceImpl({required this.client});

  @override
  Future<CartItemsResponseModel> getAllCartItem(GetAllCartItemParams params) {
    return sendGetAllCartItemRequest(params);
  }

  @override
  Future<CartPricingDetailsResponseModel> getCartPricingDetails(GetCartPricingDetailsParams params) {
    return sendGetCartPricingDetailsRequest(params);
  }

  @override
  Future<Unit> addItemToCart(AddItemToCartParams params) {
    return sendAddItemToCartRequest(params);
  }

  @override
  Future<Unit> deleteItemInCart(DeleteItemInCartParams params) {
    return sendDeleteItemInCartRequest(params);
  }

  @override
  Future<CartItemResponseModel> increaseItemQuantity(
      IncreaseItemQuantityParams params) {
    return sendIncreaseItemQuantityRequest(params);
  }

  @override
  Future<CartItemResponseModel> decreaseItemQuantity(
      DecreaseItemQuantityParams params) {
    return sendDecreaseItemQuantityRequest(params);
  }

  Future<CartItemsResponseModel> sendGetAllCartItemRequest(
      GetAllCartItemParams params) async {
    final response = await client.get(
      Uri.parse(
        "$kBaseUrl/api/users/cart/allMenuItems?userId=${params.userId}&page=${params.page}&page_size=${params.limit}",
      ),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return cartItemsResponseModelFromJson(response.body);
    } else if (response.statusCode == 400) {
      throw CredentialFailure();
    } else if (response.statusCode == 404) {
      throw CartNotExistsFailure();
    } else {
      throw ServerFailure();
    }
  }

  Future<CartPricingDetailsResponseModel> sendGetCartPricingDetailsRequest(
      GetCartPricingDetailsParams params) async {
    final response = await client.get(
      Uri.parse(
        "$kBaseUrl/api/users/cart/getCartPricingDetails?userId=${params.userId}",
      ),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return cartPricingDetailsResponseModelFromJson(response.body);
    } else if (response.statusCode == 400) {
      throw CredentialFailure();
    } else if (response.statusCode == 404) {
      throw CartNotExistsFailure();
    } else {
      throw ServerFailure();
    }
  }

  Future<Unit> sendAddItemToCartRequest(AddItemToCartParams params) async {
    final requestBody = json.encode({
      "menuItemId": params.menuItemId,
      "restaurantId": params.restaurantId,
      "userId": params.userId
    });

    final response =
        await client.post(Uri.parse("$kBaseUrl/api/users/cart/addNewItem"),
            headers: {
              'Content-Type': 'application/json',
            },
            body: requestBody);

    if (response.statusCode == 200) {
      return unit;
    } else if (response.statusCode == 400) {
      throw CredentialFailure();
    } else if (response.statusCode == 404) {
      throw MenuItemNotExistsFailure();
    } else if (response.statusCode == 405) {
      throw CartLockedFailure();
    } else if (response.statusCode == 409) {
      throw MenuItemOutOfStockFailure();
    } else {
      throw ServerFailure();
    }
  }

  Future<Unit> sendDeleteItemInCartRequest(
      DeleteItemInCartParams params) async {
    final requestBody =
        json.encode({"menuItemId": params.menuItemId, "userId": params.userId});

    final response = await client.delete(
      Uri.parse("$kBaseUrl/api/users/cart/deleteItem"),
      headers: {
        'Content-Type': 'application/json',
      },
      body: requestBody,
    );

    if (response.statusCode == 200) {
      return unit;
    } else if (response.statusCode == 400) {
      throw CredentialFailure();
    } else if (response.statusCode == 404) {
      throw MenuItemNotExistsFailure();
      // TODO: Implement this
      // throw CartNotExistsFailure();
    } else if (response.statusCode == 405) {
      throw CartLockedFailure();
    } else {
      throw ServerFailure();
    }
  }

  Future<CartItemResponseModel> sendIncreaseItemQuantityRequest(
      IncreaseItemQuantityParams params) async {
    final requestBody =
        json.encode({"menuItemId": params.menuItemId, "userId": params.userId});

    final response = await client.put(
      Uri.parse("$kBaseUrl/api/users/cart/increaseItemQuantity"),
      headers: {
        'Content-Type': 'application/json',
      },
      body: requestBody,
    );

    if (response.statusCode == 200) {
      return cartItemResponseModelFromJson(response.body);
    } else if (response.statusCode == 400) {
      throw CredentialFailure();
    } else if (response.statusCode == 404) {
      throw MenuItemNotExistsFailure();
      // TODO: Implement this
      // throw CartNotExistsFailure();
    } else if (response.statusCode == 405) {
      throw CartLockedFailure();
    } else if (response.statusCode == 409) {
      throw MenuItemOutOfStockFailure();
    } else {
      throw ServerFailure();
    }
  }

  Future<CartItemResponseModel> sendDecreaseItemQuantityRequest(
      DecreaseItemQuantityParams params) async {
    final requestBody =
        json.encode({"menuItemId": params.menuItemId, "userId": params.userId});

    final response = await client.put(
      Uri.parse("$kBaseUrl/api/users/cart/decreaseItemQuantity"),
      headers: {
        'Content-Type': 'application/json',
      },
      body: requestBody,
    );

    if (response.statusCode == 200) {
      return cartItemResponseModelFromJson(response.body);
    } else if (response.statusCode == 400) {
      throw CredentialFailure();
    } else if (response.statusCode == 404) {
      throw MenuItemNotExistsFailure();
      // TODO: Implement this
      // throw CartNotExistsFailure();
    } else if (response.statusCode == 405) {
      throw CartLockedFailure();
    } else if (response.statusCode == 409) {
      throw MenuItemOutOfStockFailure();
    } else {
      throw ServerFailure();
    }
  }
}
