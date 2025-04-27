import 'package:flutter/material.dart';
import '../views/screens/home_screen.dart';
import '../views/screens/id_sports_centers_screen.dart';
import '../views/screens/login_screen.dart';
import '../views/screens/recover_password_screen.dart';
import '../views/screens/prior_sign_up_screen.dart';
import '../views/screens/sign_up_screen.dart';
import '../views/screens/sign_up_screen_2.dart';
import '../views/screens/sports_centers_screen.dart';
import '../views/screens/user_filter_screen.dart';
import '../views/screens/create_new_routine.dart';
import '../views/screens/exercises.dart';
import 'package:flutter_application_1/src/utils/animations.dart';
import '../views/screens/sign_up_screen.dart'; // Importa también Usuario

class AppRoutes {
  static const String userFilter = '/filter';
  static const String sportsCenters = '/centers';
  static const String login = '/login';
  static const String recoverPassword = '/recover';
  static const String priorSignUp = '/priorSignUp';
  static const String signUp = '/signUp';
  static const String signUp2 = '/signUp2';
  static const String idSportsCenters = '/idSportsCenters';
  static const String home = '/home';
  static const String crearRutina = '/crearRutina';
  static const String exercises = '/exercises';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final bool goingBack = settings.arguments == 'back';
    final bool goingFilter = settings.arguments == 'backFilter';

    switch (settings.name) {
      case userFilter:
        return AppAnimations.createSlideTransition(UserFilterScreen(), backFilter: goingFilter);

      case sportsCenters:
        return AppAnimations.createSlideTransition(SportsCentersScreen(), backFilter: goingFilter);

      case login:
        return AppAnimations.createSlideTransition(LoginScreen(), backFilter: goingFilter);

      case recoverPassword:
        return AppAnimations.createSlideTransition(RecoverPasswordScreen(), back: goingBack);

      case priorSignUp:
        return AppAnimations.createSlideTransition(PriorSignUpScreen(), back: goingBack);

      case signUp:
        return AppAnimations.createSlideTransition(SignUpScreen(), back: goingBack);

      case signUp2:
        if (settings.arguments is Usuario) {
          final usuario = settings.arguments as Usuario;
          return AppAnimations.createSlideTransition(SignUpScreen2(usuario: usuario), back: goingBack);
        }
        return _errorRoute();

      case idSportsCenters:
        if (settings.arguments is String) {
          final emailUsuario = settings.arguments as String;
          return AppAnimations.createSlideTransition(IdSportsCentersScreen(emailUsuario: emailUsuario), back: goingBack);
        }
        return _errorRoute();

      case home:
        return AppAnimations.createSlideTransition(HomeScreen(), back: goingBack);

      case crearRutina:
        return AppAnimations.createSlideTransition(CreateNewRoutine(), back: goingBack);

      case exercises:
        return AppAnimations.createSlideTransition(Exercises(), back: goingBack);

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        body: Center(
          child: Text(
            'Ruta no encontrada',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
