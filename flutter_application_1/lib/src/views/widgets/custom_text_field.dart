import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Color? fillColor;
  final TextStyle? hintStyle;
  final EdgeInsetsGeometry? contentPadding;
  final double? width;
  final double? height;
  final bool autofocus;
  final FocusNode? focusNode;
  final bool readOnly; // ✅ Nuevo parámetro

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
    this.autofocus = false,
    this.focusNode,
    this.readOnly = false, // ✅ Valor por defecto
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
        autofocus: autofocus,
        focusNode: focusNode,
        readOnly: readOnly, // ✅ Uso del nuevo parámetro
        enableInteractiveSelection: false,
        toolbarOptions: ToolbarOptions(
          copy: false,
          cut: false,
          paste: false,
          selectAll: false,
        ),
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
