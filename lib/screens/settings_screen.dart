import 'package:flutter/material.dart';
import '../components/bottom_nav_bar.dart';
import 'profile_screen.dart';
import 'messages_screen.dart';
import 'call_screen.dart';
import 'notifications_screen.dart';
import 'premium_screen.dart';

class SettingsScreen extends StatefulWidget {
  final String selectedMainCategory;
  final MaterialColor selectedColor;
  final int selectedIndex;

  const SettingsScreen({
    super.key,
    required this.selectedMainCategory,
    required this.selectedColor,
    required this.selectedIndex,
  });

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  void _onItemTapped(int index) {
    if (index == 3) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ProfileScreen(
            selectedMainCategory: widget.selectedMainCategory,
            selectedColor: widget.selectedColor,
          ),
        ),
      );
    } else if (index == 2) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MessagesScreen(
            selectedMainCategory: widget.selectedMainCategory,
            selectedColor: widget.selectedColor,
          ),
        ),
      );
    } else if (index == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => CallScreen(
            selectedCategory: widget.selectedMainCategory,
          ),
        ),
      );
    } else if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => NotificationsScreen(
            selectedMainCategory: widget.selectedMainCategory,
            selectedColor: widget.selectedColor,
            selectedIndex: 0,
            onItemSelected: (index) {},
          ),
        ),
      );
    }
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color? iconColor,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: widget.selectedColor[900]!.withOpacity(0.95),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.white.withOpacity(0.2),
              width: 1,
            ),
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
              Icon(
                icon,
                color: iconColor ?? Colors.white,
                size: 24,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: Colors.white.withOpacity(0.7),
                size: 24,
              ),
            ],
          ),
        ),
      ),
    );
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
            decoration: BoxDecoration(
              color: widget.selectedColor[900]!.withOpacity(0.95),
              borderRadius: BorderRadius.circular(25),
              border: Border.all(
                color: Colors.white.withOpacity(0.2),
                width: 1,
              ),
            ),
            child: Stack(
              children: [
                Center(
                  child: Text(
                    'Ayarlar',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  top: 0,
                  bottom: 0,
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: const BorderRadius.horizontal(left: Radius.circular(25)),
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 46,
                        height: 46,
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildMenuItem(
            icon: Icons.workspace_premium,
            title: 'Premium Satın Al',
            onTap: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) => PremiumScreen(
                    selectedMainCategory: widget.selectedMainCategory,
                    selectedColor: widget.selectedColor,
                    selectedIndex: widget.selectedIndex,
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
            },
          ),
          const SizedBox(height: 8),
          _buildMenuItem(
            icon: Icons.language,
            title: 'Dil Seç',
            onTap: () {},
          ),
          const SizedBox(height: 8),
          _buildMenuItem(
            icon: Icons.history,
            title: 'Altın Harcama Geçmişi',
            onTap: () {},
          ),
          const SizedBox(height: 8),
          _buildMenuItem(
            icon: Icons.help_outline,
            title: 'SSS',
            onTap: () {},
          ),
          const SizedBox(height: 8),
          _buildMenuItem(
            icon: Icons.lock_outline,
            title: 'Şifre Değiştir',
            onTap: () {},
          ),
          const SizedBox(height: 8),
          _buildMenuItem(
            icon: Icons.logout,
            title: 'Çıkış Yap',
            onTap: () {},
          ),
          const SizedBox(height: 8),
          _buildMenuItem(
            icon: Icons.delete_forever,
            title: 'Hesabı Sil',
            onTap: () {},
            iconColor: Colors.red[400],
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: widget.selectedIndex,
        selectedColor: widget.selectedColor,
        onItemSelected: _onItemTapped,
      ),
    );
  }
} 