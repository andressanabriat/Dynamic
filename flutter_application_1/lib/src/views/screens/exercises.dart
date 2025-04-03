import 'package:flutter/material.dart';
import 'package:flutter_application_1/shared/themes/colors.dart';
import '/src/routes/app_routes.dart';

class Exercises extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Todo el contenido se ubica en el body con el mismo padding que en login
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Encabezado: título a la izquierda y botón (avatar con menú) a la derecha
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Ejercicios',
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
                    // Aquí puedes agregar acciones para "Mi cuenta" o "Ajustes"
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
            // Resto del contenido de la vista
            Expanded(
              child: Center(
                child: Text(
                  'Aquí irán los ejercicios',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
