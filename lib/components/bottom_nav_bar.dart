import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final MaterialColor selectedColor;
  final Function(int) onItemSelected;

  const BottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.selectedColor,
    required this.onItemSelected,
  });

  Widget _buildNavItem(IconData icon, int index) {
    final isSelected = selectedIndex == index;
    final bool showDot = index == 0 || index == 2 || index == 3; // Bildirim, mesaj ve profil için nokta
    
    return GestureDetector(
      onTap: () => onItemSelected(index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? selectedColor : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.white : Colors.grey[600],
              size: 28,
            ),
            if (showDot)
              Positioned(
                right: -4,
                top: -4,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.white : selectedColor[600],
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 1.5,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 0,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(Icons.notifications, 0),
            _buildNavItem(Icons.call, 1),
            _buildNavItem(Icons.message, 2),
            _buildNavItem(Icons.person, 3),
          ],
        ),
      ),
    );
  }
} 