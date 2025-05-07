import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/shared/themes/colors.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
import '/src/routes/app_routes.dart';
import '../widgets/email_service.dart';

class RecoverPasswordScreen extends StatefulWidget {
  @override
  State<RecoverPasswordScreen> createState() => _RecoverPasswordScreenState();
}

class _RecoverPasswordScreenState extends State<RecoverPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  bool _isLoading = false;

  Future<void> _recoverPassword() async {
    final email = _emailController.text.trim();

    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor introduce tu correo electrónico.')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Actualizamos para usar Email en vez de email
      final query = await FirebaseFirestore.instance
          .collection('clientes')
          .where('Email', isEqualTo: email)
          .get();

      if (query.docs.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Correo no encontrado.')),
        );
      } else {
        final exito = await EmailService.restablecerContrasena(email);

        if (exito) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Te hemos enviado una nueva contraseña temporal a tu correo.')),
          );
          Navigator.of(context).pushNamed(AppRoutes.login);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error al restablecer la contraseña.')),
          );
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al recuperar contraseña: $e')),
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
      resizeToAvoidBottomInset: true, 
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30.0, 24.0, 30.0, 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 23.5),
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(AppRoutes.login, arguments: 'back');
                  },
                  icon: Image.asset(
                    'assets/images/Acciones/Icono_Atras.png',
                    width: 30,
                    height: 30,
                  ),
                ),
              ),
              SizedBox(height: 250),
              Padding(
                padding: const EdgeInsets.only(right: 6),
                child: Text(
                  'Restablecer Contraseña',
                  style: TextStyle(
                    fontSize: 32,
                    color: AppColors.mainBlue,
                  ),
                ),
              ),
              SizedBox(height: 30),
              Text(
                'Introduce tu correo y te enviaremos instrucciones para restablecer tu contraseña.',
                style: TextStyle(
                  fontSize: 18,
                  color: AppColors.primary,
                ),
              ),
              SizedBox(height: 30),
              CustomTextField(
                controller: _emailController,
                hintText: 'Correo Electrónico',
                width: 355,
                height: 55,
                hintStyle: TextStyle(
                  fontSize: 17,
                  color: Color.fromARGB(255, 108, 97, 97),
                ),
                fillColor: Color.fromARGB(128, 186, 178, 178),
                contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 25.0),
              ),
              SizedBox(height: 200),
              _isLoading
                  ? CircularProgressIndicator()
                  : CustomButton(
                      text: 'Enviar',
                      onPressed: _recoverPassword,
                      backgroundColor: AppColors.mainBlue,
                      textColor: AppColors.secondary,
                      fontSize: 17,
                      padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
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
