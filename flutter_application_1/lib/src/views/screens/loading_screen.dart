import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/views/screens/user_filter_screen.dart';
import 'package:flutter_application_1/shared/themes/colors.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToFiltro();
  }

  _navigateToFiltro() async {
    await Future.delayed(Duration(seconds: 5)); // Simula el tiempo de la carga
    Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => UserFilterScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30.0, 24.0, 30.0, 24.0), // Espacio de widget parte izquierda, superior, derecha e inferior
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start, // Centra los elementos verticalmente
          children: [
            SizedBox(height: 380), // Espacio entre parte superior y logo

            Align( // Logo de Dynamic
              alignment: Alignment.center, // Centra la imagen
              child: Image.asset(
                'assets/images/Logos/Logo_Dynamic.png', 
                width: 100, 
                height: 100, 
              ),
            ),

            SizedBox(height: 250), // Espacio entre el logo y el texto

            Align( // Texto Incia sesión con
              alignment: Alignment.center,  // Centra el texto
              child: Text(
                'Dynamic',
                style: TextStyle(
                  fontSize: 40, // Tamaño de fuente de la frase
                  color: AppColors.primary, // Color de texto
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}