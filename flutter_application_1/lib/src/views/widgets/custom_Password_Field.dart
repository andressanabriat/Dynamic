import 'package:flutter/material.dart';

class CustomPasswordField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final Color? fillColor;
  final double? width;
  final double? height;
  final double? fontSize;

  const CustomPasswordField({
    required this.controller,
    required this.hintText,
    this.fillColor,
    this.width,
    this.height,
    this.fontSize,
  });

  @override
  State<CustomPasswordField> createState() => _CustomPasswordFieldState();
}

class _CustomPasswordFieldState extends State<CustomPasswordField> {
  bool _obscureText = true;

  void _toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      child: TextField(
        controller: widget.controller,
        obscureText: _obscureText,
        enableInteractiveSelection: false,
        toolbarOptions: ToolbarOptions(
          copy: false,
          cut: false,
          paste: false,
          selectAll: false,
        ),
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: TextStyle(
            fontSize: widget.fontSize ?? 17,
            color: const Color.fromARGB(255, 108, 97, 97),
          ),
          filled: true,
          fillColor: widget.fillColor ?? const Color.fromARGB(128, 186, 178, 178),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 25.0),
          suffixIcon: IconButton(
            icon: Icon(
              _obscureText ? Icons.visibility_off : Icons.visibility,
              color: const Color.fromARGB(255, 108, 97, 97),
            ),
            onPressed: _toggleVisibility,
          ),
        ),
      ),
    );
  }
}
