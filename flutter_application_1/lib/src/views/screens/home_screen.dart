import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/shared/themes/colors.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_bottom_navigation_bar.dart';
import '../widgets/custom_text_field.dart';
import '/src/routes/app_routes.dart';
import 'create_new_routine.dart';
import 'tu_Cuerpo_screen.dart';
import 'exercises.dart';
import 'mi_cuenta_screen.dart';

class HomeScreen extends StatefulWidget {
  final String userEmail;
  HomeScreen({required this.userEmail});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _inicialNombre = "U";
  int _currentIndex = 0;
  

  late List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    print("HomeScreen initState: userEmail = ${widget.userEmail}");
    _screens = [
      EntrenamientosTab(userEmail: widget.userEmail, inicialNombre: _inicialNombre),
      TuCuerpoScreen(userEmail: widget.userEmail),
      Exercises(userEmail: widget.userEmail, inicialNombre: _inicialNombre),
    ];
    _cargarInicialNombre();
  }

  Future<void> _cargarInicialNombre() async {
    try { 
      print("Buscando cliente con Email: ${widget.userEmail}"); 
      final snapshot = await FirebaseFirestore.instance
          .collection('clientes')
          .where('Email', isEqualTo: widget.userEmail)
          .get();

      print("Firestore query completada. Documentos encontrados: ${snapshot.docs.length}"); 

      if (snapshot.docs.isNotEmpty) {
        final data = snapshot.docs.first.data();
        print("Datos encontrados: $data"); 
        final nombre = data['Nombre'] ?? '';
        print("Nombre extraído: '$nombre'"); 
        if (mounted) {
          setState(() {
            _inicialNombre = nombre.isNotEmpty ? nombre[0].toUpperCase() : 'U';
            print("setState llamado. _inicialNombre ahora es: $_inicialNombre"); 
            _screens[0] = EntrenamientosTab(userEmail: widget.userEmail, inicialNombre: _inicialNombre);
            _screens[2] = Exercises(userEmail: widget.userEmail, inicialNombre: _inicialNombre);
          });
        }
      } else {
        print("No se encontró documento para el email."); 
        if (mounted) {
          setState(() {
            _inicialNombre = 'U';
            print("setState llamado (sin datos). _inicialNombre ahora es: $_inicialNombre"); 
            _screens[0] = EntrenamientosTab(userEmail: widget.userEmail, inicialNombre: _inicialNombre);
            _screens[2] = Exercises(userEmail: widget.userEmail, inicialNombre: _inicialNombre);
          });
        }
      }
    } catch (e) {
      print("Error en _cargarInicialNombre: $e"); 
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(30.0, 35.0, 30.0, 10.0),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: _screens[_currentIndex],
              ),
            ),
          ],
        ),
        bottomNavigationBar: CustomBottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}

class EntrenamientosTab extends StatefulWidget {
  final String userEmail;
  final String inicialNombre;
  EntrenamientosTab({required this.userEmail, required this.inicialNombre});

  @override
  State<EntrenamientosTab> createState() => _EntrenamientosTabState();
}

class _EntrenamientosTabState extends State<EntrenamientosTab> {
  String? _selectedDay;
  Map<String, dynamic>? _datosOriginales;
  String? _rutinaIdOriginal;

