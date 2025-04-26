import 'package:flutter/material.dart';
import 'package:flutter_application_1/shared/themes/colors.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_dropdown_button.dart';
import '../widgets/custom_date_picker_button.dart';
import '../widgets/scroll_Weight_Picker.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_Password_Field.dart';
import '/src/routes/app_routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'sign_up_screen.dart';

class SignUpScreen2 extends StatefulWidget {
  final Usuario usuario;

  const SignUpScreen2({Key? key, required this.usuario}) : super(key: key);

  @override
  State<SignUpScreen2> createState() => _SignUpScreen2State();
}

class _SignUpScreen2State extends State<SignUpScreen2> {
  final TextEditingController _telefonoController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repeatPasswordController = TextEditingController();

  Future<void> _registrarUsuarioEnFirebase(Map<String, dynamic> datosUsuario) async {
    try {
      await FirebaseFirestore.instance.collection('clientes').add(datosUsuario); // <-- Cambiado aquí
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Usuario registrado exitosamente.')),
      );
      Navigator.pushNamed(context, AppRoutes.idSportsCenters);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al registrar usuario: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30.0, 24.0, 30.0, 24.0),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(AppRoutes.signUp, arguments: 'back');
                  },
                  icon: Image.asset(
                    'assets/images/Acciones/Icono_Atras.png',
                    width: 30,
                    height: 30,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Image.asset(
                  'assets/images/Logos/Nombre_Lema_Azul.png',
                  width: 190,
                  height: 110,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 108),
                child: Text(
                  'Completemos la informacion:',
                  style: TextStyle(fontSize: 18, color: AppColors.primary),
                ),
              ),
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.only(right: 177),
                child: Text('Numero movil:', style: TextStyle(fontSize: 18, color: AppColors.primary)),
              ),
              CustomTextField(
                controller: _telefonoController,
                hintText: 'Numero',
                width: 355,
                height: 55,
                hintStyle: TextStyle(fontSize: 17, color: Color.fromARGB(255, 108, 97, 97)),
                fillColor: Color.fromARGB(128, 186, 178, 178),
                contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 25.0),
              ),
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.only(right: 145),
                child: Text('Correo electronico:', style: TextStyle(fontSize: 18, color: AppColors.primary)),
              ),
              CustomTextField(
                controller: _emailController,
                hintText: 'Correo',
                width: 355,
                height: 55,
                hintStyle: TextStyle(fontSize: 17, color: Color.fromARGB(255, 108, 97, 97)),
                fillColor: Color.fromARGB(128, 186, 178, 178),
                contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 25.0),
              ),
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.only(right: 205),
                child: Text('Contraseña:', style: TextStyle(fontSize: 18, color: AppColors.primary)),
              ),
              CustomPasswordField(
                controller: _passwordController,
                hintText: 'Contraseña',
                width: 355,
                height: 55,
                fontSize: 17,
              ),
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.only(right: 130),
                child: Text('Repita la contraseña:', style: TextStyle(fontSize: 18, color: AppColors.primary)),
              ),
              CustomPasswordField(
                controller: _repeatPasswordController,
                hintText: 'Contraseña',
                width: 355,
                height: 55,
                fontSize: 17,
              ),
              SizedBox(height: 18),
              CustomButton(
                text: 'Siguiente',
                onPressed: () {
                  if (_passwordController.text != _repeatPasswordController.text) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Las contraseñas no coinciden.')),
                    );
                    return;
                  }

                  final usuarioFinal = {
                    "nombre": widget.usuario.nombre,
                    "apellido1": widget.usuario.apellido1,
                    "apellido2": widget.usuario.apellido2,
                    "genero": widget.usuario.genero,
                    "fechaNacimiento": widget.usuario.fechaNacimiento,
                    "peso": widget.usuario.peso,
                    "altura": widget.usuario.altura,
                    "objetivo": widget.usuario.objetivo,
                    "telefono": _telefonoController.text,
                    "email": _emailController.text,
                    "contrasena": _passwordController.text,
                  };

                  _registrarUsuarioEnFirebase(usuarioFinal);
                },
                backgroundColor: AppColors.mainBlue,
                textColor: AppColors.secondary,
                fontSize: 17,
                padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                elevation: 4,
                width: 355,
                height: 55,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
