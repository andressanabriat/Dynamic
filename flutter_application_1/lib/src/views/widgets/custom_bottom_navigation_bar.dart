import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_application_1/shared/themes/colors.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  CustomBottomNavigationBar({
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppColors.mainBlue, // Color del ítem seleccionado
      unselectedItemColor: AppColors.primary, // Color de los ítems no seleccionados
      items: [
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            currentIndex == 0
                ? 'assets/images/Acciones/icono_cuadricula_azul.svg'
                : 'assets/images/Acciones/icono_cuadricula.svg',
            width: 24,
            height: 24,
          ),
          label: 'Entrenamientos',
        ),
        BottomNavigationBarItem(
          icon: currentIndex == 1
              ? SvgPicture.asset(
                  'assets/images/Acciones/icono_cuerpo_azul.svg',
                  width: 24,
                  height: 24,
                )
              : Image.asset(
                  'assets/images/Acciones/icono_cuerpo.png',
                  width: 24,
                  height: 24,
                ),
          label: 'Tu cuerpo',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            currentIndex == 2
                ? 'assets/images/Acciones/icono_pesa_azul.svg'
                : 'assets/images/Acciones/icono_pesa.svg',
            width: 24,
            height: 24,
          ),
          label: 'Ejercicios',
        ),
      ],
    );
  }
}
