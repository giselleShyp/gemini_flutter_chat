import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  const CircleButton({
    super.key,
    required this.child,
    this.elevation = 2,
    this.size = 50,
    this.color,
    this.shadowColor,
    this.isRotate = true,
    this.onTap,
  });

  final Widget child;
  final double elevation;
  final Color? color;
  final Color? shadowColor;
  final double size;
  final bool isRotate;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: size,
        width: size,
        child: Material(
          color: color,
          shadowColor: shadowColor,
          elevation: elevation,
          borderRadius: BorderRadius.circular(50),
          child: Container(
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
