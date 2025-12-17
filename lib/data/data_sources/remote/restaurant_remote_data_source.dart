import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:foody_licious/core/constant/strings.dart';
import 'package:foody_licious/core/error/failures.dart';
import 'package:foody_licious/data/models/restaurant/restaurant_response_model.dart';
import 'package:foody_licious/data/services/location_service.dart';
import 'package:foody_licious/domain/entities/restaurant/restaurant.dart';
import 'package:foody_licious/domain/usecase/restaurant/get_restaurant_details_usecase.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';

abstract class RestaurantRemoteDataSource {
  Future<RestaurantResponseModel> getRestaurantDetails(
      GetRestaurantDetailsParams params);
}

class RestaurantRemoteDataSourceImpl extends RestaurantRemoteDataSource {
  final http.Client client;
  Restaurant? restaurant;
  RestaurantRemoteDataSourceImpl({
    required this.client,
  });

  @override
  Future<RestaurantResponseModel> getRestaurantDetails(
    GetRestaurantDetailsParams params,
  ) async {
    return await _sendGetRestaurantDetailsRequest(params);
  }

  Future<RestaurantResponseModel> _sendGetRestaurantDetailsRequest(
    GetRestaurantDetailsParams params,
  ) async {
    final response = await client.get(
      Uri.parse(
        "$kBaseUrl/api/users/restaurant/restaurantDetails?restaurant_id=${params.restaurantId}",
      ),
    );
    if (response.statusCode == 200) {
      return restaurantResponseModelFromJson(response.body);
    } else if (response.statusCode == 400) {
      throw CredentialFailure();
    } else if (response.statusCode == 404) {
      throw RestaurantNotExistsFailure();
    } else {
      throw ServerFailure();
    }
  }
}
