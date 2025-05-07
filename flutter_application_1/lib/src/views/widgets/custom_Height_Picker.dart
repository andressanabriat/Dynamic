import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomHeightPicker extends StatefulWidget {
  final Color? backgroundColor;
  final Color? textColor;
  final double? width;
  final double? height;
  final TextStyle? valueStyle;
  final double? initialValue;
  final ValueChanged<double> onHeightChanged;

  const CustomHeightPicker({
    required this.onHeightChanged,
    this.backgroundColor,
    this.textColor,
    this.width,
    this.height,
    this.valueStyle,
    this.initialValue,
  });

  @override
  State<CustomHeightPicker> createState() => _CustomHeightPickerState();
}

class _CustomHeightPickerState extends State<CustomHeightPicker> {
  int _selectedMeters = 1;
  int _selectedCentimeters = 75;

  void _showPicker(BuildContext context) {
    int meterIndex = _selectedMeters;
    int cmIndex = _selectedCentimeters;

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
                        scrollController: FixedExtentScrollController(initialItem: meterIndex),
                        itemExtent: 40.0,
                        onSelectedItemChanged: (index) {
                          meterIndex = index;
                        },
                        children: List.generate(4, (index) {
                          return Center(
                            child: Text(
                              '$index',
                              style: TextStyle(fontSize: 20),
                            ),
                          );
                        }),
                      ),
                    ),
                    Text(
                      "m",
                      style: TextStyle(fontSize: 18),
                    ),
                    Expanded(
                      flex: 1,
                      child: CupertinoPicker(
                        scrollController: FixedExtentScrollController(initialItem: cmIndex),
                        itemExtent: 40.0,
                        onSelectedItemChanged: (index) {
                          cmIndex = index;
                        },
                        children: List.generate(100, (index) {
                          return Center(
                            child: Text(
                              '${index.toString().padLeft(2, '0')}',
                              style: TextStyle(fontSize: 20),
                            ),
                          );
                        }),
                      ),
                    ),
                    Text(
                      "cm",
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _selectedMeters = meterIndex;
                  _selectedCentimeters = cmIndex;
                });
                Navigator.of(context).pop();
                widget.onHeightChanged(
                  _selectedMeters + _selectedCentimeters / 100.0,
                );
              },
              child: Text(
                "Aceptar",
                style: TextStyle(fontSize: 18, color: widget.textColor ?? const Color.fromARGB(255, 0, 0, 0)),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final formattedValue = '${_selectedMeters}.${_selectedCentimeters.toString().padLeft(2, '0')} m';

    return GestureDetector(
      onTap: () => _showPicker(context),
      child: Container(
        width: widget.width ?? 355,
        height: widget.height ?? 55,
        padding: EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          color: widget.backgroundColor ?? const Color.fromARGB(128, 186, 178, 178),
          borderRadius: BorderRadius.circular(30.0),
        ),
        alignment: Alignment.centerLeft,
        child: Text(
          formattedValue,
          style: widget.valueStyle ??
              TextStyle(
                fontSize: 17,
                color: Color.fromARGB(255, 84, 77, 77),
                fontWeight: FontWeight.w600,
              ),
        ),
      ),
    );
  }
}
