import 'package:flutter/material.dart';
import 'package:foody_licious/core/constant/colors.dart';

class BouncyIcon extends StatefulWidget {
  const BouncyIcon({
    required this.icon,
    this.size = 80,
    this.color = kTextRed,
  });
  final IconData icon;
  final double size;
  final Color color;

  @override
  State<BouncyIcon> createState() => _BouncyIconState();
}

class _BouncyIconState extends State<BouncyIcon>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 900))
    ..repeat(reverse: true);
  late final Animation<double> _scale = Tween(begin: 0.96, end: 1.04)
      .animate(CurvedAnimation(parent: _c, curve: Curves.easeInOut));

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scale,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: widget.color.withOpacity(0.15),
          border: Border.all(color: widget.color.withOpacity(0.6)),
          boxShadow: [
            BoxShadow(
              blurRadius: 30,
              spreadRadius: 2,
              color: widget.color.withOpacity(0.25),
            ),
          ],
        ),
        child: Icon(widget.icon, size: widget.size, color: widget.color),
      ),
    );
  }
}
