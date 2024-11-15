import 'package:flutter/material.dart';
import '../views/screens/user_filter_screen.dart';
import '../views/screens/login_screen.dart';
import '../views/screens/sports_centers_screen.dart';
import '../views/screens/home_screen.dart';
import '../views/screens/recover_password_screen.dart';
import 'package:flutter_application_1/src/utils/animations.dart';

class AppRoutes {
  static const String userFilter = '/filter'; 
  static const String sportsCenters = '/centers'; 
  static const String login = '/login';
  static const String recoverPassword = '/recover';
  static const String home = '/home';

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
      case home:
        return AppAnimations.createSlideTransition(HomeScreen(), back: goingBack);
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('Ruta no encontrada: ${settings.name}'),
            ),
          ),
        );
    }
  }
}