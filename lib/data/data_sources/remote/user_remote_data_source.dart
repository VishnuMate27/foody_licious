import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:foody_licious/core/constant/strings.dart';
import 'package:foody_licious/core/error/failures.dart';
import 'package:foody_licious/data/models/user/user_response_model.dart';
import 'package:foody_licious/domain/entities/user/user.dart';
import 'package:foody_licious/domain/usecase/user/update_user_usecase.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as client;
import 'package:permission_handler/permission_handler.dart';

abstract class UserRemoteDataSource {
  // User checkUser();
  Future<UserResponseModel> updateUser(UpdateUserParams user);
  Future<UserResponseModel> updateUserLocation(String userId);
  Future<Unit> deleteUser(String userId);
}

class UserRemoteDataSourceImpl extends UserRemoteDataSource {
  User? user;
  UserRemoteDataSourceImpl();

  // @override
  // User checkUser() {
  //   User user;
  //   user = firebaseAuth.currentUser!;
  //   return user;
  // }

  @override
  Future<UserResponseModel> updateUser(UpdateUserParams params) async {
    return await _sendUpdateUserRequest(params);
  }

  @override
  Future<Unit> deleteUser(String userId) async {
    return await _sendDeleteUserRequest(userId);
  }

  @override
  Future<UserResponseModel> updateUserLocation(String userId) async {
    Position position = await _determinePosition();
    debugPrint(
        "latitude: ${position.latitude} longitude:${position.longitude}");
    return await _sendUpdateLocationRequest(userId, position);
  }

  Future<Unit> _sendDeleteUserRequest(String userId) async {
    final requestBody = json.encode({
      "id": userId,
    });

    final response = await client.post(
      Uri.parse('$kBaseUrl/api/users/delete_user'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: requestBody,
    );

    if (response.statusCode == 200) {
      return unit;
    } else if (response.statusCode == 400 || response.statusCode == 401) {
      throw CredentialFailure();
    } else if (response.statusCode == 404) {
      throw UserNotExistsFailure();
    } else {
      throw ServerFailure();
    }
  }

  Future<UserResponseModel> _sendUpdateUserRequest(
      UpdateUserParams params) async {
    final requestBody = jsonEncode(params.toJson());
    final response = await client.put(
      Uri.parse('$kBaseUrl/api/users/profile'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: requestBody,
    );

    if (response.statusCode == 200) {
      return userResponseModelFromJson(response.body);
    } else if (response.statusCode == 400 || response.statusCode == 401) {
      throw CredentialFailure();
    } else {
      throw ServerFailure();
    }
  }

  Future<UserResponseModel> _sendUpdateLocationRequest(
      String userId, Position position) async {
    final requestBody = json.encode({
      "id": userId,
      "address": {
        "coordinates": {
          "type": "Point",
          "coordinates": [position.latitude, position.longitude]
        }
      }
    });

    final response = await client.put(
      Uri.parse('$kBaseUrl/api/users/profile'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: requestBody,
    );

    if (response.statusCode == 200) {
      return userResponseModelFromJson(response.body);
    } else if (response.statusCode == 400 || response.statusCode == 401) {
      throw CredentialFailure();
    } else {
      throw ServerFailure();
    }
  }

  Future<Position> _determinePosition() async {
    Position userLocation;
    // 1. Check if services are enabled
    final serviceStatus = await Permission.location.serviceStatus;
    if (!serviceStatus.isEnabled) {
      throw LocationServicesDisabledFailure();
    }

    // 2. Check permission status
    var status = await Permission.location.status;

    if (status.isDenied) {
      status = await Permission.location.request();
      if (status.isDenied) {
        throw LocationPermissionDeniedFailure();
      }
    }

    if (status.isPermanentlyDenied) {
      throw LocationPermissionPermanentlyDeniedFailure();
    }

    // 3. Fetch location
    userLocation = await Geolocator.getCurrentPosition();
    return userLocation;
  }
}
