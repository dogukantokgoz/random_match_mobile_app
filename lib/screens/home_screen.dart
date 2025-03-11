import 'package:flutter/material.dart';
import 'notifications_screen.dart';
import 'buy_gold_screen.dart';

class HomeScreen extends StatefulWidget {
  final String selectedMainCategory;
  final MaterialColor selectedColor;
  final int currentGold;

  const HomeScreen({
    super.key,
    required this.selectedMainCategory,
    required this.selectedColor,
    this.currentGold = 0,
  });

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _navigateToNotifications() {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => NotificationsScreen(
          selectedMainCategory: widget.selectedMainCategory,
          selectedColor: widget.selectedColor,
          selectedIndex: 1,
          onItemSelected: (newIndex) {
            Navigator.pop(context);
            setState(() {
              _selectedIndex = newIndex;
            });
          },
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 0.03);
          const end = Offset.zero;
          const curve = Curves.easeOut;

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
        transitionDuration: const Duration(milliseconds: 150),
        reverseTransitionDuration: const Duration(milliseconds: 150),
      ),
    );
  }

  void _navigateToBuyGold() {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => BuyGoldScreen(
          selectedMainCategory: widget.selectedMainCategory,
          selectedColor: widget.selectedColor,
          currentGold: widget.currentGold,
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 0.03);
          const end = Offset.zero;
          const curve = Curves.easeOut;

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
        transitionDuration: const Duration(milliseconds: 150),
        reverseTransitionDuration: const Duration(milliseconds: 150),
      ),
    );
  }

  void _onItemTapped(int index) {
    if (index == 1) { // Bildirimler
      _navigateToNotifications();
      return;
    }
    
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: SafeArea(
          bottom: false,
          child: Container(
            margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            height: 46,
            child: Row(
              children: [
                // Ana başlık
                Expanded(
                  child: Container(
                    height: 46,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(23),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        const Expanded(
                          child: Text(
                            'Ana Sayfa',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => _navigateToBuyGold(),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: widget.selectedColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              children: [
                                _buildCoinIcon(size: 18),
                                const SizedBox(width: 4),
                                Text(
                                  '${widget.currentGold}',
                                  style: TextStyle(
                                    color: widget.selectedColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          const Center(child: Text('Ana Sayfa')),
          const Center(child: Text('Bildirimler')),
          const Center(child: Text('Mesajlar')),
          const Center(child: Text('Profil')),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          child: Container(
            height: 56,
            margin: const EdgeInsets.only(
              left: 16,
              right: 16,
              bottom: 12,
              top: 12,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(28),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildNavItem(0, Icons.home_outlined, Icons.home),
                _buildNavItem(1, Icons.notifications_outlined, Icons.notifications),
                _buildNavItem(2, Icons.message_outlined, Icons.message),
                _buildNavItem(3, Icons.person_outline, Icons.person),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData outlinedIcon, IconData filledIcon) {
    final isSelected = _selectedIndex == index;
    return TextButton(
      onPressed: () => _onItemTapped(index),
      style: TextButton.styleFrom(
        padding: const EdgeInsets.all(16),
        minimumSize: const Size(56, 56),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: Icon(
        isSelected ? filledIcon : outlinedIcon,
        color: isSelected ? widget.selectedColor : Colors.grey[400],
        size: 24,
      ),
    );
  }

  Widget _buildCoinIcon({double size = 20}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.amber,
            Colors.amber.withOpacity(0.8),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.amber.withOpacity(0.3),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: Icon(
          Icons.eco,
          size: size * 0.6,
          color: Colors.yellow[100],
        ),
      ),
    );
  }
} 