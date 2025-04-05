import 'package:flutter/material.dart';

class EndMatchScreen extends StatefulWidget {
  final MaterialColor selectedColor;
  final Map<String, dynamic> user;

  const EndMatchScreen({
    super.key,
    required this.selectedColor,
    required this.user,
  });

  @override
  State<EndMatchScreen> createState() => _EndMatchScreenState();
}

class _EndMatchScreenState extends State<EndMatchScreen> {
  bool _showActionButtons = true;
  bool _showDislikeOptions = false;
  bool _showLikeOptions = false;

  void _showConfirmationDialog({
    required String title,
    required String content,
    required VoidCallback onConfirm,
  }) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: widget.selectedColor[900]!,
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[900],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                content,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () => Navigator.pop(context),
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            'Vazgeç',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey[800],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          onConfirm();
                        },
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          decoration: BoxDecoration(
                            color: widget.selectedColor[900],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            'Evet',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showGoldConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: widget.selectedColor[900]!,
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Tekrar Ara',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[900],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '3 altın kullanacaksınız, emin misiniz?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () => Navigator.pop(context),
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            'Vazgeç',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey[800],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          // Handle gold usage here
                        },
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          decoration: BoxDecoration(
                            color: widget.selectedColor[900],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            'Evet',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
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

  @override
  Widget build(BuildContext context) {
    final double buttonWidth = 100.0;
    final double totalButtonsWidth = (buttonWidth * 2) + 16.0; // 2 buttons with gap
    final double cardWidth = totalButtonsWidth;

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
                                  value: widget.user['level'].toString(),
                                  color: Colors.amber,
                                ),
                                const SizedBox(height: 6),
                                _buildMiniStat(
                                  icon: Icons.favorite,
                                  value: widget.user['likes'].toString(),
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
                            Text(
                              widget.user['name'],
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
                              widget.user['status'] ?? 'Offline',
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
              if (_showActionButtons)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildActionButton(
                      icon: Icons.close,
                      label: 'Dislike',
                      onTap: () {
                        setState(() {
                          _showActionButtons = false;
                          _showDislikeOptions = true;
                        });
                      },
                    ),
                    const SizedBox(width: 16),
                    _buildActionButton(
                      icon: Icons.favorite,
                      label: 'Like',
                      onTap: () {
                        setState(() {
                          _showActionButtons = false;
                          _showLikeOptions = true;
                        });
                      },
                    ),
                  ],
                ),
              if (_showDislikeOptions)
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildActionButton(
                          icon: Icons.report,
                          label: 'Şikayet Et',
                          onTap: () {
                            _showConfirmationDialog(
                              title: 'Şikayet Et',
                              content: 'Bu kullanıcıyı şikayet etmek istediğinize emin misiniz?',
                              onConfirm: () {
                                // Handle report
                                Navigator.pop(context);
                              },
                            );
                          },
                        ),
                        const SizedBox(width: 16),
                        _buildActionButton(
                          icon: Icons.block,
                          label: 'Engelle',
                          onTap: () {
                            _showConfirmationDialog(
                              title: 'Engelle',
                              content: 'Bu kullanıcıyı engellemek istediğinize emin misiniz?',
                              onConfirm: () {
                                // Handle block
                                Navigator.pop(context);
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              if (_showLikeOptions)
                _buildActionButton(
                  icon: Icons.person_add,
                  label: 'Arkadaş Ekle',
                  onTap: () {
                    // Handle add friend
                    Navigator.pop(context);
                  },
                ),
              const SizedBox(height: 24),
              // Bottom Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildActionButton(
                    icon: Icons.monetization_on,
                    label: 'Tekrar Ara',
                    onTap: _showGoldConfirmationDialog,
                    height: 50,
                    showGoldValue: true,
                  ),
                  const SizedBox(width: 16),
                  _buildActionButton(
                    icon: Icons.arrow_forward,
                    label: 'Geç',
                    onTap: () {
                      Navigator.pop(context);
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
    bool showGoldValue = false,
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
              if (showGoldValue) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      icon,
                      color: Colors.amber,
                      size: height * 0.32,
                    ),
                    const SizedBox(width: 4),
                    const Text(
                      '3',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ] else
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