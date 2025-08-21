import 'dart:convert';

import 'user_model.dart';

AuthenticationResponseModel authenticationResponseModelFromJson(String str) =>
    AuthenticationResponseModel.fromJson(json.decode(str));

String authenticationResponseModelToJson(AuthenticationResponseModel data) =>
    json.encode(data.toJson());

class AuthenticationResponseModel {
  final UserModel user;

  const AuthenticationResponseModel({
    required this.user,
  });

  factory AuthenticationResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthenticationResponseModel(
      user: UserModel.fromJson(json["user"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "user": user.toJson(),
      };
}
