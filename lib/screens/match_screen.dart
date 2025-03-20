import 'package:flutter/material.dart';
import '../components/profile_avatar_card.dart';
import 'dart:async';
import 'end_match_screen.dart';

class MatchScreen extends StatefulWidget {
  final String selectedMainCategory;
  final MaterialColor selectedColor;
  final Map<String, dynamic> user;

  const MatchScreen({
    super.key,
    required this.selectedMainCategory,
    required this.selectedColor,
    required this.user,
  });

  @override
  State<MatchScreen> createState() => _MatchScreenState();
}

class _MatchScreenState extends State<MatchScreen> with SingleTickerProviderStateMixin {
  bool isAudioEnabled = false;
  String? currentEmoji;
  late Timer _timer;
  int _timeLeft = 60;
  late AnimationController _emojiAnimationController;
  late Animation<double> _emojiScaleAnimation;

  @override
  void initState() {
    super.initState();
    _startTimer();
    _emojiAnimationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _emojiScaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _emojiAnimationController,
      curve: Curves.elasticOut,
    ));

    _emojiAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(const Duration(seconds: 2), () {
          if (mounted) {
            setState(() {
              currentEmoji = null;
            });
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _emojiAnimationController.dispose();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          if (_timeLeft > 0) {
            _timeLeft--;
          } else {
            _timer.cancel();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => EndMatchScreen(
                  selectedColor: widget.selectedColor,
                  user: widget.user,
                ),
              ),
            );
          }
        });
      }
    });
  }

  void _showEmojiPicker() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Emoji Seç'),
        content: Wrap(
          spacing: 16,
          children: ['😊', '😍', '😂', '👋', '❤️'].map((emoji) {
            return InkWell(
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  currentEmoji = emoji;
                });
                _emojiAnimationController.forward(from: 0);
              },
              child: Text(
                emoji,
                style: const TextStyle(fontSize: 32),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Color _getTimerColor() {
    if (_timeLeft <= 10) {
      final opacity = (10 - _timeLeft) / 10;
      return Color.lerp(Colors.white, Colors.red, opacity)!;
    }
    return Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    final double buttonWidth = 100.0;
    final double totalButtonsWidth = (buttonWidth * 3) + 16.0; // 3 buttons with 8px gaps
    final double horizontalPadding = (MediaQuery.of(context).size.width - totalButtonsWidth) / 2;
    final double containerWidth = (totalButtonsWidth - 8) / 2; // Equal width for profile card and timer

    return Scaffold(
      backgroundColor: widget.selectedColor[900],
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Audio and Emoji Controls
                  Padding(
                    padding: EdgeInsets.only(right: horizontalPadding, bottom: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        _buildControlButton(
                          icon: Icons.emoji_emotions_outlined,
                          isSelected: false,
                          onTap: _showEmojiPicker,
                        ),
                        const SizedBox(width: 8),
                        _buildControlButton(
                          icon: isAudioEnabled ? Icons.volume_up : Icons.volume_off,
                          isSelected: isAudioEnabled,
                          onTap: () {
                            setState(() {
                              isAudioEnabled = !isAudioEnabled;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  // Profile Card and Timer Row
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Left Side - Profile Card
                        Container(
                          width: containerWidth,
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
                                  width: containerWidth - 20,
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
                                  width: containerWidth - 20,
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
                        const SizedBox(width: 8),
                        // Timer Container
                        Container(
                          width: containerWidth,
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
                          child: Center(
                            child: Text(
                              _timeLeft.toString().padLeft(2, '0'),
                              style: TextStyle(
                                fontSize: 48,
                                fontWeight: FontWeight.bold,
                                color: _getTimerColor(),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Action Buttons
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildActionButton(
                          icon: Icons.timer_rounded,
                          label: 'Extend Time',
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) => _buildExtendTimeDialog(context),
                            );
                          },
                        ),
                        _buildActionButton(
                          icon: Icons.person_add_rounded,
                          label: 'Add Friend',
                          onTap: () {
                            // Handle add friend
                          },
                        ),
                        _buildActionButton(
                          icon: Icons.monetization_on_rounded,
                          label: 'Send Gold',
                          onTap: () {
                            // Handle send gold
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  // End Match Button
                  SizedBox(
                    width: 100,
                    height: 40,
                    child: Material(
                      color: Colors.red[400],
                      borderRadius: BorderRadius.circular(20),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Center(
                          child: Text(
                            'End Match',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (currentEmoji != null)
              Positioned.fill(
                child: Container(
                  color: Colors.black26,
                  child: AnimatedBuilder(
                    animation: _emojiScaleAnimation,
                    builder: (context, child) {
                      return Center(
                        child: Transform.scale(
                          scale: _emojiScaleAnimation.value,
                          child: Text(
                            currentEmoji!,
                            style: const TextStyle(
                              fontSize: 120,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
          ],
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
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Container(
          width: 100,
          height: 100,
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
                size: 32,
              ),
              const SizedBox(height: 8),
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

  Widget _buildExtendTimeDialog(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Extend Match Time',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildTimeOption('5 min', '100 Gold'),
                _buildTimeOption('10 min', '180 Gold'),
                _buildTimeOption('15 min', '250 Gold'),
              ],
            ),
            const SizedBox(height: 24),
            Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(25),
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    color: widget.selectedColor,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: const Center(
                    child: Text(
                      'Extend Time',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
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

  Widget _buildTimeOption(String time, String price) {
    return Container(
      width: 80,
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: widget.selectedColor[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: widget.selectedColor[200]!,
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Text(
            time,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: widget.selectedColor[700],
            ),
          ),
          const SizedBox(height: 4),
          Text(
            price,
            style: TextStyle(
              fontSize: 12,
              color: widget.selectedColor[700],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildControlButton({
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Container(
          width: 45,
          height: 45,
          decoration: BoxDecoration(
            color: isSelected ? widget.selectedColor[700] : Colors.grey[300],
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Icon(
            icon,
            color: isSelected ? Colors.white : Colors.grey[700],
            size: 24,
          ),
        ),
      ),
    );
  }
} 