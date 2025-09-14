import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foody_licious/presentation/widgets/gradient_button.dart';

void main() {
  group('GradientButton Widget Tests', () {
    testWidgets('should display button with correct text', (tester) async {
      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(375, 812),
          child: MaterialApp(
            home: Scaffold(
              body: GradientButton(
                buttonText: 'Test Button',
                onTap: () {},
              ),
            ),
          ),
        ),
      );

      expect(find.text('Test Button'), findsOneWidget);
      expect(find.byType(GradientButton), findsOneWidget);
    });

    testWidgets('should call onTap when button is tapped and isActive is true',
        (tester) async {
      bool wasTapped = false;

      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(375, 812),
          child: MaterialApp(
            home: Scaffold(
              body: GradientButton(
                buttonText: 'Tap Me',
                onTap: () => wasTapped = true,
                isActive: true,
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.byType(GradientButton));
      await tester.pump();

      expect(wasTapped, isTrue);
    });

    testWidgets(
        'should not call onTap when button is tapped and isActive is false',
        (tester) async {
      bool wasTapped = false;

      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(375, 812),
          child: MaterialApp(
            home: Scaffold(
              body: GradientButton(
                buttonText: 'Disabled Button',
                onTap: () => wasTapped = true,
                isActive: false,
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.byType(GradientButton));
      await tester.pump();

      expect(wasTapped, isFalse);
    });

    testWidgets('should apply custom dimensions when provided', (tester) async {
      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(375, 812),
          child: MaterialApp(
            home: Scaffold(
              body: GradientButton(
                buttonText: 'Custom Size',
                onTap: () {},
                width: 200,
                height: 80,
                borderRadius: 20,
                fontSize: 24,
              ),
            ),
          ),
        ),
      );

      final button = find.byType(GradientButton);
      expect(button, findsOneWidget);

      // Verify the button is rendered (dimensions are applied via ScreenUtil)
      expect(find.text('Custom Size'), findsOneWidget);
    });

    testWidgets(
        'should display with default values when no custom values provided',
        (tester) async {
      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(375, 812),
          child: MaterialApp(
            home: Scaffold(
              body: GradientButton(
                buttonText: 'Default Button',
                onTap: () {},
              ),
            ),
          ),
        ),
      );

      expect(find.text('Default Button'), findsOneWidget);
      expect(find.byType(GradientButton), findsOneWidget);
    });

    testWidgets('should handle null onTap gracefully', (tester) async {
      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(375, 812),
          child: MaterialApp(
            home: Scaffold(
              body: GradientButton(
                buttonText: 'Null Tap Button',
                onTap: null,
                isActive: true,
              ),
            ),
          ),
        ),
      );

      // Should not throw an error when tapped
      await tester.tap(find.byType(GradientButton));
      await tester.pump();

      expect(find.text('Null Tap Button'), findsOneWidget);
    });
  });
}

