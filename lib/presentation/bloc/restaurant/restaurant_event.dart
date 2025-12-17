part of 'restaurant_bloc.dart';

class RestaurantEvent {}

class FetchRestaurantDetails extends RestaurantEvent {
  final GetRestaurantDetailsParams params;
  FetchRestaurantDetails(this.params);
}
