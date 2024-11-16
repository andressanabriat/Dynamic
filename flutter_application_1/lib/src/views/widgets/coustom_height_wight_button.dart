import 'package:flutter/material.dart';

class CoustomHeightWightButton extends StatefulWidget {
  final int minValue;
  final int maxValue;
  final int step;
  final int initialValue;
  final ValueChanged<int> onValueChanged;
  final Color? backgroundColor;
  final Color? textColor;
  final double? width;
  final double? height;
  final TextStyle? valueStyle;

  CoustomHeightWightButton({
    required this.minValue,
    required this.maxValue,
    required this.step,
    required this.initialValue,
    required this.onValueChanged,
    this.backgroundColor,
    this.textColor,
    this.width,
    this.height,
    this.valueStyle,
  });

  @override
  _CoustomHeightWightButtonState createState() =>
      _CoustomHeightWightButtonState();
}

class _CoustomHeightWightButtonState extends State<CoustomHeightWightButton> {
  late int currentValue;

  @override
  void initState() {
    super.initState();
    currentValue = widget.initialValue;
  }

  void _incrementValue() {
    if (currentValue + widget.step <= widget.maxValue) {
      setState(() {
        currentValue += widget.step;
        widget.onValueChanged(currentValue);
      });
    }
  }

  void _decrementValue() {
    if (currentValue - widget.step >= widget.minValue) {
      setState(() {
        currentValue -= widget.step;
        widget.onValueChanged(currentValue);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width ?? 355,
      height: widget.height ?? 55,
      decoration: BoxDecoration(
        color: widget.backgroundColor ?? const Color.fromARGB(128, 186, 178, 178),
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: _decrementValue,
            icon: Icon(
              Icons.remove,
              color: widget.textColor ?? Colors.blue,
            ),
          ),
          Text(
            '$currentValue',
            style: widget.valueStyle ??
                TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: widget.textColor ?? Colors.blue,
                ),
          ),
          IconButton(
            onPressed: _incrementValue,
            icon: Icon(
              Icons.add,
              color: widget.textColor ?? Colors.blue,
            ),
          ),
        ],
      ),
    );
  }
}
