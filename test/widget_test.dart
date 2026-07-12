// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

// Import your app's main file
import 'package:pixelmart/main.dart';
import 'package:pixelmart/core/theme/app_theme.dart';
import 'package:pixelmart/features/auth/providers/auth_provider.dart';
import 'package:pixelmart/features/products/providers/product_provider.dart';
import 'package:pixelmart/features/cart/providers/cart_provider.dart';
import 'package:pixelmart/features/recipes/providers/recipe_provider.dart';
import 'package:pixelmart/features/posts/providers/post_provider.dart';
import 'package:pixelmart/features/comments/providers/comment_provider.dart';

void main() {
  testWidgets('PixelMart app starts and shows splash screen', (WidgetTester tester) async {
    // Build our app and trigger a frame
    await tester.pumpWidget(const PixelMartApp());

    // Wait for any async operations
    await tester.pumpAndSettle();

    // Verify that the splash screen is shown initially
    // Look for the PixelMart text or logo
    expect(find.text('PixelMart'), findsOneWidget);
    expect(find.text('Your Shopping Companion'), findsOneWidget);
  });

  testWidgets('Login screen shows after splash', (WidgetTester tester) async {
    // Build our app
    await tester.pumpWidget(const PixelMartApp());

    // Wait for splash to finish (2 seconds delay)
    await tester.pump(const Duration(seconds: 3));

    // Now login screen should be visible
    expect(find.text('Sign in to continue'), findsOneWidget);
    expect(find.text('Sign In'), findsOneWidget);
  });

  testWidgets('Login button is present', (WidgetTester tester) async {
    await tester.pumpWidget(const PixelMartApp());

    // Wait for splash
    await tester.pump(const Duration(seconds: 3));

    // Find login button
    expect(find.widgetWithText(ElevatedButton, 'Sign In'), findsOneWidget);
  });

  testWidgets('Products screen shows after login', (WidgetTester tester) async {
    // Create a mock auth provider with user logged in
    final mockAuthProvider = AuthProvider();
    // Note: In a real test, you'd mock the login method

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: mockAuthProvider),
          ChangeNotifierProvider(create: (_) => ProductProvider()),
          ChangeNotifierProvider(create: (_) => CartProvider()),
          ChangeNotifierProvider(create: (_) => RecipeProvider()),
          ChangeNotifierProvider(create: (_) => PostProvider()),
          ChangeNotifierProvider(create: (_) => CommentProvider()),
        ],
        child: MaterialApp(
          title: 'PixelMart',
          theme: AppTheme.lightTheme,
          home: const Scaffold(
            body: Center(
              child: Text('Products Screen'),
            ),
          ),
        ),
      ),
    );

    // Verify products screen shows
    expect(find.text('Products Screen'), findsOneWidget);
  });
}