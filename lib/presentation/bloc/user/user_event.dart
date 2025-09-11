import 'package:flutter/material.dart';
import 'package:foody_licious/domain/usecase/user/update_user_usecase.dart';

@immutable
abstract class UserEvent {}

class CheckUser extends UserEvent {}

class UpdateUser extends UserEvent {
  final UpdateUserParams params;
  UpdateUser(this.params);
}

class UpdateUserLocation extends UserEvent {}

class DeleteUser extends UserEvent {}
