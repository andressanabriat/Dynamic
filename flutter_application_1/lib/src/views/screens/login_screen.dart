import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/shared/themes/colors.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
import '/src/routes/app_routes.dart';
import '../widgets/custom_Password_Field.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false; // Para controlar el spinner

  Future<void> _iniciarSesion() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    setState(() {
      _isLoading = true;
    });

    try {
      final query = await FirebaseFirestore.instance
          .collection('clientes')
          .where('Email', isEqualTo: email)
          .where('Contraseña', isEqualTo: password)
          .get();

      if (query.docs.isNotEmpty) {
        final userDoc = query.docs.first;
        final udGimnasio = userDoc['UdGimnasio'];

        if (udGimnasio != null && udGimnasio != "false") {
          Navigator.pushNamed(context, AppRoutes.home);
        } else {
          Navigator.pushNamed(context, AppRoutes.idSportsCenters);
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Credenciales incorrectas')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al iniciar sesión: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30.0, 24.0, 30.0, 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(AppRoutes.userFilter, arguments: 'backFilter');
                },
                icon: Image.asset(
                  'assets/images/Acciones/Icono_Atras.png',
                  width: 30,
                  height: 30,
                ),
              ),
            ),
            SizedBox(height: 100),
            Align(
              alignment: Alignment.center,
              child: Image.asset(
                'assets/images/Logos/Logo_Dynamic_Nombre_Lema.png',
                width: 190,
                height: 190,
              ),
            ),
            SizedBox(height: 70),
            Padding(
              padding: const EdgeInsets.only(right: 176),
              child: Text(
                'Inicio de Sesión',
                style: TextStyle(fontSize: 18, color: AppColors.primary),
              ),
            ),
            SizedBox(height: 15),
            CustomTextField(
              controller: _emailController,
              hintText: 'Correo Electrónico',
              width: 355,
              height: 55,
              hintStyle: TextStyle(fontSize: 17, color: Color.fromARGB(255, 108, 97, 97)),
              fillColor: Color.fromARGB(128, 186, 178, 178),
              contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 25.0),
            ),
            SizedBox(height: 15),
            CustomPasswordField(
              controller: _passwordController,
              hintText: 'Contraseña',
              width: 355,
              height: 55,
              fontSize: 17,
            ),
            SizedBox(height: 18),
            _isLoading
                ? CircularProgressIndicator()
                : CustomButton(
                    text: 'Siguiente',
                    onPressed: _iniciarSesion,
                    backgroundColor: AppColors.mainBlue,
                    textColor: AppColors.secondary,
                    fontSize: 17,
                    padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                    elevation: 4,
                    width: 355,
                    height: 55,
                  ),
            SizedBox(height: 50),
            Align(
              alignment: Alignment.center,
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(AppRoutes.recoverPassword);
                },
                child: Text(
                  '¿Has olvidado tu contraseña?',
                  style: TextStyle(fontSize: 18, color: AppColors.mainBlue),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '¿No tienes una cuenta? ',
                    style: TextStyle(fontSize: 17, color: AppColors.primary),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(AppRoutes.priorSignUp);
                    },
                    child: Text(
                      'Regístrate',
                      style: TextStyle(fontSize: 18, color: AppColors.mainBlue),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
