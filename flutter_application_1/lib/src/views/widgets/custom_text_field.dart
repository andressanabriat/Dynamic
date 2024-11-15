import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget { // Calse para crear y personalizar campos de texto
  final String hintText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Color? fillColor;
  final TextStyle? hintStyle;
  final EdgeInsetsGeometry? contentPadding;
  final double? width; 
  final double? height; 

  CustomTextField({
    required this.hintText,
    this.controller,
    this.keyboardType,
    this.obscureText = false,
    this.fillColor,
    this.hintStyle,
    this.contentPadding,
    this.width, 
    this.height, 
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width, 
      height: height, 
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: hintStyle ?? TextStyle(fontSize: 17, color: Colors.grey),
          filled: true,
          fillColor: fillColor ?? Color.fromARGB(128, 186, 178, 178),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide.none,
          ),
          contentPadding: contentPadding ?? EdgeInsets.symmetric(vertical: 15.0, horizontal: 25.0),
        ),
      ),
    );
  }
}
