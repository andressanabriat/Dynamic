import 'package:flutter/material.dart';
import 'package:flutter_application_1/shared/themes/colors.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_bottom_navigation_bar.dart';
import '../widgets/custom_dropdown_button.dart';
import '../widgets/custom_date_picker_button.dart';
import '../widgets/coustom_height_wight_button.dart';
import '../widgets/custom_text_field.dart';
import '/src/routes/app_routes.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    Center(child: Text('Inicio')), // Aquí puedes reemplazarlo con tu contenido real
    Center(child: Text('Rutinas')),
    Center(child: Text('Dietas')),
  ];

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
                  Navigator.of(context).pushNamed(AppRoutes.idSportsCenters, arguments: 'backFilter');
                },
                icon: Image.asset(
                  'assets/images/Acciones/Icono_Atras.png',
                  width: 30,
                  height: 30,
                ),
              ),
            ),
            Expanded(child: _screens[_currentIndex]), // Contenido dinámico según la selección
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
