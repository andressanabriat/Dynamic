import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomDatePickerButton extends StatefulWidget {
  final String hintText; // Texto inicial del botón
  final Color? backgroundColor;
  final Color? textColor;
  final double? fontSize;
  final EdgeInsetsGeometry? padding;
  final OutlinedBorder? shape;
  final double? elevation;
  final double? width;
  final double? height;
  final ValueChanged<int> onAgeCalculated; // Devuelve la edad calculada

  CustomDatePickerButton({
    required this.hintText,
    required this.onAgeCalculated,
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
  _CustomDatePickerButtonState createState() => _CustomDatePickerButtonState();
}

class _CustomDatePickerButtonState extends State<CustomDatePickerButton> {
  String? _selectedDate;

  // Método para mostrar el selector de fechas
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900), // Fecha mínima
      lastDate: DateTime.now(), // Fecha máxima (hoy)
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: widget.backgroundColor ?? Colors.blue, // Color del header
              onPrimary: Colors.white, // Color del texto en el header
              onSurface: widget.textColor ?? Colors.black, // Color del texto en la lista
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: widget.backgroundColor ?? Colors.blue, // Color de los botones
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      final int age = _calculateAge(pickedDate);
      setState(() {
        _selectedDate = DateFormat('dd/MM/yyyy').format(pickedDate);
      });
      widget.onAgeCalculated(age); // Devolver la edad calculada
    }
  }

  // Método para calcular la edad
  int _calculateAge(DateTime birthDate) {
    final DateTime today = DateTime.now();
    int age = today.year - birthDate.year;
    if (today.month < birthDate.month ||
        (today.month == birthDate.month && today.day < birthDate.day)) {
      age--;
    }
    return age;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      child: ElevatedButton(
        onPressed: () => _selectDate(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: widget.backgroundColor ?? Theme.of(context).primaryColor,
          foregroundColor: widget.textColor ?? Colors.white,
          padding: widget.padding ?? EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: widget.shape ?? RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          elevation: widget.elevation ?? 2,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _selectedDate ?? widget.hintText,
              style: TextStyle(
                color: widget.textColor ?? Colors.white,
                fontSize: widget.fontSize ?? 18,
              ),
            ),
            Icon(
              Icons.calendar_today,
              color: widget.textColor ?? Colors.white,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
