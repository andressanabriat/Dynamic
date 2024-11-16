import 'package:flutter/material.dart';
import '../../providers/usuario_provider.dart';
import '../widgets/custom_button.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/shared/themes/colors.dart';
import '/src/routes/app_routes.dart';

class SportsCentersScreen extends StatelessWidget{

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

              SizedBox(height: 100),

              Align( 
                alignment: Alignment.center, // Centra el texto
                child: Text(
                  'En obras....',
                  style: TextStyle(
                    fontSize: 34, // Tamaño del texto
                    color: AppColors.primary,  // Color de texto 
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