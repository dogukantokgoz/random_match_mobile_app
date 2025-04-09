import 'package:flutter/material.dart';
import 'dart:math' as math;

class AnimatedGradient extends StatefulWidget {
  final Widget child;

  const AnimatedGradient({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  State<AnimatedGradient> createState() => _AnimatedGradientState();
}

class _AnimatedGradientState extends State<AnimatedGradient>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    
    _controller = AnimationController(
      duration: const Duration(seconds: 6),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        final angle = _controller.value * 2 * math.pi;
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(math.cos(angle), math.sin(angle)),
              end: Alignment(-math.cos(angle), -math.sin(angle)),
              colors: const [
                Color(0xFF1A1A1A),
                Color(0xFF0D0D0D),
                Color(0xFF000000),
              ],
            ),
          ),
          child: widget.child,
        );
      },
    );
  }
} 