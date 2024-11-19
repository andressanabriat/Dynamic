import 'package:flutter/material.dart';
import 'package:flutter_application_1/shared/themes/colors.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
import '/src/routes/app_routes.dart';

class RecoverPasswordScreen extends StatelessWidget {
  
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
                padding: const EdgeInsets.only(right: 6), // Espacio desde el borde izquierdo
                child: Text(
                  'Restablecer Contraseña',
                  style: TextStyle(
                    fontSize: 32,
                    color: AppColors.mainBlue,
                  ),
                ),
              ),
                
              SizedBox(height: 30), // Restablecer contraseña y texto

              Text(
                'Introdcue tu correo y te enviaremos instrucciones para restablecer tu contraseña.',
                style: TextStyle(
                  fontSize: 18,
                  color: AppColors.primary,
                ),
              ),

              SizedBox(height: 30), // Espacio entre texto y Correo electronico

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

              SizedBox(height: 250), // Espacio entre Correo electronico y boton enviar

              CustomButton( // Botón de enviar
                text: 'Enviar',
                onPressed: () {
                  //Navigator.pushNamed(context, AppRoutes.); // Navegación 
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