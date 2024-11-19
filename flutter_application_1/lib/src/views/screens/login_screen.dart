import 'package:flutter/material.dart';
import 'package:flutter_application_1/shared/themes/colors.dart';
import '../../providers/usuario_provider.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
import 'package:provider/provider.dart';
import '/src/routes/app_routes.dart';

class LoginScreen extends StatelessWidget {
  
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
                    Navigator.of(context).pushNamed(AppRoutes.userFilter, arguments: 'backFilter'); 
                  }, 
                  icon: Image.asset(
                    'assets/images/Acciones/Icono_Atras.png',
                    width: 30, // Tamaño de la imagen
                    height: 30,
                  ),
                ),
              ),

              SizedBox(height: 100), // Espacio ente Inicio de sesión y Correo electronico

              Align( // Logo de Dynamic
                alignment: Alignment.center, // Centra la imagen
                child: Image.asset(
                  'assets/images/Logos/Logo_Dynamic.png', 
                  width: 100, 
                  height: 100, 
                ),
              ),

              Align( // Titulo Dynamic
                alignment: Alignment.center, // Centra el texto
                child: Text(
                  'Dynamic',
                  style: TextStyle(
                    fontSize: 40, // Tamaño del texto
                    color: AppColors.primary,  // Color de texto 
                  ),
                ),
              ),

              Align(  // Lema
                alignment: Alignment.center, // Centra el texto
                child: Text(
                  'Health, Sport & Motivation',
                  style: TextStyle(
                    fontSize: 12, // Tamaño del texto
                    color: AppColors.primary, // Color de texto 
                  ),
                ),
              ),

              SizedBox(height: 50), // Espacio entre lema y inicio de sesión 
              
              Padding(
                padding: const EdgeInsets.only(right: 176), // Espacio desde el borde izquierdo
                child: Text(
                  'Inicio de Sesión',
                  style: TextStyle(
                    fontSize: 18,
                    color: AppColors.primary,
                  ),
                ),
              ),

              SizedBox(height: 15), // Espacio ente Inicio de sesión y Correo electronico

              CustomTextField( // Campo de correo electronico
                hintText: 'Correo Electrónico',
                width: 355,  // Ancho del campo
                height: 55,  // Alto del campo
                hintStyle: TextStyle(
                  fontSize: 17, // Tamaño del texto
                  color: Color.fromARGB(255, 108, 97, 97), // Pendiente de cambiar
                ),
                fillColor: Color.fromARGB(128, 186, 178, 178),  // Pendiente de cambiar
                contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 25.0),  // Espaciado interno
              ),

              SizedBox(height: 15), // Espacio entre correo electronico y contraseña
              
              CustomTextField( // Campo de contraseña
                hintText: 'Contraseña',
                width: 355,  // Ancho del campo
                height: 55,  // Alto del campo
                hintStyle: TextStyle(
                  fontSize: 17, // Tamaño del texto
                  color: Color.fromARGB(255, 108, 97, 97), // Pendiente de cambiar
                ),
                fillColor: Color.fromARGB(128, 186, 178, 178),  // Pendiente de cambiar
                contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 25.0),  // Espaciado interno
              ),

              SizedBox(height: 18), // Espacio entre contraseña y boton siguiente

              CustomButton( // Botón de Siguiente
                text: 'Siguiente',
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.home); // Navegación 
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

              SizedBox(height: 60), // Espacio botón siguiente y recuperar contraseña

              Align( // Boton recuperar contraseña
                alignment: Alignment.center, // Centra el texto
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(AppRoutes.recoverPassword); 
                  }, 
                  child: Text(
                    '¿Has olvidado tu contraseña?',
                    style: TextStyle(
                      fontSize: 18, // Tamaño de texto
                      color: AppColors.mainBlue, // Color de texto 
                    ),
                  ),
                ),
              ),

              Align(
                alignment: Alignment.center, // Centra el contenido
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center, // Alinea el texto y el botón al centro
                  children: [
                    Text(
                      '¿No tienes una cuenta? ',
                      style: TextStyle(
                        fontSize: 17, // Tamaño de texto
                        color: AppColors.primary, // Color del texto
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(AppRoutes.priorSignUp); 
                      },
                      child: Text(
                        'Regístrate',
                        style: TextStyle(
                          fontSize: 18, // Tamaño de texto
                          color: AppColors.mainBlue, // Color del texto azul
                          //fontWeight: FontWeight.bold, // Negrita para destacar
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}