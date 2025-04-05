import 'package:flutter/material.dart';
import 'match_screen.dart';

class MatchRequestScreen extends StatefulWidget {
  final String selectedMainCategory;
  final MaterialColor selectedColor;

  const MatchRequestScreen({
    super.key,
    required this.selectedMainCategory,
    required this.selectedColor,
  });

  @override
  State<MatchRequestScreen> createState() => _MatchRequestScreenState();
}

class _MatchRequestScreenState extends State<MatchRequestScreen> {
  @override
  Widget build(BuildContext context) {
    const double buttonWidth = 100.0;
    const double totalButtonsWidth = (buttonWidth * 2) + 16.0; // 2 buttons with gap
    const double cardWidth = totalButtonsWidth;

    return Scaffold(
      backgroundColor: widget.selectedColor[900],
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Profile Card
              Container(
                width: cardWidth,
                height: 140,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.98),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 15,
                      offset: const Offset(0, 4),
                    ),
                    BoxShadow(
                      color: widget.selectedColor.withOpacity(0.05),
                      blurRadius: 20,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // Profile Picture and Stats Row
                      SizedBox(
                        width: cardWidth - 20,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Profile Picture
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    widget.selectedColor[400]!,
                                    widget.selectedColor[600]!,
                                  ],
                                ),
                                border: Border.all(
                                  color: Colors.white,
                                  width: 3,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: widget.selectedColor.withOpacity(0.2),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.person,
                                size: 24,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(width: 6),
                            // Stats Column
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildMiniStat(
                                  icon: Icons.star,
                                  value: '5',
                                  color: Colors.amber,
                                ),
                                const SizedBox(height: 6),
                                _buildMiniStat(
                                  icon: Icons.favorite,
                                  value: '123',
                                  color: Colors.red,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      // User Info
                      SizedBox(
                        width: cardWidth - 20,
                        child: Column(
                          children: [
                            const Text(
                              'John Doe',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Online',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Action Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildActionButton(
                    icon: Icons.close,
                    label: 'Reddet',
                    onTap: () => Navigator.pop(context),
                    height: 50,
                  ),
                  const SizedBox(width: 16),
                  _buildActionButton(
                    icon: Icons.check,
                    label: 'Kabul Et',
                    onTap: () {
                      _navigateToScreen(
                        MatchScreen(
                          selectedMainCategory: widget.selectedMainCategory,
                          selectedColor: widget.selectedColor,
                          user: {
                            'name': 'John Doe',
                            'level': 5,
                            'likes': 123,
                            'status': 'online',
                            'bio': 'Merhaba! Ben müzik ve seyahat tutkunuyum. Yeni arkadaşlar edinmek için buradayım!',
                          },
                        ),
                      );
                    },
                    height: 50,
                  ),
                ],
              ),
            ],
          ),
        ),
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

  Widget _buildMiniStat({
    required IconData icon,
    required String value,
    required Color color,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 16,
          color: color,
        ),
        const SizedBox(width: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.grey[700],
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    double height = 100,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Container(
          width: 100,
          height: height,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.white.withOpacity(0.2),
              width: 1,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: Colors.white,
                size: height * 0.32,
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
} 