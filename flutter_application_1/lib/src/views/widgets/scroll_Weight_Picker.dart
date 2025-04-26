import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DualWeightPickerButton extends StatefulWidget {
  final int minValue;
  final int maxValue;
  final int initialInteger;
  final int initialDecimal;
  final ValueChanged<double> onValueChanged;
  final Color? backgroundColor;
  final Color? textColor;
  final double? width;
  final double? height;

  const DualWeightPickerButton({
    required this.minValue,
    required this.maxValue,
    required this.initialInteger,
    required this.initialDecimal,
    required this.onValueChanged,
    this.backgroundColor,
    this.textColor,
    this.width,
    this.height,
  });

  @override
  State<DualWeightPickerButton> createState() => _DualWeightPickerButtonState();
}

class _DualWeightPickerButtonState extends State<DualWeightPickerButton> {
  late int _selectedInt;
  late int _selectedDecimal;

  @override
  void initState() {
    super.initState();
    _selectedInt = widget.initialInteger;
    _selectedDecimal = widget.initialDecimal;
  }

  void _showWeightPicker(BuildContext context) {
    int intIndex = _selectedInt - widget.minValue;
    int decIndex = _selectedDecimal;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SizedBox(
                height: 200,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: CupertinoPicker(
                        scrollController: FixedExtentScrollController(initialItem: intIndex),
                        itemExtent: 40.0,
                        onSelectedItemChanged: (index) {
                          intIndex = index;
                        },
                        children: List.generate(widget.maxValue - widget.minValue + 1, (index) {
                          final value = widget.minValue + index;
                          return Center(
                            child: Text(
                              '$value',
                              style: TextStyle(fontSize: 20),
                            ),
                          );
                        }),
                      ),
                    ),
                    Text(
                      ".",
                      style: TextStyle(fontSize: 24),
                    ),
                    Expanded(
                      flex: 1,
                      child: CupertinoPicker(
                        scrollController: FixedExtentScrollController(initialItem: decIndex),
                        itemExtent: 40.0,
                        onSelectedItemChanged: (index) {
                          decIndex = index;
                        },
                        children: List.generate(10, (index) {
                          return Center(
                            child: Text(
                              '$index',
                              style: TextStyle(fontSize: 20),
                            ),
                          );
                        }),
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      "kg",
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _selectedInt = widget.minValue + intIndex;
                  _selectedDecimal = decIndex;
                });
                Navigator.of(context).pop();
                widget.onValueChanged(_selectedInt + _selectedDecimal / 10.0);
              },
              child: Text(
                "Aceptar",
                style: TextStyle(fontSize: 18, color: widget.textColor ?? const Color.fromARGB(255, 0, 68, 255)),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final fullValue = '${_selectedInt}.${_selectedDecimal} kg';

    return GestureDetector(
      onTap: () => _showWeightPicker(context),
      child: Container(
        width: widget.width ?? 355,
        height: widget.height ?? 55,
        padding: EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          color: widget.backgroundColor ?? Color.fromARGB(128, 186, 178, 178),
          borderRadius: BorderRadius.circular(30),
        ),
        alignment: Alignment.centerLeft,
        child: Text(
          fullValue,
          style: TextStyle(
            fontSize: 17,
            color: widget.textColor ?? Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
