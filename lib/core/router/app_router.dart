import 'package:flutter/material.dart';
import 'package:foody_licious/presentation/view/authentication/login_view.dart';
import 'package:foody_licious/presentation/view/authentication/signup_view.dart';
import 'package:foody_licious/presentation/view/authentication/verification_view.dart';
import 'package:foody_licious/presentation/view/feedback/feedback_view.dart';
import 'package:foody_licious/presentation/view/main/main_view.dart';
import 'package:foody_licious/presentation/view/notification/notification_view.dart';
import 'package:foody_licious/presentation/view/onboarding/splash_view.dart';
import 'package:foody_licious/presentation/view/product/menu_item_details_view.dart';
import 'package:foody_licious/presentation/view/product/restaurant_details_view.dart';

import '../../presentation/view/authentication/set_location_view.dart';
import '../../presentation/view/onboarding/onboarding_view.dart';
import '../../presentation/view/order/order_confirmation_view.dart';
import '../../presentation/view/order/payout_view.dart';

class AppRouter {
  //splash & onboarding
  static const String splash = '/splash';
  static const String onboarding = '/onboarding';
  //main menu
  static const String home = '/';
  //authentication
  static const String login = '/login';
  static const String signUp = '/sign-up';
  static const String verification = '/verification';
  static const String setLocation = '/set-location';
  //products
  static const String menuItemDetails = '/menu-item-details';
  static const String restaurantDetails = '/restaurant-details';
  //order
  static const String orderConfirmation = '/order-confirmation';
  static const String payout = '/payout';
  //feedback
  static const String feedback = '/feedback';
  //notification
  static const String notifications = '/notifications';

  static Route<dynamic> onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      //splash & onboarding
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case onboarding:
        return MaterialPageRoute(builder: (_) => const OnboardingView());
      //main menu
      case home:
        return MaterialPageRoute(
          builder: (BuildContext context) => MainView(
            menuScreenContext: context,
          ),
        );
      //authentication
      case login:
        return MaterialPageRoute(builder: (_) => const LoginView());
      case signUp:
        return MaterialPageRoute(builder: (_) => const SignUpView());
      case verification:
        final args = routeSettings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => VerificationView(
            nameController: args['nameController'],
            emailOrPhoneController: args['emailOrPhoneController'],
            authProvider: args['authProvider'],
          ),
        );
      case setLocation:
        return MaterialPageRoute(builder: (_) => SetLocationView());
      //products
      case menuItemDetails:
        return MaterialPageRoute(builder: (_) => MenuItemDetailsView());
      case restaurantDetails:
        return MaterialPageRoute(builder: (_) => RestaurantDetailsView());
      //order
      case orderConfirmation:
        return MaterialPageRoute(builder: (_) => OrderConfirmationView());
      case payout:
        return MaterialPageRoute(builder: (_) => PayoutView());
      //feedback
      case feedback:
        return MaterialPageRoute(builder: (_) => FeedbackView());
      //notification
      case notifications:
        return MaterialPageRoute(builder: (_) => NotificationView());
      default:
        throw Exception("Route not found!");
      // throw const RouteException('Route not found!');
    }
  }
}
