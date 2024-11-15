import 'package:flutter/material.dart';
import 'package:flutter_application_1/shared/themes/colors.dart';
import '../../providers/usuario_provider.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
import 'package:provider/provider.dart';
import '/src/routes/app_routes.dart';

class PriorSignUpScreen extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {

    return Scaffold(      
      body: SingleChildScrollView( // scroll
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30.0, 24.0, 30.0, 24.0), // Espacio de widget parte izquierda, superior, derecha e inferior
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start, // Centra los elementos verticalmente
            children: [
              Align( // Boton Atras
                alignment: Alignment.centerLeft, // Alinea completamente a la izquierda
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(AppRoutes.login, arguments: 'back'); 
                  }, 
                  icon: Image.asset(
                    'assets/images/Acciones/Icono_Atras.png',
                    width: 30, // Tamaño de la imagen
                    height: 30,
                  ),
                ),
              ),

              SizedBox(height: 250), // Espacio ente botón atras y Restablecer contraseña
              
              Padding(
                padding: const EdgeInsets.only(right: 63), // Espacio desde el borde izquierdo
                child: Text(
                  '¿Comenzamos?',
                  style: TextStyle(
                    fontSize: 40,
                    color: AppColors.mainBlue,
                  ),
                ),
              ),
      
              SizedBox(height: 30), // Restablecer contraseña y texto

              Text(
                'Primero, necesito saber un poco sobre ti. Esta información ayudará a crear una experiencia personalizada para cumplir tus objetivos.',
                style: TextStyle(
                  fontSize: 18,
                  color: AppColors.primary,
                ),
              ),

              SizedBox(height: 298), // Espacio entre texto y Correo electronico

              CustomButton( // Botón de enviar
                text: 'Comenzar',
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.signUp); // Navegación 
                },
                backgroundColor: AppColors.mainBlue, // Color del botón
                textColor: AppColors.secondary, // Color de texto
                fontSize: 17, // Tamaño de fuente
                padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                elevation: 4,
                width: 355, // Ancho del botón
                height: 55, // Altura del botón
              ),
            ],
          ),
        ),
      ),
    );
  }
}