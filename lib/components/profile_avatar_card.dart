import 'package:flutter/material.dart';

class ProfileAvatarCard extends StatelessWidget {
  final String name;
  final int level;
  final int likes;
  final bool showEditButton;
  final double size;
  final VoidCallback? onEditPressed;
  final MaterialColor themeColor;
  final String? status;
  final bool showStats;
  final bool showShadow;
  final double borderRadius;
  final double borderWidth;
  final Color backgroundColor;

  const ProfileAvatarCard({
    super.key,
    required this.name,
    required this.level,
    required this.likes,
    required this.themeColor,
    this.showEditButton = false,
    this.size = 80,
    this.onEditPressed,
    this.status,
    this.showStats = true,
    this.showShadow = true,
    this.borderRadius = 16,
    this.borderWidth = 3,
    this.backgroundColor = Colors.white,
  });

  Widget _buildCoinIcon({double size = 20, Color color = Colors.amber}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            color,
            color.withOpacity(0.8),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
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

  Widget _buildMiniStat(IconData icon, String value, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 14,
          color: color,
        ),
        const SizedBox(width: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size + 20,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: showShadow ? [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            spreadRadius: 0,
            offset: const Offset(0, 4),
          ),
        ] : null,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Avatar with Edit Button and Status
          Container(
            margin: const EdgeInsets.all(10),
            child: Stack(
              children: [
                Container(
                  width: size,
                  height: size,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        themeColor[300]!,
                        themeColor[600]!,
                      ],
                    ),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: backgroundColor,
                      width: borderWidth,
                    ),
                    boxShadow: showShadow ? [
                      BoxShadow(
                        color: themeColor.withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ] : null,
                  ),
                  child: Icon(
                    Icons.person,
                    size: size * 0.5,
                    color: Colors.white,
                  ),
                ),
                if (showEditButton)
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: GestureDetector(
                      onTap: onEditPressed,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: backgroundColor,
                          shape: BoxShape.circle,
                          boxShadow: showShadow ? [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ] : null,
                        ),
                        child: Icon(
                          Icons.edit,
                          size: size * 0.2,
                          color: themeColor,
                        ),
                      ),
                    ),
                  ),
                if (status != null)
                  Positioned(
                    right: showEditButton ? 24 : 0,
                    bottom: 0,
                    child: Container(
                      width: size * 0.25,
                      height: size * 0.25,
                      decoration: BoxDecoration(
                        color: status == 'Online' 
                            ? Colors.green 
                            : Colors.grey,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: backgroundColor,
                          width: 2,
                        ),
                        boxShadow: showShadow ? [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ] : null,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          // Stats Row
          if (showStats)
            Container(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildMiniStat(Icons.star, level.toString(), Colors.amber),
                  Container(
                    height: 12,
                    width: 1,
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    color: Colors.grey[300],
                  ),
                  _buildMiniStat(Icons.favorite, likes.toString(), Colors.red[400]!),
                ],
              ),
            ),
        ],
      ),
    );
  }
} 