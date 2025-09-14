# Widget Tests for Foody Licious App

This directory contains comprehensive widget tests for the Foody Licious Flutter application. The tests are organized to cover all major UI components and user interactions.

## 📁 Test Structure

```
test/
├── presentation/
│   ├── widgets/                    # Widget tests
│   │   ├── gradient_button_test.dart
│   │   ├── input_text_form_field_test.dart
│   │   ├── menu_item_card_test.dart
│   │   └── search_bar_field_test.dart
│   └── view/
│       └── authentication/
│           └── login_view_test.dart
├── helpers/
│   └── test_helpers.dart          # Test utilities and helpers
├── fixture/
│   └── constant_objects.dart      # Test data fixtures
└── README.md                      # This file
```

## 🧪 Test Coverage

### Widget Tests

#### 1. **GradientButton Tests** (`gradient_button_test.dart`)
- ✅ Button text display
- ✅ Tap functionality (active/inactive states)
- ✅ Custom dimensions and styling
- ✅ Null onTap handling
- ✅ Default values

#### 2. **InputTextFormField Tests** (`input_text_form_field_test.dart`)
- ✅ Label and hint text display
- ✅ Prefix icon display
- ✅ Password visibility toggle
- ✅ Text change callbacks
- ✅ Form validation
- ✅ Suffix icon display
- ✅ Read-only state
- ✅ Keyboard type handling
- ✅ Multiline input support

#### 3. **MenuItemCard Tests** (`menu_item_card_test.dart`)
- ✅ Basic menu item display
- ✅ Checkbox functionality
- ✅ Cart item quantity controls
- ✅ History item "Buy Again" button
- ✅ Restaurant menu item "See Details" button
- ✅ Price format variations
- ✅ Tap callbacks for all variants

#### 4. **SearchBarField Tests** (`search_bar_field_test.dart`)
- ✅ Default hint text display
- ✅ Search icon display
- ✅ Text input handling
- ✅ Tap functionality
- ✅ Text change handling
- ✅ Proper styling verification

#### 5. **LoginView Tests** (`login_view_test.dart`)
- ✅ UI elements display
- ✅ Email/phone validation states
- ✅ Social authentication buttons
- ✅ Form validation
- ✅ BLoC state handling
- ✅ Navigation triggers
- ✅ Password reset functionality

### Test Helpers (`test_helpers.dart`)

#### **TestWidgetHelper**
- `createTestWidget()` - Creates widgets with ScreenUtil initialization
- `createMaterialTestWidget()` - Creates widgets with MaterialApp wrapper
- `createScaffoldTestWidget()` - Creates widgets with Scaffold wrapper

#### **TestHelper**
- `registerFallbackValues()` - Registers mocktail fallback values
- `createMockNavigatorObserver()` - Creates mock navigator observer
- `waitForSettle()` - Waits for widget animations to complete
- `enterTextAndPump()` - Enters text and pumps in one operation
- `tapAndPump()` - Taps widget and pumps in one operation

#### **WidgetTesterExtensions**
- `enterTextAndPump()` - Extension method for text input
- `tapAndPump()` - Extension method for tapping
- `longPressAndPump()` - Extension method for long press
- `dragAndPump()` - Extension method for dragging
- `scrollAndPump()` - Extension method for scrolling

#### **TestConstants**
- Design sizes for different screen types
- Common test strings and values
- Animation durations

#### **TestDataFactory**
- `createTestUser()` - Creates test user data
- `createTestMenuItem()` - Creates test menu item data

## 🚀 Running Tests

### Run All Widget Tests
```bash
flutter test test/presentation/widgets/
```

### Run Specific Widget Test
```bash
flutter test test/presentation/widgets/gradient_button_test.dart
```

### Run All Tests
```bash
flutter test
```

### Run Tests with Coverage
```bash
flutter test --coverage
```

## 📋 Test Categories

### **Unit Widget Tests**
- Test individual widgets in isolation
- Mock dependencies using mocktail
- Verify widget properties and behavior
- Test user interactions (tap, text input, etc.)

### **Integration Widget Tests**
- Test widgets with BLoC integration
- Test navigation and state management
- Test form validation and submission
- Test error handling and loading states

## 🛠️ Testing Best Practices

### **1. Test Structure**
```dart
group('WidgetName Tests', () {
  setUp(() {
    // Setup code
  });

  tearDown(() {
    // Cleanup code
  });

  testWidgets('should do something', (tester) async {
    // Test implementation
  });
});
```

### **2. Widget Setup**
```dart
await tester.pumpWidget(
  ScreenUtilInit(
    designSize: const Size(375, 812),
    child: MaterialApp(
      home: Scaffold(
        body: YourWidget(),
      ),
    ),
  ),
);
```

### **3. BLoC Testing**
```dart
class MockAuthBloc extends Mock implements AuthBloc {}

when(() => mockAuthBloc.state).thenReturn(AuthInitial());
verify(() => mockAuthBloc.add(any(that: isA<AuthEvent>()))).called(1);
```

### **4. User Interactions**
```dart
// Tap
await tester.tap(find.byType(Button));
await tester.pump();

// Text input
await tester.enterText(find.byType(TextField), 'test text');
await tester.pump();

// Form validation
formKey.currentState?.validate();
await tester.pump();
```

## 🔧 Dependencies

The widget tests use the following packages:

- **flutter_test** - Core testing framework
- **mocktail** - Mocking library
- **flutter_screenutil** - Responsive design testing
- **flutter_bloc** - BLoC testing utilities

## 📊 Test Metrics

- **Total Widget Tests**: 25+ test cases
- **Coverage**: All major UI components
- **Test Types**: Unit tests, integration tests, interaction tests
- **Mocking**: BLoC, navigation, form validation

## 🐛 Common Issues & Solutions

### **1. ScreenUtil Not Initialized**
```dart
// Always wrap with ScreenUtilInit
ScreenUtilInit(
  designSize: const Size(375, 812),
  child: MaterialApp(...),
)
```

### **2. BLoC Mock Issues**
```dart
// Use proper mock setup
class MockAuthBloc extends Mock implements AuthBloc {}
when(() => mockBloc.state).thenReturn(InitialState());
```

### **3. Form Validation**
```dart
// Trigger validation properly
formKey.currentState?.validate();
await tester.pump();
```

### **4. Async Operations**
```dart
// Always pump after async operations
await tester.pumpAndSettle();
```

## 📈 Future Enhancements

- [ ] Add more view tests (HomeView, CartView, etc.)
- [ ] Add integration tests for complete user flows
- [ ] Add golden file tests for UI regression
- [ ] Add performance tests for complex widgets
- [ ] Add accessibility tests

## 🤝 Contributing

When adding new widget tests:

1. Follow the existing test structure
2. Use descriptive test names
3. Mock all dependencies
4. Test both success and error scenarios
5. Update this README with new test coverage

## 📚 Resources

- [Flutter Testing Guide](https://docs.flutter.dev/testing)
- [Widget Testing](https://docs.flutter.dev/cookbook/testing/widget)
- [Mocktail Documentation](https://pub.dev/packages/mocktail)
- [BLoC Testing](https://bloclibrary.dev/#/testing)

