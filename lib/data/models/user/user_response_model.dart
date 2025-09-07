import 'dart:convert';

import 'user_model.dart';

UserResponseModel userResponseModelFromJson(String str) =>
    UserResponseModel.fromJson(json.decode(str));

String userResponseModelToJson(UserResponseModel data) =>
    json.encode(data.toJson());

class UserResponseModel {
  final UserModel user;

  const UserResponseModel({
    required this.user,
  });

  factory UserResponseModel.fromJson(Map<String, dynamic> json) {
    return UserResponseModel(
      user: UserModel.fromJson(json["user"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "user": user.toJson(),
      };
}
