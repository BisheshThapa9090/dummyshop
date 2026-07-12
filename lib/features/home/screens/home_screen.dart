import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/bottom_nav_bar.dart';

class HomeScreen extends StatefulWidget {
  final Widget child;
  const HomeScreen({super.key, required this.child});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // Keep track of current route to update selected index
  void _updateSelectedIndex(String route) {
    if (route.contains('/home/products')) {
      _selectedIndex = 0;
    } else if (route.contains('/home/recipes')) {
      _selectedIndex = 1;
    } else if (route.contains('/home/posts')) {
      _selectedIndex = 2;
    } else if (route.contains('/home/cart')) {
      _selectedIndex = 3;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get current route to highlight correct tab
    final currentRoute = ModalRoute.of(context)?.settings.name ?? '';
    _updateSelectedIndex(currentRoute);

    return Scaffold(
      body: widget.child,
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onTap: (index) {
          setState(() => _selectedIndex = index);
          switch (index) {
            case 0:
              context.go('/home/products');
              break;
            case 1:
              context.go('/home/recipes');
              break;
            case 2:
              context.go('/home/posts');
              break;
            case 3:
              context.go('/home/cart');
              break;
          }
        },
      ),
    );
  }
}
