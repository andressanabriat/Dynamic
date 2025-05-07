import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
import 'package:flutter_application_1/shared/themes/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';  

class CreateNewRoutine extends StatefulWidget {
  final String userEmail;

  CreateNewRoutine({required this.userEmail}); // pasa el email al instanciar

  @override
  _CreateNewRoutineState createState() => _CreateNewRoutineState();
}

class _CreateNewRoutineState extends State<CreateNewRoutine> {
  final TextEditingController _routineNameController = TextEditingController();
  final FocusNode _routineNameFocusNode = FocusNode();

  // Nueva variable para el objetivo
  String _selectedObjective = "¿Cual es tu objetivo?";

  // Opciones para el objetivo
  final List<String> _objectiveOptions = [
    "Hipertrofia",
    "Definición muscular",
    "Perder peso"
  ];

  // Vista de entrada: selección de días
  List<bool> _selectedDays = List.generate(7, (_) => false);
  final List<String> _days = [
    'Lunes',
    'Martes',
    'Miércoles',
    'Jueves',
    'Viernes',
    'Sábado',
    'Domingo'
  ];

  // Vista resumen: se selecciona un único día (pestaña activa)
  bool _showSummary = false;
  int? _selectedSummaryDay; // índice del día activo

  // Para cada día seleccionado se guardarán los detalles;
  // Cada RoutineDetail contiene una lista de grupos de ejercicio.
  Map<int, RoutineDetail> _routineDetails = {};

  @override
  void initState() {
    super.initState();
    // Forzar el foco en el campo de nombre al abrir el modal
    Future.delayed(Duration(milliseconds: 300), () {
      FocusScope.of(context).requestFocus(_routineNameFocusNode);
    });
  }

  @override
  void dispose() {
    _routineNameController.dispose();
    _routineNameFocusNode.dispose();
    _routineDetails.forEach((key, detail) {
      detail.dispose();
    });
    super.dispose();
  }

