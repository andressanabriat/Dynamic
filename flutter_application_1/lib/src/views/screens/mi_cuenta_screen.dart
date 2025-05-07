import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/shared/themes/colors.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_dropdown_button.dart';
import '../widgets/custom_password_field.dart';

class MiCuentaScreen extends StatefulWidget {
  final String userEmail;
  const MiCuentaScreen({Key? key, required this.userEmail}) : super(key: key);

  @override
  State<MiCuentaScreen> createState() => _MiCuentaScreenState();
}

class _MiCuentaScreenState extends State<MiCuentaScreen> {
  bool _editando = false;
  bool _mostrarContrasena = false;
  final _nombreController = TextEditingController();
  final _apellido1Controller = TextEditingController();
  final _apellido2Controller = TextEditingController();
  String? _genero;
  final _fechaNacimientoController = TextEditingController();
  final _movilController = TextEditingController();
  final _emailController = TextEditingController();
  final _contrasenaController = TextEditingController();
  final _repetirContrasenaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _cargarDatos();
  }

  Future<void> _cargarDatos() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('clientes')
        .where('Email', isEqualTo: widget.userEmail)
        .get();

    if (snapshot.docs.isNotEmpty) {
      final data = snapshot.docs.first.data();
      _nombreController.text = data['Nombre'] ?? '';
      _apellido1Controller.text = data['Apellido1'] ?? '';
      _apellido2Controller.text = data['Apellido2'] ?? '';
      final generoBD = data['Genero'];
      if (generoBD == 'Masculino') _genero = 'Masculino';
      else if (generoBD == 'Femenino') _genero = 'Femenino';
      else if (generoBD == 'Otro') _genero = 'Otro';
      else _genero = null;
      _fechaNacimientoController.text = data['FechaNacimiento'] ?? '';
      _movilController.text = data['Telefono'] ?? '';
      _emailController.text = data['Email'] ?? '';
      _contrasenaController.text = data['Contraseña'] ?? '';
      setState(() {});
    }
  }

  Widget _campo(String label, Widget child) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
        SizedBox(height: 6),
        child,
        SizedBox(height: 12),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30.0, 35.0, 30.0, 24.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Cuenta',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: AppColors.mainBlue,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close, color: Colors.red),
                    onPressed: () => Navigator.pop(context),
                  )
                ],
              ),
              SizedBox(height: 20),
              _campo('Nombre', CustomTextField(
                hintText: 'Nombre',
                controller: _nombreController,
                readOnly: !_editando,
              )),
              _campo('Primer apellido', CustomTextField(
                hintText: 'Primer apellido',
                controller: _apellido1Controller,
                readOnly: !_editando,
              )),
              _campo('Segundo apellido', CustomTextField(
                hintText: 'Segundo apellido',
                controller: _apellido2Controller,
                readOnly: !_editando,
              )),
              _campo('Género', !_editando
                  ? CustomTextField(
                      hintText: '',
                      controller: TextEditingController(text: _genero ?? ''),
                      readOnly: true,
                    )
                  : CustomDropdownButton(
                      hintText: 'Seleccione su género',
                      items: ['Masculino', 'Femenino', 'Otro'],
                      value: _genero,
                      onChanged: (val) => setState(() => _genero = val),
                      width: double.infinity,
                      height: 55,
                      backgroundColor: const Color.fromARGB(255, 209, 206, 206),
                      textColor: const Color.fromARGB(255, 65, 65, 65),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    )),
              _campo('Fecha de nacimiento', CustomTextField(
                hintText: 'Fecha de nacimiento',
                controller: _fechaNacimientoController,
                readOnly: true,
              )),
              _campo('Número móvil', CustomTextField(
                hintText: 'Número móvil',
                controller: _movilController,
                readOnly: !_editando,
              )),
              _campo('Correo electrónico', CustomTextField(
                hintText: 'Correo electrónico',
                controller: _emailController,
                readOnly: true,
              )),
              _campo('Contraseña', CustomPasswordField(
                hintText: 'Contraseña',
                controller: _contrasenaController,
              )),
              if (_editando)
                _campo('Repita la contraseña', CustomPasswordField(
                  hintText: 'Repita la contraseña',
                  controller: _repetirContrasenaController,
                )),
              SizedBox(height: 10),
              if (!_editando)
                CustomButton(
                  text: 'Actualizar información',
                  onPressed: () => setState(() => _editando = true),
                  backgroundColor: AppColors.mainBlue,
                  textColor: AppColors.secondary,
                  width: double.infinity,
                  height: 50,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                )
              else
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomButton(
                      text: 'Cancelar',
                      onPressed: () => setState(() => _editando = false),
                      backgroundColor: Colors.grey,
                      textColor: Colors.white,
                      width: 150,
                      height: 45,
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    CustomButton(
                      text: 'Guardar',
                      onPressed: () async {
                        if (_contrasenaController.text.trim() != _repetirContrasenaController.text.trim()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Las contraseñas no coinciden')),
                          );
                          return;
                        }
                        final snapshot = await FirebaseFirestore.instance
                            .collection('clientes')
                            .where('Email', isEqualTo: widget.userEmail)
                            .get();
                        if (snapshot.docs.isNotEmpty) {
                          final docId = snapshot.docs.first.id;
                          String? generoDB;
                          if (_genero == 'Masculino') generoDB = 'Masculino';
                          else if (_genero == 'Femenino') generoDB = 'Femenino';
                          else if (_genero == 'Otro') generoDB = 'Otro';

                          await FirebaseFirestore.instance.collection('clientes').doc(docId).update({
                            'Nombre': _nombreController.text.trim(),
                            'Apellido1': _apellido1Controller.text.trim(),
                            'Apellido2': _apellido2Controller.text.trim(),
                            'Genero': generoDB,
                            'Telefono': _movilController.text.trim(),
                            'Contraseña': _contrasenaController.text.trim(),
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Información actualizada correctamente')),
                          );
                          setState(() => _editando = false);
                        }
                      },
                      backgroundColor: AppColors.mainBlue,
                      textColor: AppColors.secondary,
                      width: 150,
                      height: 45,
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                  ],
                )
            ],
          ),
        ),
      ),
    );
  }
}
