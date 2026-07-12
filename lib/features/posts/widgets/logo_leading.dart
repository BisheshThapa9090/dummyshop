import 'package:flutter/material.dart';

class LogoLeading extends StatelessWidget {
  final double size;
  final VoidCallback? onTap;

  const LogoLeading({
    super.key,
    this.size = 40,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset(
          'assets/images/Pixel_Mart.png',
          width: size,
          height: size,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}