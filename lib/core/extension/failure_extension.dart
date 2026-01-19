import 'package:foody_licious/core/error/failures.dart';

extension FailureMessage on Failure {
  String toMessage({String defaultMessage = "An unexpected error occurred"}) {
    // Auth / User related
    if (this is CredentialFailure) {
      return "Invalid credentials. Please try again.";
    }

    if (this is AuthenticationFailure) {
      return (this as AuthenticationFailure).failureMessage ??
          "Authentication failed.";
    }

    if (this is UserAlreadyExistsFailure) {
      return "User already exists. Please log in.";
    }

    if (this is UserNotExistsFailure) {
      return "User does not exist.";
    }

    if (this is AuthProviderMissMatchFailure) {
      return "You previously logged in using a different provider.";
    }

    if (this is TooManyRequestsFailure) {
      return "Too many requests. Please try again later.";
    }

    // Server / Network
    if (this is ServerFailure) {
      return "Server error. Please try again later.";
    }

    if (this is NetworkFailure) {
      return "Network error. Check your internet connection.";
    }

    if (this is TimeOutFailure) {
      return "Request timed out. Please try again.";
    }

    if (this is CacheFailure) {
      return "Cache error. Failed to load local data.";
    }

    if (this is ExceptionFailure) {
      return (this as ExceptionFailure).failureMessage ??
          "Something went wrong.";
    }

    // Location
    if (this is LocationServicesDisabledFailure) {
      return "Location services are disabled. Please enable them.";
    }

    if (this is LocationPermissionDeniedFailure) {
      return "Location permission denied.";
    }

    if (this is LocationPermissionPermanentlyDeniedFailure) {
      return "Location permission permanently denied. Enable it from settings.";
    }

    // Restaurant / Menu
    if (this is RestaurantNotExistsFailure) {
      return "Restaurant does not exist.";
    }

    if (this is MenuItemNotExistsFailure) {
      return "Menu item does not exist.";
    }

    if (this is MenuItemOutOfStockFailure) {
      return "This item is currently out of stock.";
    }

    // Cart
    if (this is CartNotExistsFailure) {
      return "Cart does not exist.";
    }

    if (this is CartLockedFailure) {
      return "Your cart is locked. Complete or cancel the current order.";
    }

    return defaultMessage;
  }
}
