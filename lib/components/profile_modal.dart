import 'package:flutter/material.dart';

class ProfileModal extends StatelessWidget {
  final String name;
  final String status;
  final int level;
  final int likes;
  final MaterialColor selectedColor;
  final String bio;

  const ProfileModal({
    super.key,
    required this.name,
    required this.status,
    required this.level,
    required this.likes,
    required this.selectedColor,
    this.bio = "Hey there! I'm using Random Match",
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: 216,
        constraints: BoxConstraints(
          minHeight: 140,
          maxHeight: 180,
        ),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.98),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: selectedColor[900]!,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 15,
              offset: const Offset(0, 4),
            ),
            BoxShadow(
              color: selectedColor.withOpacity(0.05),
              blurRadius: 20,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Profile Picture and Stats Row
                  Container(
                    width: double.infinity,
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
                                selectedColor[400]!,
                                selectedColor[600]!,
                              ],
                            ),
                            border: Border.all(
                              color: Colors.white,
                              width: 3,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: selectedColor.withOpacity(0.2),
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
                            Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.amber[600],
                                  size: 16,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  level.toString(),
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                Icon(
                                  Icons.favorite,
                                  color: Colors.red[400],
                                  size: 16,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  likes.toString(),
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  // User Info
                  Container(
                    width: double.infinity,
                    child: Column(
                      children: [
                        Text(
                          name,
                          style: const TextStyle(
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
                          bio,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: -12,
              right: -12,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => Navigator.pop(context),
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: selectedColor[900]!,
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.close,
                      size: 18,
                      color: selectedColor[900],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 