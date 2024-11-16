import 'package:flutter/material.dart';

class CustomDropdownButton extends StatefulWidget {
  final String hintText;  // Texto inicial del dropdown
  final List<String> items;  // Lista de opciones
  final String? value;  // Valor seleccionado
  final ValueChanged<String?> onChanged;  // Acción cuando cambia la selección
  final Color? backgroundColor;  // Color del fondo
  final Color? textColor;  // Color del texto
  final double? fontSize;  // Tamaño de la fuente
  final EdgeInsetsGeometry? padding;  // Padding del botón
  final OutlinedBorder? shape;  // Forma del botón
  final double? elevation;  // Elevación del botón
  final double? width;  // Ancho del botón
  final double? height;  // Altura del botón

  CustomDropdownButton({
    required this.hintText,
    required this.items,
    required this.onChanged,
    this.value,
    this.backgroundColor,
    this.textColor,
    this.fontSize,
    this.padding,
    this.shape,
    this.elevation,
    this.width,
    this.height,
  });

  @override
  _CustomDropdownButtonState createState() => _CustomDropdownButtonState();
}

class _CustomDropdownButtonState extends State<CustomDropdownButton> {
  String? _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.value;  // Inicializar con el valor inicial si está definido
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      padding: widget.padding ?? EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: widget.backgroundColor ?? Theme.of(context).primaryColor,
        borderRadius: (widget.shape is RoundedRectangleBorder)
            ? (widget.shape as RoundedRectangleBorder).borderRadius
            : BorderRadius.circular(8.0),
        boxShadow: [
          if (widget.elevation != null)
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: widget.elevation!,
              offset: Offset(0, widget.elevation! / 2),
            ),
        ],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          hint: Text(
            widget.hintText,
            style: TextStyle(
              color: widget.textColor ?? Colors.white,
              fontSize: widget.fontSize ?? 18,
            ),
          ),
          value: _selectedValue,
          onChanged: (newValue) {
            setState(() {
              _selectedValue = newValue;
            });
            widget.onChanged(newValue);
          },
          items: widget.items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                style: TextStyle(
                  color: widget.textColor ?? Colors.black,
                  fontSize: widget.fontSize ?? 18,
                ),
              ),
            );
          }).toList(),
          icon: Icon(
            Icons.arrow_drop_down,
            color: widget.textColor ?? Colors.white,
          ),
          dropdownColor: widget.backgroundColor ?? Colors.white,
        ),
      ),
    );
  }
}