  // Devuelve la inicial para cada día (para Miércoles se usa "X")
  String getInitial(String day) {
    switch (day) {
      case 'Lunes':
        return 'L';
      case 'Martes':
        return 'M';
      case 'Miércoles':
        return 'X';
      case 'Jueves':
        return 'J';
      case 'Viernes':
        return 'V';
      case 'Sábado':
        return 'S';
      case 'Domingo':
        return 'D';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return _showSummary ? _buildSummaryView() : _buildInputView();
  }

  Future<void> _guardarRutinaEnFirebase() async {
    try {
      final String nombreRutina = _routineNameController.text.trim();
      if (nombreRutina.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Por favor, ingresa el nombre de la rutina')),
        );
        return;
      }

      final List<String> dias = [];
      final Map<String, dynamic> ejercicios = {};

      for (int i = 0; i < _selectedDays.length; i++) {
        if (_selectedDays[i] && _routineDetails.containsKey(i)) {
          final diaNombre = _days[i].toLowerCase();
          dias.add(diaNombre);
          final detail = _routineDetails[i]!;

          final List<Map<String, dynamic>> grupos = [];
          for (var group in detail.groups) {
            final String musculo = group.muscleController.text.trim();
            final List<Map<String, dynamic>> ejerciciosGrupo = [];

            for (var row in group.rows) {
              if (row.exerciseController.text.trim().isEmpty) continue;
              ejerciciosGrupo.add({
                'nombre': row.exerciseController.text.trim(),
                'series': row.seriesCount,
                'repeticiones': row.repsControllers.map((c) => c.text.trim()).toList(),
              });
            }

            if (musculo.isNotEmpty && ejerciciosGrupo.isNotEmpty) {
              grupos.add({'musculo': musculo, 'ejercicios': ejerciciosGrupo});
            }
          }

          if (grupos.isNotEmpty) {
            ejercicios[diaNombre] = grupos;
          }
        }
      }

      final rutina = {
        'nombre': nombreRutina,
        'dias': dias,
        'ejercicios': ejercicios,
        'objetivo': _selectedObjective, 
        'CreadaPorGym': false,
        'asignados': [widget.userEmail],
        'gymPassword': "creadaPorApp",
      };

      await FirebaseFirestore.instance.collection('rutinas').add(rutina);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Rutina creada exitosamente')),
      );
      Navigator.of(context).pop(); // cerrar modal
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al guardar rutina: $e')),
      );
    }
  }

  // Vista de entrada
  Widget _buildInputView() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextField(
              hintText: 'Nombre de la rutina',
              controller: _routineNameController,
              width: double.infinity,
              height: 55,
              fillColor: Colors.grey[200],
              hintStyle: TextStyle(fontSize: 16, color: Colors.grey),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 15.0, horizontal: 25.0),
              autofocus: true,
              focusNode: _routineNameFocusNode,
            ),
            SizedBox(height: 10),
            // Dropdown de Objetivo, con estilo similar al campo de texto
            Container(
              width: double.infinity,
              height: 55,
              padding: EdgeInsets.symmetric(horizontal: 25),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: _selectedObjective == "¿Cual es tu objetivo?" ? null : _selectedObjective,
                  hint: Text("¿Cual es tu objetivo?",
                      style: TextStyle(fontSize: 16, color: Colors.grey)),
                  items: _objectiveOptions.map((option) {
                    return DropdownMenuItem<String>(
                      value: option,
                      child: Text(option,
                          style: TextStyle(fontSize: 16, color: Colors.black)),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedObjective = value!;
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Selecciona los días de entreno',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primary),
            ),
            SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List.generate(_days.length, (index) {
                bool isSelected = _selectedDays[index];
                return ChoiceChip(
                  label: Text(_days[index]),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      _selectedDays[index] = selected;
                    });
                  },
                  selectedColor: AppColors.mainBlue,
                  backgroundColor: Colors.grey[300],
                  labelStyle: TextStyle(
                      color: isSelected
                          ? AppColors.secondary
                          : AppColors.primary),
                );
              }),
            ),
            SizedBox(height: 20),
            CustomButton(
              text: 'Siguiente',
              onPressed: () {
                if (_routineNameController.text.trim().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Por favor ingresa el nombre de la rutina')),
                  );
                  return;
                }
                List<int> selectedIndices = [];
                for (int i = 0; i < _selectedDays.length; i++) {
                  if (_selectedDays[i]) selectedIndices.add(i);
                }
                if (selectedIndices.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Selecciona al menos un día de entreno')),
                  );
                  return;
                }
                // Inicializar RoutineDetail para cada día seleccionado
                for (var day in selectedIndices) {
                  if (!_routineDetails.containsKey(day)) {
                    _routineDetails[day] = RoutineDetail();
                  }
                }
                setState(() {
                  _showSummary = true;
                  _selectedSummaryDay = selectedIndices.first;
                });
              },
              backgroundColor: AppColors.mainBlue,
              textColor: AppColors.secondary,
              fontSize: 17,
              padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
              elevation: 4,
              width: double.infinity,
              height: 55,
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // Vista resumen
  Widget _buildSummaryView() {
    String routineName = _routineNameController.text.trim();
    List<int> summaryDays = _routineDetails.keys.toList();
    RoutineDetail currentDetail = _routineDetails[_selectedSummaryDay]!;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Text(routineName,
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.primary)),
            ),
            // Mostrar el objetivo seleccionado debajo del nombre, en fuente más pequeña
            if (_selectedObjective != "¿Cual es tu objetivo?")
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  _selectedObjective,
                  style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                ),
              ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: summaryDays.map((dayIndex) {
                String initial = getInitial(_days[dayIndex]);
                bool isActive = (dayIndex == _selectedSummaryDay);
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedSummaryDay = dayIndex;
                    });
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    margin: EdgeInsets.symmetric(horizontal: 4),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: isActive ? AppColors.mainBlue : Colors.grey[300],
                      shape: BoxShape.circle,
                    ),
                    child: Text(initial,
                        style: TextStyle(
                            color: isActive ? AppColors.secondary : AppColors.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 16)),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            _buildDetailArea(currentDetail),
            SizedBox(height: 20),
            CustomButton(
              text: 'Crear rutina',
              onPressed: _guardarRutinaEnFirebase,
              backgroundColor: AppColors.mainBlue,
              textColor: AppColors.secondary,
              fontSize: 17,
              padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
              elevation: 4,
              width: double.infinity,
              height: 55,
            ),
          ],
        ),
      ),
    );
  }

  // Construye la sección que muestra todos los grupos de ejercicio (dentro de un RoutineDetail)
  Widget _buildDetailArea(RoutineDetail detail) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ...List.generate(detail.groups.length, (groupIndex) {
          return _buildExerciseGroup(detail, groupIndex);
        }),
        SizedBox(height: 8),
        CustomButton(
          text: '+ Añadir grupo muscular',
          onPressed: () {
            setState(() {
              detail.groups.add(ExerciseGroup());
            });
          },
          backgroundColor: AppColors.mainBlue,
          textColor: AppColors.secondary,
          fontSize: 14,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          elevation: 2,
          width: double.infinity,
          height: 40,
        ),
      ],
    );
  }

  // Construye un grupo de ejercicio: Encierra el campo "Músculo", la cabecera y la lista de filas de ejercicio.
  Widget _buildExerciseGroup(RoutineDetail detail, int groupIndex) {
    ExerciseGroup group = detail.groups[groupIndex];
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Primera fila: Campo "Músculo" y, a la derecha, los títulos "Series" y "Repe"
          Row(
            children: [
              Expanded(
                flex: 2,
                child: TextField(
                  controller: group.muscleController,
                  decoration: InputDecoration(
                    hintText: 'Músculo',
                    filled: true,
                    fillColor: Colors.grey[200],
                    hintStyle: TextStyle(fontSize: 15, color: Colors.grey),
                    contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  style: TextStyle(fontSize: 15),
                ),
              ),
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Series', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                    SizedBox(width: 8),
                    Text('Repe', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          // Lista de filas de ejercicio
          Column(
            children: List.generate(group.rows.length, (rowIndex) {
              return _buildExerciseRow(group, rowIndex);
            }),
          ),
          SizedBox(height: 8),
          // Fila de botones para gestionar las filas del grupo (única por grupo)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                iconSize: 35,
                icon: Icon(Icons.remove_circle, color: Colors.red),
                onPressed: () {
                  // Si hay más de una fila en el grupo, elimina la última.
                  if (group.rows.length > 1) {
                    setState(() {
                      group.rows.removeLast();
                    });
                  } else {
                    // Si es la única fila y hay más de un grupo, elimina el grupo completo.
                    if (detail.groups.length > 1) {
                      setState(() {
                        detail.groups.removeAt(groupIndex);
                      });
                    }
                    // Si es la única fila del único grupo, no se elimina.
                  }
                },
              ),
              IconButton(
                iconSize: 35,
                icon: Icon(Icons.add_circle, color: AppColors.mainBlue),
                onPressed: () {
                  setState(() {
                    group.rows.insert(group.rows.length, ExerciseDetail());
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Construye una fila de ejercicio dentro de un grupo.
  Widget _buildExerciseRow(ExerciseGroup group, int rowIndex) {
    ExerciseDetail row = group.rows[rowIndex];
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Campo "Ejercicio"
          Expanded(
            flex: 2,
            child: TextField(
              controller: row.exerciseController,
              decoration: InputDecoration(
                hintText: 'Ejercicio',
                filled: true,
                fillColor: Colors.grey[200],
                hintStyle: TextStyle(fontSize: 15, color: Colors.grey),
                contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide.none,
                ),
              ),
              style: TextStyle(fontSize: 15),
            ),
          ),
          SizedBox(width: 8),
          // Columna derecha: Dropdown de series y RepeticionesDropdown
          Expanded(
            flex: 1,
            child: Row(
              children: [
                Container(
                  width: 50,
                  child: DropdownButtonFormField<int>(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      isDense: true,
                    ),
                    value: row.seriesCount,
                    items: List.generate(10, (index) {
                      int value = index + 1;
                      return DropdownMenuItem<int>(
                        value: value,
                        child: Text(value.toString(), style: TextStyle(fontSize: 10)),
                      );
                    }),
                    onChanged: (value) {
                      setState(() {
                        row.seriesCount = value!;
                        int currentCount = row.repsControllers.length;
                        if (value > currentCount) {
                          for (int i = currentCount; i < value; i++) {
                            row.repsControllers.add(TextEditingController());
                          }
                        } else if (value < currentCount) {
                          row.repsControllers = row.repsControllers.sublist(0, value);
                        }
                      });
                    },
                  ),
                ),
                SizedBox(width: 8),
                Container(
                  width: 50,
                  child: RepeticionesDropdown(
                    seriesCount: row.seriesCount,
                    controllers: row.repsControllers,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Widget para el desplegable de repeticiones.
class RepeticionesDropdown extends StatefulWidget {
  final int seriesCount;
  final List<TextEditingController> controllers;

  RepeticionesDropdown({
    required this.seriesCount,
    required this.controllers,
  });

  @override
  _RepeticionesDropdownState createState() => _RepeticionesDropdownState();
}

class _RepeticionesDropdownState extends State<RepeticionesDropdown> {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  bool _expanded = false;

  void _toggleDropdown() {
    if (_expanded) {
      _removeOverlay();
    } else {
      _showOverlay();
    }
    setState(() {
      _expanded = !_expanded;
    });
  }

  void _showOverlay() {
    _overlayEntry = _createOverlayEntry();
    Overlay.of(context)!.insert(_overlayEntry!);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    Size size = renderBox.size;
    Offset offset = renderBox.localToGlobal(Offset.zero);
    double screenHeight = MediaQuery.of(context).size.height;
    double headerHeight = size.height;
    double requiredHeight = widget.seriesCount * 32.0;
    double availableBelow = screenHeight - offset.dy - headerHeight;
    double offsetY = availableBelow < requiredHeight ? -requiredHeight : headerHeight;

    return OverlayEntry(
      builder: (context) => GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          _toggleDropdown();
        },
        child: Stack(
          children: [
            Positioned(
              width: size.width,
              child: CompositedTransformFollower(
                link: _layerLink,
                offset: Offset(0, offsetY),
                showWhenUnlinked: false,
                child: Material(
                  elevation: 4,
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(widget.seriesCount, (index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          child: TextField(
                            controller: widget.controllers[index],
                            decoration: InputDecoration(
                              hintText: 'r${index + 1}',
                              filled: true,
                              fillColor: Colors.grey[200],
                              contentPadding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            keyboardType: TextInputType.number,
                            maxLength: 3,
                            style: TextStyle(fontSize: 12),
                            buildCounter: (BuildContext context,
                                    {required int currentLength,
                                    required bool isFocused,
                                    required int? maxLength}) =>
                                null,
                          ),
                        );
                      }),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _removeOverlay();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        onTap: _toggleDropdown,
        child: Container(
          height: 30,
          padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey[200]!),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("${widget.controllers.length}", style: TextStyle(fontSize: 12)),
              Icon(_expanded ? Icons.arrow_drop_up : Icons.arrow_drop_down, size: 16),
            ],
          ),
        ),
      ),
    );
  }
}

/// Clase para almacenar los detalles generales de la rutina de un día.
/// Cada RoutineDetail contiene una lista de grupos de ejercicio.
class RoutineDetail {
  List<ExerciseGroup> groups;
  RoutineDetail({List<ExerciseGroup>? groups})
      : groups = groups ?? [ExerciseGroup()];
  void dispose() {
    for (var group in groups) {
      group.dispose();
    }
  }
}

/// Clase para almacenar los detalles de un grupo de ejercicio.
class ExerciseGroup {
  TextEditingController muscleController;
  List<ExerciseDetail> rows;
  ExerciseGroup({String muscle = '', List<ExerciseDetail>? rows})
      : muscleController = TextEditingController(text: muscle),
        rows = rows ?? [ExerciseDetail()];
  void dispose() {
    muscleController.dispose();
    for (var row in rows) {
      row.dispose();
    }
  }
}

/// Clase para almacenar los detalles de cada fila de ejercicio.
class ExerciseDetail {
  TextEditingController exerciseController;
  int seriesCount;
  List<TextEditingController> repsControllers;
  ExerciseDetail({this.seriesCount = 1, String exercise = ''})
      : exerciseController = TextEditingController(text: exercise),
        repsControllers = [TextEditingController()];
  void dispose() {
    exerciseController.dispose();
    for (var controller in repsControllers) {
      controller.dispose();
    }
  }
}
