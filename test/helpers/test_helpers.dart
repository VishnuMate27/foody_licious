import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mocktail/mocktail.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

/// Helper class to create test widgets with common setup
class TestWidgetHelper {
  /// Creates a test widget with ScreenUtil initialization and optional BLoC providers
  static Widget createTestWidget({
    required Widget child,
    List<BlocProvider>? providers,
    NavigatorObserver? navigatorObserver,
    Size designSize = const Size(375, 812),
  }) {
    return ScreenUtilInit(
      designSize: designSize,
      child: MaterialApp(
        home: providers != null
            ? MultiBlocProvider(
                providers: providers,
                child: child,
              )
            : child,
        navigatorObservers:
            navigatorObserver != null ? [navigatorObserver] : [],
      ),
    );
  }

  /// Creates a test widget with MaterialApp wrapper
  static Widget createMaterialTestWidget({
    required Widget child,
    List<BlocProvider>? providers,
    NavigatorObserver? navigatorObserver,
  }) {
    return MaterialApp(
      home: providers != null
          ? MultiBlocProvider(
              providers: providers,
              child: child,
            )
          : child,
      navigatorObservers: navigatorObserver != null ? [navigatorObserver] : [],
    );
  }

  /// Creates a test widget with Scaffold wrapper
  static Widget createScaffoldTestWidget({
    required Widget child,
    List<BlocProvider>? providers,
    NavigatorObserver? navigatorObserver,
  }) {
    return createTestWidget(
      child: Scaffold(body: child),
      providers: providers,
      navigatorObserver: navigatorObserver,
    );
  }
}

/// Helper class for common test operations
class TestHelper {
  /// Registers fallback values for mocktail
  static void registerFallbackValues() {
    registerFallbackValue(FakeRoute());
    registerFallbackValue(FakeRouteSettings());
  }

  /// Creates a mock navigator observer
  static MockNavigatorObserver createMockNavigatorObserver() {
    return MockNavigatorObserver();
  }

  /// Waits for widget to settle
  static Future<void> waitForSettle(WidgetTester tester) async {
    await tester.pumpAndSettle();
  }

  /// Pumps widget and waits for animations
  static Future<void> pumpAndSettle(WidgetTester tester) async {
    await tester.pumpAndSettle();
  }

  /// Enters text and pumps
  static Future<void> enterTextAndPump(
    WidgetTester tester,
    Finder finder,
    String text,
  ) async {
    await tester.enterText(finder, text);
    await tester.pump();
  }

  /// Taps widget and pumps
  static Future<void> tapAndPump(
    WidgetTester tester,
    Finder finder,
  ) async {
    await tester.tap(finder);
    await tester.pump();
  }
}

/// Fake classes for mocktail fallback values
class FakeRoute extends Fake implements Route<dynamic> {}

class FakeRouteSettings extends Fake implements RouteSettings {}

/// Extension methods for common test operations
extension WidgetTesterExtensions on WidgetTester {
  /// Enters text and pumps in one operation
  Future<void> enterTextAndPump(Finder finder, String text) async {
    await enterText(finder, text);
    await pump();
  }

  /// Taps widget and pumps in one operation
  Future<void> tapAndPump(Finder finder) async {
    await tap(finder);
    await pump();
  }

  /// Long presses widget and pumps
  Future<void> longPressAndPump(Finder finder) async {
    await longPress(finder);
    await pump();
  }

  /// Drags widget and pumps
  Future<void> dragAndPump(Finder finder, Offset offset) async {
    await drag(finder, offset);
    await pump();
  }

  /// Scrolls widget and pumps
  Future<void> scrollAndPump(Finder finder, Offset offset) async {
    await drag(finder, offset);
    await pump();
  }
}

/// Common test constants
class TestConstants {
  static const Size defaultDesignSize = Size(375, 812);
  static const Size tabletDesignSize = Size(768, 1024);
  static const Size desktopDesignSize = Size(1920, 1080);

  // Common test strings
  static const String testEmail = 'test@example.com';
  static const String testPassword = 'password123';
  static const String testPhone = '+919876543210';
  static const String testName = 'Test User';
  static const String testItemName = 'Test Item';
  static const String testHotelName = 'Test Hotel';
  static const double testPrice = 12.99;

  // Common test durations
  static const Duration shortAnimation = Duration(milliseconds: 100);
  static const Duration mediumAnimation = Duration(milliseconds: 300);
  static const Duration longAnimation = Duration(milliseconds: 500);
}

/// Mock classes for common dependencies
class MockTextEditingController extends Mock implements TextEditingController {}

class MockGlobalKey<T extends State<StatefulWidget>> extends Mock
    implements GlobalKey<T> {}

class MockFormState extends Mock implements FormState {
  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'MockFormState';
  }
}

/// Helper for creating test data
class TestDataFactory {
  /// Creates a test user model
  static Map<String, dynamic> createTestUser() {
    return {
      'id': 'test_user_001',
      'name': TestConstants.testName,
      'email': TestConstants.testEmail,
      'phone': TestConstants.testPhone,
      'authProvider': 'email',
      'address': {
        'addressText': 'Test Address',
        'city': 'Test City',
        'coordinates': {
          'type': 'Point',
          'coordinates': [78.087, 87.098],
        },
      },
      'orderHistory': [],
    };
  }

  /// Creates test menu item data
  static Map<String, dynamic> createTestMenuItem() {
    return {
      'itemImageUrl': 'assets/images/test_item.png',
      'itemName': TestConstants.testItemName,
      'hotelName': TestConstants.testHotelName,
      'itemPrice': TestConstants.testPrice,
    };
  }
}
