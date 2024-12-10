import 'package:flutter/material.dart';
import '../colors.dart';

class StylishFAB extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final Color color;
  final Color iconColor;

  const StylishFAB({super.key, 
    required this.onPressed,
    required this.icon,
    this.color = AppColors.primaryColor,
    this.iconColor = AppColors.white,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: color,
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      splashColor: AppColors.primaryColor.withOpacity(0.3),
      child: Icon(
        icon,
        color: iconColor,
        size: 30,
      ),
    );
  }
}
