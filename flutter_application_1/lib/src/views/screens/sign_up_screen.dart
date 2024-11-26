import 'package:flutter/material.dart';
import 'package:flutter_application_1/shared/themes/colors.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_dropdown_button.dart';
import '../widgets/custom_date_picker_button.dart';
import '../widgets/coustom_height_wight_button.dart';
import '../widgets/custom_text_field.dart';
import '/src/routes/app_routes.dart';

class SignUpScreen extends StatelessWidget {
  
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
                    Navigator.of(context).pushNamed(AppRoutes.priorSignUp, arguments: 'back'); 
                  }, 
                  icon: Image.asset(
                    'assets/images/Acciones/Icono_Atras.png',
                    width: 30, // Tamaño de la imagen
                    height: 30,
                  ),
                ),
              ),

              Align( // Titulo Dynamic
                alignment: Alignment.center, // Centra el texto
                child: Text(
                  'Dynamic',
                  style: TextStyle(
                    fontSize: 40, // Tamaño del texto
                    color: AppColors.mainBlue,  // Color de texto 
                  ),
                ),
              ),

              Align(  // Lema
                alignment: Alignment.center, // Centra el texto
                child: Text(
                  'Health, Sport & Motivation',
                  style: TextStyle(
                    fontSize: 12.5, // Tamaño del texto
                    color: AppColors.mainBlue, // Color de texto 
                  ),
                ),
              ),

              SizedBox(height: 40), // Espacio entre lema e informacion
              
              Padding(
                padding: const EdgeInsets.only(right: 108), // Espacio desde el borde izquierdo
                child: Text(
                  'Completemos la informacion:',
                  style: TextStyle(
                    fontSize: 18,
                    color: AppColors.primary,
                  ),
                ),
              ),

              SizedBox(height: 15), // Espacio ente informacion y nombre

              Padding(
                padding: const EdgeInsets.only(right: 234), // Espacio desde el borde izquierdo
                child: Text(
                  'Nombre:',
                  style: TextStyle(
                    fontSize: 18,
                    color: AppColors.primary,
                  ),
                ),
              ),

              CustomTextField( // Campo de correo electronico
                hintText: 'Nombre',
                width: 355,  // Ancho del campo
                height: 55,  // Alto del campo
                hintStyle: TextStyle(
                  fontSize: 17, // Tamaño del texto
                  color: Color.fromARGB(255, 108, 97, 97), // Pendiente de cambiar
                ),
                fillColor: Color.fromARGB(128, 186, 178, 178),  // Pendiente de cambiar
                contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 25.0),  // Espaciado interno
              ),

              SizedBox(height: 15), // Espacio entre nombre y apellido 1
              
              Padding(
                padding: const EdgeInsets.only(right: 175), // Espacio desde el borde izquierdo
                child: Text(
                  'Primer apellido:',
                  style: TextStyle(
                    fontSize: 18,
                    color: AppColors.primary,
                  ),
                ),
              ),

              CustomTextField( // Campo de correo electronico
                hintText: 'Apellido',
                width: 355,  // Ancho del campo
                height: 55,  // Alto del campo
                hintStyle: TextStyle(
                  fontSize: 17, // Tamaño del texto
                  color: Color.fromARGB(255, 108, 97, 97), // Pendiente de cambiar
                ),
                fillColor: Color.fromARGB(128, 186, 178, 178),  // Pendiente de cambiar
                contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 25.0),  // Espaciado interno
              ),

              SizedBox(height: 15), // Espacio entre correo apellido 1 y apellido 2
              
              Padding(
                padding: const EdgeInsets.only(right: 160), // Espacio desde el borde izquierdo
                child: Text(
                  'Segundo apellido:',
                  style: TextStyle(
                    fontSize: 18,
                    color: AppColors.primary,
                  ),
                ),
              ),

              CustomTextField( // Campo de correo electronico
                hintText: 'Apellido',
                width: 355,  // Ancho del campo
                height: 55,  // Alto del campo
                hintStyle: TextStyle(
                  fontSize: 17, // Tamaño del texto
                  color: Color.fromARGB(255, 108, 97, 97), // Pendiente de cambiar
                ),
                fillColor: Color.fromARGB(128, 186, 178, 178),  // Pendiente de cambiar
                contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 25.0),  // Espaciado interno
              ),

              SizedBox(height: 15), // Espacio ente informacion y nombre

              Padding(
                padding: const EdgeInsets.only(right: 250), // Espacio desde el borde izquierdo
                child: Text(
                  'Genero:',
                  style: TextStyle(
                    fontSize: 18,
                    color: AppColors.primary,
                  ),
                ),
              ),

              CustomDropdownButton(
                hintText: 'Seleccione un género',
                items: ['Masculino', 'Femenino'],
                value: null,
                onChanged: (value) {
                  print('Seleccionaste: $value');
                },
                backgroundColor: Color.fromARGB(128, 186, 178, 178),
                textColor: Color.fromARGB(255, 108, 97, 97),
                fontSize: 17,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                elevation: 4,
                width: 355,
                height: 55,
              ),

              SizedBox(height: 15), // Espacio ente informacion y nombre

              Padding(
                padding: const EdgeInsets.only(right: 142), // Espacio desde el borde izquierdo
                child: Text(
                  'Fecha de nacimiento:',
                  style: TextStyle(
                    fontSize: 18,
                    color: AppColors.primary,
                  ),
                ),
              ),

              CustomDatePickerButton(
                hintText: 'Seleccione su fecha de nacimiento',
                backgroundColor: Color.fromARGB(128, 186, 178, 178),
                textColor: AppColors.primary,
                fontSize: 17,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                elevation: 4,
                width: 355,
                height: 55,
                onAgeCalculated: (int age) {
                  print('Edad calculada: $age años');
                },
              ),

              SizedBox(height: 15), // Espacio ente informacion y nombre

              Padding(
                padding: const EdgeInsets.only(right: 250), // Espacio desde el borde izquierdo
                child: Text(
                  'Peso:',
                  style: TextStyle(
                    fontSize: 18,
                    color: AppColors.primary,
                  ),
                ),
              ),

              CoustomHeightWightButton(
                minValue: 40,
                maxValue: 150,
                step: 1,
                initialValue: 70,
                onValueChanged: (value) {
                  print("Peso seleccionado: $value kg");
                },
                backgroundColor: const Color.fromARGB(128, 186, 178, 178), // Consistente con los demás botones
                textColor: Colors.blue, // Color del texto y de los íconos
                width: 355, // Ancho consistente
                height: 55, // Alto consistente
                valueStyle: TextStyle(
                  fontSize: 17,
                  color: Colors.blue, // Texto en color azul
                  fontWeight: FontWeight.w600, // Estilo de texto más definido
                ),
              ),

              SizedBox(height: 15), // Espacio ente informacion y nombre

              Padding(
                padding: const EdgeInsets.only(right: 250), // Espacio desde el borde izquierdo
                child: Text(
                  'Altura:',
                  style: TextStyle(
                    fontSize: 18,
                    color: AppColors.primary,
                  ),
                ),
              ),

              CoustomHeightWightButton(
                minValue: 40,
                maxValue: 150,
                step: 1,
                initialValue: 70,
                onValueChanged: (value) {
                  print("Peso seleccionado: $value kg");
                },
                backgroundColor: const Color.fromARGB(128, 186, 178, 178), // Consistente con los demás botones
                textColor: Colors.blue, // Color del texto y de los íconos
                width: 355, // Ancho consistente
                height: 55, // Alto consistente
                valueStyle: TextStyle(
                  fontSize: 17,
                  color: Colors.blue, // Texto en color azul
                  fontWeight: FontWeight.w600, // Estilo de texto más definido
                ),
              ),

              SizedBox(height: 15), // Espacio entre correo apellido 1 y apellido 2
              
              Padding(
                padding: const EdgeInsets.only(right: 145), // Espacio desde el borde izquierdo
                child: Text(
                  'Correo electronico:',
                  style: TextStyle(
                    fontSize: 18,
                    color: AppColors.primary,
                  ),
                ),
              ),

              CustomTextField( // Campo de correo electronico
                hintText: 'Correo',
                width: 355,  // Ancho del campo
                height: 55,  // Alto del campo
                hintStyle: TextStyle(
                  fontSize: 17, // Tamaño del texto
                  color: Color.fromARGB(255, 108, 97, 97), // Pendiente de cambiar
                ),
                fillColor: Color.fromARGB(128, 186, 178, 178),  // Pendiente de cambiar
                contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 25.0),  // Espaciado interno
              ),

              SizedBox(height: 15), // Espacio entre correo apellido 1 y apellido 2
              
              Padding(
                padding: const EdgeInsets.only(right: 205), // Espacio desde el borde izquierdo
                child: Text(
                  'Contraseña:',
                  style: TextStyle(
                    fontSize: 18,
                    color: AppColors.primary,
                  ),
                ),
              ),

              CustomTextField( // Campo de correo electronico
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

              SizedBox(height: 15), // Espacio entre correo apellido 1 y apellido 2
              
              Padding(
                padding: const EdgeInsets.only(right: 130), // Espacio desde el borde izquierdo
                child: Text(
                  'Repita la contraseña:',
                  style: TextStyle(
                    fontSize: 18,
                    color: AppColors.primary,
                  ),
                ),
              ),

              CustomTextField( // Campo de correo electronico
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
                  Navigator.pushNamed(context, AppRoutes.idSportsCenters); // Navegación 
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