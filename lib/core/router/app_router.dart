import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../features/auth/screens/splash_screen.dart';
import '../../features/auth/screens/login_screen.dart';
import '../../features/home/screens/home_screen.dart';
import '../../features/products/screens/product_screen.dart';
import '../../features/products/screens/product_detail_screen.dart';
import '../../features/products/screens/search_screen.dart';
import '../../features/recipes/screens/recipe_screen.dart';
import '../../features/recipes/screens/recipe_detail_screen.dart';
import '../../features/posts/screens/post_screen.dart';
import '../../features/posts/screens/post_detail_screen.dart';
import '../../features/posts/screens/create_post_screen.dart';
import '../../features/comments/screens/comment_screen.dart';
import '../../features/cart/screens/cart_screen.dart';

final _secureStorage = const FlutterSecureStorage();

class AppRouter {
  static Future<String?> _authRedirect(BuildContext context, GoRouterState state) async {
    final location = state.uri.toString();
    final token = await _secureStorage.read(key: 'accessToken');

    final isPublicRoute = location == '/splash' || location == '/login';

    if ((token == null || token.isEmpty) && !isPublicRoute) {
      return '/login';
    }

    if (token != null && token.isNotEmpty && isPublicRoute) {
      return '/home/products';
    }

    return null;
  }

  static final router = GoRouter(
    initialLocation: '/splash',
    redirect: _authRedirect,
    routes: [
      // ============================================
      // PUBLIC ROUTES (No Auth Required)
      // ============================================
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),

      // ============================================
      // PROTECTED ROUTES (Auth Required)
      // ============================================
      ShellRoute(
        builder: (context, state, child) => HomeScreen(child: child),
        routes: [
          // ============================================
          // PRODUCTS
          // ============================================
          GoRoute(
            path: '/home/products',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: ProductScreen(),
            ),
            routes: [
              GoRoute(
                path: 'search',
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: SearchScreen(),
                ),
              ),
              // 🔥 Product Detail - Stays inside ShellRoute
              GoRoute(
                path: ':id',
                pageBuilder: (context, state) {
                  final idString = state.pathParameters['id'] ?? '0';
                  final id = int.tryParse(idString) ?? 0;
                  print('🔵 NAVIGATING TO PRODUCT: $id');
                  return NoTransitionPage(
                    child: ProductDetailScreen(productId: id),
                  );
                },
              ),
            ],
          ),

          // ============================================
          // RECIPES
          // ============================================
          GoRoute(
            path: '/home/recipes',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: RecipeScreen(),
            ),
            routes: [
              GoRoute(
                path: ':id',
                pageBuilder: (context, state) {
                  final idString = state.pathParameters['id'] ?? '0';
                  final id = int.tryParse(idString) ?? 0;
                  return NoTransitionPage(
                    child: RecipeDetailScreen(recipeId: id),
                  );
                },
              ),
            ],
          ),

          // ============================================
          // POSTS
          // ============================================
          GoRoute(
            path: '/home/posts',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: PostScreen(),
            ),
            routes: [
              GoRoute(
                path: 'create',
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: CreatePostScreen(),
                ),
              ),
              GoRoute(
                path: ':id',
                pageBuilder: (context, state) {
                  final idString = state.pathParameters['id'] ?? '0';
                  final id = int.tryParse(idString) ?? 0;
                  return NoTransitionPage(
                    child: PostDetailScreen(postId: id),
                  );
                },
                routes: [
                  GoRoute(
                    path: 'comments',
                    pageBuilder: (context, state) {
                      final idString = state.pathParameters['id'] ?? '0';
                      final id = int.tryParse(idString) ?? 0;
                      return NoTransitionPage(
                        child: CommentScreen(postId: id),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),

          // ============================================
          // CART
          // ============================================
          GoRoute(
            path: '/home/cart',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: CartScreen(),
            ),
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            const Text(
              'Page Not Found',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              state.uri.toString(),
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.go('/home/products'),
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    ),
  );
}
