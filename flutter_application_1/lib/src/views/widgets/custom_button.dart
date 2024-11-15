import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget { // Calse para crear y personalizar botones
  final String text;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final double? fontSize;
  final EdgeInsetsGeometry? padding;
  final OutlinedBorder? shape; 
  final double? elevation;
  final Widget? icon; 
  final double? width; 
  final double? height; 

  CustomButton({
    required this.text,
    required this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.fontSize,
    this.padding,
    this.shape,
    this.elevation,
    this.icon,
    this.width, 
    this.height, 
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width, 
      height: height, 
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: icon ?? SizedBox.shrink(), 
        label: Text(
          text,
          style: TextStyle(
            color: textColor ?? Colors.white,
            fontSize: fontSize ?? 18,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? Theme.of(context).primaryColor,
          foregroundColor: textColor ?? Colors.white,
          padding: padding ?? EdgeInsets.symmetric(horizontal: 40, vertical: 15),
          shape: shape ?? RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          elevation: elevation ?? 2,
        ),
      ),
    );
  }
}
