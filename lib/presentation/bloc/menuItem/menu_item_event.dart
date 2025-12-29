part of 'menu_item_bloc.dart';

abstract class MenuItemEvent {}

class GetAllItemsInRestaurantsOfUsersCity extends MenuItemEvent {
  final GetAllItemsInRestaurantsOfUsersCityParams params;
  GetAllItemsInRestaurantsOfUsersCity(this.params);
}

class GetMenuItemsInRestaurant extends MenuItemEvent {
  final GetAllMenuItemsInRestaurantParams params;
  GetMenuItemsInRestaurant(this.params);
}

