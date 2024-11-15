import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'src/providers/usuario_provider.dart';
import 'src/routes/app_routes.dart';
import 'shared/themes/themes.dart';
import 'src/views/screens/loading_screen.dart'; 

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider<UsuarioProvider>(
      create: (_) => UsuarioProvider(),
      child: MaterialApp(
        title: 'Dynamic',
        debugShowCheckedModeBanner: false,
        theme: appTheme,
        initialRoute: '/', // Define la pantalla de carga como ruta inicial
        onGenerateRoute: AppRoutes.generateRoute, // Llama a generateRoute para manejar rutas y animaciones
        routes: {
          '/': (context) => LoadingScreen(), // Ruta a pantalla de incio de carga
         // ...AppRoutes.routes, // El resto de las rutas
        },
      ),
    );
  }
}