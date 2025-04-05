import 'package:flutter/material.dart';
import '../components/bottom_nav_bar.dart';
import 'call_screen.dart';
import 'messages_screen.dart';
import 'notifications_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  final MaterialColor selectedColor;
  final String selectedMainCategory;

  const HomeScreen({
    super.key,
    required this.selectedColor,
    required this.selectedMainCategory,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  bool hasUnreadNotifications = true;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 2) {
        hasUnreadNotifications = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          Container(color: Colors.white), // Ana Sayfa içeriği
          CallScreen(selectedMainCategory: widget.selectedMainCategory),
          NotificationsScreen(
            selectedMainCategory: widget.selectedMainCategory,
            selectedColor: widget.selectedColor,
            selectedIndex: _selectedIndex,
            onItemSelected: _onItemTapped,
          ),
          ProfileScreen(
            selectedMainCategory: widget.selectedMainCategory,
            selectedColor: widget.selectedColor,
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        selectedColor: widget.selectedColor,
        onItemSelected: _onItemTapped,
        hasUnreadNotifications: hasUnreadNotifications,
      ),
    );
  }

  void _navigateToScreen(Widget screen) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => screen,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 0.01);
          const end = Offset.zero;
          const curve = Curves.easeOutCubic;
          var tween = Tween(begin: begin, end: end).chain(
            CurveTween(curve: curve),
          );
          return SlideTransition(
            position: animation.drive(tween),
            child: FadeTransition(
              opacity: animation,
              child: child,
            ),
          );
        },
        transitionDuration: const Duration(milliseconds: 100),
        reverseTransitionDuration: const Duration(milliseconds: 100),
      ),
    );
  }

  // ... (rest of the existing code)
} 