  void _confirmarEliminacion(BuildContext context, DocumentSnapshot doc) async {
    final data = doc.data() as Map<String, dynamic>;
    final creadaPorGym = data['CreadaPorGym'] == true;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('¿Eliminar rutina?'),
        content: Text(creadaPorGym
            ? '¿Deseas quitar esta rutina asignada?'
            : '¿Deseas eliminar esta rutina definitivamente?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancelar'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              final docRef = FirebaseFirestore.instance.collection('rutinas').doc(doc.id);
              if (creadaPorGym) {
                await docRef.update({
                  'asignados': FieldValue.arrayRemove([widget.userEmail])
                });
              } else {
                await docRef.delete();
              }
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Rutina eliminada correctamente')),
              );
            },
            child: Text('Eliminar', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _mostrarDetalleRutina(BuildContext context, Map<String, dynamic> data, String rutinaId) {
    _datosOriginales = Map<String, dynamic>.from(data);
    _rutinaIdOriginal = rutinaId;

    final List dias = data['dias'] ?? [];
    final Map<String, dynamic> ejerciciosRaw = Map<String, dynamic>.from(data['ejercicios'] ?? {});
    bool editando = false;
    _selectedDay = dias.isNotEmpty ? dias.first : null;

    // Función para normalizar claves numéricas ("1", "2", ...) a nombres de días
    Map<String, dynamic> normalizarEjercicios(Map ejerciciosOriginales, List dias) {
      final Map<String, dynamic> ejerciciosNormalizados = {};
      for (int i = 0; i < dias.length; i++) {
        final dia = dias[i];
        final clave = ejerciciosOriginales.containsKey(dia)
            ? dia
            : ejerciciosOriginales.containsKey('${i + 1}')
                ? '${i + 1}'
                : i + 1;

        ejerciciosNormalizados[dia] = List.from(ejerciciosOriginales[clave] ?? []);
      }
      return ejerciciosNormalizados;
    }

    final Map<String, dynamic> ejerciciosOriginales = normalizarEjercicios(ejerciciosRaw, dias);
    showDialog(
      context: context,
      builder: (_) => StatefulBuilder(
        builder: (context, setModalState) {
          Map<String, dynamic> ejercicios = Map<String, dynamic>.from(ejerciciosOriginales);
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              elevation: 0,
              backgroundColor: Colors.white,
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: IconButton(
                    icon: Icon(Icons.close, size: 18, color: Colors.red),
                    onPressed: () => Navigator.pop(context),
                  ),
                )
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Text(data['nombre'] ?? '',
                        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: AppColors.primary)),
                  ),
                  if (data['objetivo'] != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Center(
                        child: Text(data['objetivo'], style: TextStyle(fontSize: 16, color: Colors.grey[800])),
                      ),
                    ),
                  SizedBox(height: 16),
                  Center(
                    child: Wrap(
                      spacing: 8,
                      children: dias.map<Widget>((d) {
                        final label = d.toString().substring(0, 1).toUpperCase();
                        final isSelected = _selectedDay == d;
                        return GestureDetector(
                          onTap: () => setModalState(() => _selectedDay = d),
                          child: Container(
                            width: 45,
                            height: 45,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: isSelected ? AppColors.mainBlue : Colors.grey[300],
                              borderRadius: BorderRadius.circular(22.5),
                            ),
                            child: Text(
                              label,
                              style: TextStyle(
                                color: isSelected ? AppColors.secondary : AppColors.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(height: 16),
                  Expanded(
                    child: ListView(
                      children: (ejercicios[_selectedDay] as List?)?.map<Widget>((grupo) {
                        final musculo = grupo['musculo'];
                        final ejerciciosList = grupo['ejercicios'] as List;
                        return Container(
                          margin: EdgeInsets.only(bottom: 10),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    flex: 6,
                                    child: TextField(
                                      controller: TextEditingController(text: musculo),
                                      readOnly: !editando,
                                      onChanged: (val) => grupo['musculo'] = val,
                                      decoration: InputDecoration(
                                        hintText: 'Músculo',
                                        filled: true,
                                        fillColor: Colors.grey[200],
                                        hintStyle: TextStyle(fontSize: 15, color: Colors.grey[600]),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(20),
                                          borderSide: BorderSide.none,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  Transform.translate(
                                    offset: Offset(-15, 0),
                                    child: Text('Series', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                                  ),
                                  SizedBox(width: 16),
                                  Transform.translate(
                                    offset: Offset(-12, 0),
                                    child: Text('Repe', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                                  ),
                                ],
                              ),
                              SizedBox(height: 6),
                              ...ejerciciosList.map<Widget>((e) {
                                final reps = e['repeticiones'] as List;
                                return Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 6.0),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: TextField(
                                          controller: TextEditingController(text: e['nombre']),
                                          readOnly: !editando,
                                          onChanged: (val) => e['nombre'] = val,
                                          decoration: InputDecoration(
                                            hintText: 'Ejercicio',
                                            filled: true,
                                            fillColor: Colors.grey[200],
                                            hintStyle: TextStyle(fontSize: 15, color: Colors.grey[600]),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(20),
                                              borderSide: BorderSide.none,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 8),
                                      Container(
                                        width: 50,
                                        child: DropdownButtonFormField<int>(
                                          value: e['series'],
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor: Colors.white,
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(12),
                                              borderSide: BorderSide(color: Colors.grey[200]!, width: 0.01),
                                            ),
                                            contentPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                                            isDense: true,
                                          ),
                                          dropdownColor: Colors.white,
                                          style: TextStyle(fontSize: 12, color: Colors.black),
                                          items: List.generate(10, (i) => DropdownMenuItem(
                                            value: i + 1,
                                            child: Text('${i + 1}', 
                                              style: TextStyle(fontSize: 12, color: Colors.black),
                                            ),
                                          )),
                                          onChanged: editando ? (val) => e['series'] = val ?? 1 : null,
                                        ),
                                      ),
                                      SizedBox(width: 8),
                                      Container(
                                        width: 50,
                                        child: RepeticionesDropdown(
                                          seriesCount: e['series'],
                                          controllers: List.generate(
                                            e['series'],
                                            (index) => TextEditingController(
                                              text: reps[index].toString(),
                                            ),
                                          ),
                                          readOnly: !editando,
                                          onRepsChanged: (newReps) {
                                            if (editando) {
                                              setModalState(() {
                                                e['repeticiones'] = newReps;
                                              });
                                            }
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                              if (editando)
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      iconSize: 35,
                                      icon: Icon(Icons.remove_circle, color: Colors.red),
                                      onPressed: () {
                                        setModalState(() {
                                          if (ejerciciosList.length > 1) {
                                            ejerciciosList.removeLast();
                                          } else if (ejercicios[_selectedDay]!.length > 1) {
                                            ejercicios[_selectedDay]!.removeAt(ejercicios[_selectedDay]!.indexOf(grupo));
                                          }
                                        });
                                      },
                                    ),
                                    IconButton(
                                      iconSize: 35,
                                      icon: Icon(Icons.add_circle, color: AppColors.mainBlue),
                                      onPressed: () {
                                        setModalState(() {
                                          ejerciciosList.add({
                                            'nombre': '',
                                            'series': 1,
                                            'repeticiones': ['']
                                          });
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              if (editando && ejercicios[_selectedDay]?.last == grupo)
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: CustomButton(
                                    text: '+ Añadir grupo muscular',
                                    onPressed: () {
                                      setModalState(() {
                                        if (!ejercicios.containsKey(_selectedDay)) ejercicios[_selectedDay!] = [];
                                        ejercicios[_selectedDay!]!.add({
                                          'musculo': '',
                                          'ejercicios': [
                                            {
                                              'nombre': '',
                                              'series': 1,
                                              'repeticiones': ['']
                                            }
                                          ]
                                        });
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
                                ),
                            ],
                          ),
                        );
                      }).toList() ?? [],
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomButton(
                        text: editando ? 'Cancelar' : 'Editar rutina',
                        onPressed: () {
                          if (editando) {
                            Navigator.pop(context);
                            if (_datosOriginales != null && _rutinaIdOriginal != null) {
                              _mostrarDetalleRutina(context, _datosOriginales!, _rutinaIdOriginal!);
                            }
                          } else {
                            setModalState(() {
                              editando = true;
                            });
                          }
                        },
                        backgroundColor: editando ? Colors.grey : AppColors.mainBlue,
                        textColor: AppColors.secondary,
                        width: 150,
                        height: 40,
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      if (editando) SizedBox(width: 12),
                      if (editando)
                        CustomButton(
                          text: 'Guardar',
                          onPressed: () async {
                            try {
                              final creadaPorGym = _datosOriginales?['CreadaPorGym'] == true;

                              final rutinaData = {
                                'nombre': _datosOriginales?['nombre'],
                                'dias': _datosOriginales?['dias'],
                                'objetivo': _datosOriginales?['objetivo'],
                                'ejercicios': ejercicios,
                                'CreadaPorGym': false,
                                'asignados': [widget.userEmail],
                                'gymPassword': 'creadaPorApp',
                              };

                              if (creadaPorGym) {
                                await FirebaseFirestore.instance.collection('rutinas').add(rutinaData);
                                await FirebaseFirestore.instance.collection('rutinas').doc(_rutinaIdOriginal).update({
                                  'asignados': FieldValue.arrayRemove([widget.userEmail])
                                });
                              } else {
                                await FirebaseFirestore.instance.collection('rutinas').doc(_rutinaIdOriginal).update({
                                  'ejercicios': ejercicios
                                });
                              }

                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Cambios guardados exitosamente')),
                              );
                            } catch (e) {
                              print('Error al guardar rutina: $e');
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Error al guardar la rutina: ${e.toString()}'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          },
                          backgroundColor: AppColors.mainBlue,
                          textColor: AppColors.secondary,
                          width: 150,
                          height: 40,
                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print("EntrenamientosTab build: inicialNombre recibida = ${widget.inicialNombre}");
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Entrenamientos',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: AppColors.mainBlue,
                ),
              ),
              PopupMenuButton<String>(
                onSelected: (value) {
                  if (value == "Mi cuenta") {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MiCuentaScreen(userEmail: widget.userEmail),
                      ),
                    );
                  } else if (value == "Cerrar sesión") {
                    Navigator.pushReplacementNamed(context, AppRoutes.login);
                  }
                },
                itemBuilder: (context) => [
                  PopupMenuItem(value: "Mi cuenta", child: Text("Mi cuenta")),
                  PopupMenuItem(value: "Cerrar sesión", child: Text("Cerrar sesión")),
                ],
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: AppColors.mainBlue,
                  child: Text(
                    widget.inicialNombre,
                    style: TextStyle(
                      color: AppColors.secondary,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            'Mi Plan',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: AppColors.primary,
            ),
          ),
          SizedBox(height: 20),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('rutinas')
                .where('asignados', arrayContains: widget.userEmail)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Text('Aún no tienes rutinas creadas o asignadas.',
                      style: TextStyle(color: Colors.grey)),
                );
              }

              return Column(
                children: snapshot.data!.docs.map((doc) {
                  final data = doc.data() as Map<String, dynamic>;
                  final nombre = data['nombre'] ?? 'Sin nombre';
                  final objetivo = data['objetivo'] ?? 'Sin objetivo';

                  return GestureDetector(
                    onTap: () => _mostrarDetalleRutina(context, data, doc.id),
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16),
                      margin: EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Stack(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(nombre,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primary)),
                              SizedBox(height: 4),
                              Text(
                                objetivo,
                                style:
                                    TextStyle(fontSize: 14, color: Colors.grey[700]),
                              )
                            ],
                          ),
                          Positioned(
                            top: 4,
                            right: 4,
                            child: GestureDetector(
                              onTap: () => _confirmarEliminacion(context, doc),
                              child: Container(
                                padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.red.withOpacity(0.1),
                                ),
                                child: Icon(Icons.close, size: 16, color: Colors.red),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              );
            },
          ),
          SizedBox(height: 20),
          CustomButton(
            text: '+ Crear nueva rutina',
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) => Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  child: CreateNewRoutine(userEmail: widget.userEmail),
                ),
              );
            },
            backgroundColor: AppColors.mainBlue,
            textColor: AppColors.secondary,
            fontSize: 17,
            padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            elevation: 4,
            width: double.infinity,
            height: 55,
          ),
        ],
      ),
    );
  }
}

class RepeticionesDropdown extends StatefulWidget {
  final int seriesCount;
  final List<TextEditingController> controllers;
  final bool readOnly;
  final Function(List<String>)? onRepsChanged;

  RepeticionesDropdown({
    required this.seriesCount,
    required this.controllers,
    this.readOnly = false,
    this.onRepsChanged,
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
                            readOnly: widget.readOnly,
                            onChanged: (value) {
                              if (widget.onRepsChanged != null) {
                                widget.onRepsChanged!(widget.controllers.map((c) => c.text.trim()).toList());
                              }
                            },
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
    if (widget.onRepsChanged != null) {
      widget.onRepsChanged!(widget.controllers.map((c) => c.text.trim()).toList());
    }
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