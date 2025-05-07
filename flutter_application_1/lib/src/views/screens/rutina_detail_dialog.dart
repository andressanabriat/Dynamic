import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/shared/themes/colors.dart';
import '../widgets/custom_button.dart';

class RutinaDetailDialog extends StatefulWidget {
  final Map<String,dynamic> data;
  final String rutinaId;
  RutinaDetailDialog({required this.data, required this.rutinaId});

  @override
  _RutinaDetailDialogState createState() => _RutinaDetailDialogState();
}

class _RutinaDetailDialogState extends State<RutinaDetailDialog> {
  late final List<String> _originalDias;
  late final Map<String,dynamic> _originalEjercicios;

  late List<String> dias;
  late Map<String,dynamic> ejercicios;
  String? selectedDay;
  bool editando = false;

  @override
  void initState() {
    super.initState();
    _originalDias = List<String>.from(widget.data['dias'] ?? []);
    _originalEjercicios = Map<String,dynamic>.from(widget.data['ejercicios'] ?? {});
    _resetToOriginal();
  }

  void _resetToOriginal() {
    setState(() {
      dias = List.from(_originalDias);
      ejercicios = Map.from(_originalEjercicios);
      selectedDay = dias.isNotEmpty ? dias.first : null;
      editando = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.close, color: Colors.red),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(widget.data['nombre'] ?? '', style: TextStyle(color: AppColors.primary)),
      ),
      body: Column(
        children: [
          // Aquí vas a reconstruir tu UI: días, lista de ejercicios,
          // botones de añadir/quitar grupos, etc., usando las variables
          // `ejercicios`, `selectedDay` y `editando`.
          Spacer(),
          ElevatedButton(
            child: Text(editando ? 'Cancelar edición' : 'Editar rutina'),
            onPressed: () {
              if (editando) _resetToOriginal();
              else setState(() => editando = true);
            },
          ),
          if (editando)
            ElevatedButton(
              child: Text('Guardar cambios'),
              onPressed: () async {
                await FirebaseFirestore.instance
                  .collection('rutinas')
                  .doc(widget.rutinaId)
                  .update({'ejercicios': ejercicios});
                Navigator.pop(context);
              },
            ),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}
