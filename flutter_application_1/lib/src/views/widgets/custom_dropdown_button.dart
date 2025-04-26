import 'package:flutter/material.dart';

class CustomDropdownButton extends StatefulWidget {
  final String hintText;
  final List<String> items;
  final String? value;
  final ValueChanged<String?> onChanged;
  final Color? backgroundColor;
  final Color? textColor;
  final double? fontSize;
  final EdgeInsetsGeometry? padding;
  final OutlinedBorder? shape;
  final double? elevation;
  final double? width;
  final double? height;

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
    _selectedValue = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
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
          isExpanded: true,
          alignment: AlignmentDirectional.centerStart,
          menuMaxHeight: 200,
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
          style: const TextStyle( 
            color: Colors.black,
            fontSize: 17,
          ),
          items: widget.items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
                child: Text(
                  item,
                  style: TextStyle(
                    color: widget.textColor ?? Colors.black,
                    fontSize: widget.fontSize ?? 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            );
          }).toList(),
          icon: Icon(
            Icons.arrow_drop_down,
            color: widget.textColor ?? Colors.white,
          ),
          dropdownColor: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
