import 'package:flutter/material.dart';
import 'package:flutter_application_1/shared/themes/colors.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_bottom_navigation_bar.dart';
import '../widgets/custom_dropdown_button.dart';
import '../widgets/custom_date_picker_button.dart';
import '../widgets/coustom_height_wight_button.dart';
import '../widgets/custom_text_field.dart';
import '/src/routes/app_routes.dart';
import 'create_new_routine.dart';
import 'exercises.dart';  // Importamos Exercises

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    EntrenamientosTab(), // Pestaña de Entrenamientos (Home)
    Center(child: Text('Informacion fisica')),
    Exercises(), // Pestaña "Ejercicios"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30.0, 35.0, 30.0, 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerLeft,
            ),
            Expanded(child: _screens[_currentIndex]), // Pantalla seleccionada
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}

class EntrenamientosTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Todo alineado a la izquierda
        children: [
          // Encabezado: Título a la izquierda y botón (avatar) a la derecha
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Entrenamientos',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              PopupMenuButton<String>(
                onSelected: (value) {
                  if (value == "Cerrar sesión") {
                    Navigator.pushReplacementNamed(context, AppRoutes.login);
                  }
                  // Aquí puedes agregar acciones para "Mi cuenta" y "Ajustes"
                },
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: "Mi cuenta",
                    child: Text("Mi cuenta"),
                  ),
                  PopupMenuItem(
                    value: "Ajustes",
                    child: Text("Ajustes"),
                  ),
                  PopupMenuItem(
                    value: "Cerrar sesión",
                    child: Text("Cerrar sesión"),
                  ),
                ],
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: AppColors.mainBlue,
                  child: Text(
                    'U', // Inicial del usuario (ejemplo)
                    style: TextStyle(
                      color: AppColors.secondary,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          // Subtítulo "Mi Plan"
          Text(
            'Mi Plan',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: AppColors.primary,
            ),
          ),
          SizedBox(height: 20),
          // Sección con los entrenamientos creados (Ejemplo)
          Column(
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                margin: EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text('Entrenamiento 1'),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                margin: EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text('Entrenamiento 2'),
              ),
            ],
          ),
          SizedBox(height: 20),
          // Botón "Crear nueva rutina"
          CustomButton(
            text: '+ Crear nueva rutina',
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) => Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  child: CreateNewRoutine(),
                ),
              );
            },
            backgroundColor: AppColors.mainBlue,
            textColor: AppColors.secondary,
            fontSize: 17,
            padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            elevation: 4,
            width: double.infinity,
            height: 55,
          ),
        ],
      ),
    );
  }
}
