part of 'menu_item_bloc.dart';

abstract class MenuItemState extends Equatable {}

class MenuItemInitial extends MenuItemState {
  @override
  List<Object?> get props => [];
}

/// FetchingAllMenuItems
class FetchingAllMenuItemsLoading extends MenuItemState {
  @override
  List<Object?> get props => [];
}

class FetchingAllMenuItemsSuccess extends MenuItemState {
  final List<MenuItem> menuItems;
  FetchingAllMenuItemsSuccess(this.menuItems);
  @override
  List<Object?> get props => [menuItems];
}

class FetchingAllMenuItemsFailed extends MenuItemState {
  final Failure failure;
  FetchingAllMenuItemsFailed(this.failure);
  @override
  List<Object?> get props => [failure];
}

/// FetchingAllMenuItemsInRestaurant
class FetchingAllMenuItemsInRestaurantLoading extends MenuItemState {
  @override
  List<Object?> get props => [];
}

class FetchingAllMenuItemsInRestaurantSuccess extends MenuItemState {
  final List<MenuItem> menuItems;
  FetchingAllMenuItemsInRestaurantSuccess(this.menuItems);
  @override
  List<Object?> get props => [menuItems];
}

class FetchingAllMenuItemsInRestaurantFailed extends MenuItemState {
  final Failure failure;
  FetchingAllMenuItemsInRestaurantFailed(this.failure);
  @override
  List<Object?> get props => [failure];
}