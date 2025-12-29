import 'package:flutter/material.dart';
import 'package:foody_licious/core/router/app_router.dart';
import 'package:foody_licious/domain/entities/menuItem/menuItem.dart';
import 'package:foody_licious/presentation/view/product/menu_item_details_view.dart';
import 'package:foody_licious/presentation/view/product/restaurant_details_view.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class TabNavigator {
  static void pop(BuildContext context) {
    Navigator.pop(context);
  }

  static void pushMenuItemDetails(
    BuildContext context,
    MenuItem menuItem,
  ) {
    PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
      context,
      settings: RouteSettings(
        name: AppRouter.menuItemDetails,
        arguments: menuItem,
      ),
      screen: MenuItemDetailsView(menuItem: menuItem),
      withNavBar: true,
      pageTransitionAnimation: PageTransitionAnimation.cupertino,
    );
  }

  static void pushRestaurantDetails(
    BuildContext context,
    String restaurantId,
  ) {
    PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
      context,
      settings: RouteSettings(
        name: AppRouter.restaurantDetails,
        arguments: restaurantId,
      ),
      screen: RestaurantDetailsView(restaurantId: restaurantId),
      withNavBar: true,
      pageTransitionAnimation: PageTransitionAnimation.cupertino,
    );
  }
}
