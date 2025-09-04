import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:foody_licious/core/error/failures.dart';
import 'package:foody_licious/domain/entities/user/user.dart';

@immutable
abstract class UserState extends Equatable {}

class UserInitial extends UserState {
  @override
  List<Object> get props => [];
}

class UserLoading extends UserState {
  @override
  List<Object> get props => [];
}

class UserAuthenticated extends UserState {
  final User user;
  UserAuthenticated(this.user);
  @override
  List<Object> get props => [user];
}

class UserUnauthenticated extends UserState {
  final Failure failure;
  UserUnauthenticated(this.failure);
  @override
  List<Object> get props => [];
}
