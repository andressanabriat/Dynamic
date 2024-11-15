import 'package:flutter/material.dart';
import '/src/routes/app_routes.dart';
import 'package:flutter_application_1/shared/themes/colors.dart';
import '../widgets/custom_button.dart';

class UserFilterScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
     body: SingleChildScrollView( // scroll
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30.0, 24.0, 30.0, 24.0), // Espacio de widget parte izquierda, superior, derecha e inferior
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 250), // Espacio entre parte superior y logo

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

              Align(  // Frase debajo del título
                alignment: Alignment.center, // Centra el texto
                child: Text(
                  'Health, Sport & Motivation',
                  style: TextStyle(
                    fontSize: 12, // Tamaño del texto
                    color: AppColors.primary, // Color de texto 
                  ),
                ),
              ),

              SizedBox(height: 100), // Espacio entre lema y texto de saludo

              Align( // Texto Inicia sesión con
                alignment: Alignment.center,  // Centra el texto
                child: Text(
                  '¡Hola, escoge tu experiencia!',
                  style: TextStyle(
                    fontSize: 18, // Tamaño de fuente de la frase
                    color: AppColors.primary, // Color de texto
                  ),
                ),
              ),

              SizedBox(height: 20), // Espacio entre saludo y botón Deportista

              CustomButton( // Botón de Deportista
                text: 'Deportista',
                onPressed: () {
                  Navigator.of(context).pushNamed(AppRoutes.login); 
                },
                backgroundColor: AppColors.mainBlue, // Color del botón
                textColor: AppColors.secondary, // Color de texto
                fontSize: 17, // Tamaño de fuente
                padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                elevation: 4,
                width: 304, // Ancho del botón
                height: 50, // Altura del botón
              ),

              SizedBox(height: 20), // Espacio entre botón deportista y centro deportivo

              CustomButton( // Botón de Centro Deportivo
                text: 'Centro Deportivo',
                onPressed: () {
                  Navigator.of(context).pushNamed(AppRoutes.sportsCenters); 
                },
                backgroundColor: AppColors.mainGreen, // Color del botón
                textColor: AppColors.secondary, // Color de texto
                fontSize: 17, // Tamaño de fuente
                padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                elevation: 4,
                width: 304, // Ancho del botón
                height: 50, // Altura del botón
              ),
            ],
          ),
        ),
      ),
    );
  }
}
