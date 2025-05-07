import 'package:flutter/material.dart';
import 'package:flutter_application_1/shared/themes/colors.dart';
import '../widgets/custom_button.dart';
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

  Future<void> _registrarUsuario() async {
    final telefono = _telefonoController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (telefono.isEmpty || email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor completa todos los campos.')),
      );
      return;
    }

    if (password != _repeatPasswordController.text.trim()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Las contraseñas no coinciden.')),
      );
      return;
    }

    try {
      final usuarioFinal = {
        "Nombre": widget.usuario.Nombre,
        "Apellido1": widget.usuario.Apellido1,
        "Apellido2": widget.usuario.Apellido2,
        "Genero": widget.usuario.Genero,
        "FechaNacimiento": widget.usuario.FechaNacimiento,
        "Peso": widget.usuario.Peso,
        "Altura": widget.usuario.Altura,
        "Objetivo": widget.usuario.Objetivo,
        "PesoIdeal": widget.usuario.PesoIdeal,
        "Telefono": telefono,
        "Email": email,
        "Contraseña": password,
        "APagar": null,
        "PlanSuscripcion": "Mensual",
      };

      await FirebaseFirestore.instance.collection('clientes').add(usuarioFinal);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Usuario registrado exitosamente.')),
      );

      Navigator.pushNamed(context, AppRoutes.idSportsCenters, arguments: email);

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error inesperado: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30.0, 24.0, 30.0, 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(AppRoutes.priorSignUp, arguments: 'back');
                  },
                  icon: Image.asset(
                    'assets/images/Acciones/Icono_Atras.png',
                    width: 30,
                    height: 30,
                  ),
                ),
              ),
            Expanded(
              child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Image.asset(
                          'assets/images/Logos/Nombre_Lema_Azul.png',
                          width: size.width * 0.5,
                          height: size.height * 0.1,
                        ),
                      ),
                      SizedBox(height: size.height * 0.03),
                      Padding(
                        padding: EdgeInsets.only(right: size.width * 0.2),
                        child: Text(
                          'Completemos la información:',
                          style: TextStyle(fontSize: 18, color: AppColors.primary),
                        ),
                      ),
                      SizedBox(height: 15),
                      Padding(
                        padding: EdgeInsets.only(right: size.width * 0.48),
                        child: Text('Número móvil:', style: TextStyle(fontSize: 18, color: AppColors.primary)),
                      ),
                      CustomTextField(
                        controller: _telefonoController,
                        hintText: 'Número',
                        width: 355,
                        height: 55,
                        hintStyle: TextStyle(fontSize: 17, color: Color.fromARGB(255, 108, 97, 97)),
                        fillColor: Color.fromARGB(128, 186, 178, 178),
                        contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 25.0),
                      ),
                      SizedBox(height: 15),
                      Padding(
                        padding: EdgeInsets.only(right: size.width * 0.4),
                        child: Text('Correo electrónico:', style: TextStyle(fontSize: 18, color: AppColors.primary)),
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
                        padding: EdgeInsets.only(right: size.width * 0.5),
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
                        padding: EdgeInsets.only(right: size.width * 0.3),
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
                        onPressed: _registrarUsuario,
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
            ],
          ),
        ),
      ),
    );
  }
}
