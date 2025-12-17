part of 'restaurant_bloc.dart';

abstract class RestaurantState extends Equatable {}

class RestaurantInitial extends RestaurantState {
  @override
  List<Object?> get props => [];
}

class FetchingRestaurantDetails extends RestaurantState {
  @override
  List<Object?> get props => [];
}

// ignore: must_be_immutable
class RestaurantDetailsFetchSuccess extends RestaurantState {
  Restaurant restaurant;
  RestaurantDetailsFetchSuccess(this.restaurant);
  @override
  List<Object?> get props => [restaurant];
}

// ignore: must_be_immutable
class RestaurantDetailsFetchFail extends RestaurantState {
  Failure failure;
  RestaurantDetailsFetchFail(this.failure);
  @override
  List<Object?> get props => [failure];
}
