import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/firebase_options.dart';
import 'package:provider/provider.dart';
import 'src/routes/app_routes.dart';
import 'shared/themes/themes.dart';
import 'src/views/screens/loading_screen.dart'; 
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dynamic',
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      initialRoute: '/',
      onGenerateRoute: AppRoutes.generateRoute,
      routes: {
        '/': (context) => LoadingScreen(),
      },
    );
  }
}