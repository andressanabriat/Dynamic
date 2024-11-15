import 'package:flutter/material.dart';

class AppAnimations {
  static Route createSlideTransition(
    Widget screen, {
      Offset begin = const Offset(1.0, 0.0), // Animacion por defecto
      Offset end = Offset.zero,
      Curve curve = Curves.ease,
      bool back = false, // Parámetro para la animación de ir hacia atras
      bool backFilter = false, // Parámetro para la animación de pantalla principal
    }
  ) 

  {
    Offset slideBegin;

    if(backFilter) 
    {
      slideBegin = Offset(0.0, 1.0); // Deslizamiento desde abajo hacia arriba
    } 
    else if(back) 
    {
      slideBegin = Offset(-1.0, 0.0); // Deslizamiento de derecha a izquierda
    } 
    else 
    {
      slideBegin = begin; // Deslizamiento de izquierda a derecha
    }

    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var tween = Tween(begin: slideBegin, end: end).chain(CurveTween(curve: curve));
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}





  /*static Route createSlideTransition(
    Widget screen, {
    Offset begin = const Offset(1.0, 0.0), // Deslizamiento de derecha a izquierda
    Offset end = Offset.zero,
    Curve curve = Curves.ease,
  }) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }


  // Método para crear una animación de desvanecimiento (fade transition)
  static Route createFadeTransition(Widget screen, {Curve curve = Curves.easeInOut}) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }

  // Método para crear una animación de escala (scale transition)
  static Route createScaleTransition(Widget screen, {Curve curve = Curves.easeInOut}) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return ScaleTransition(
          scale: animation,
          child: child,
        );
      },
    );
  }*/
