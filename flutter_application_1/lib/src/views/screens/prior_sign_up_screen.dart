import 'package:flutter/material.dart';
import 'package:flutter_application_1/shared/themes/colors.dart';
import '../widgets/custom_button.dart';
import '/src/routes/app_routes.dart';

class PriorSignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30.0, 24.0, 30.0, 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 23.5),
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(AppRoutes.login, arguments: 'back');
                  },
                  icon: Image.asset(
                    'assets/images/Acciones/Icono_Atras.png',
                    width: 30,
                    height: 30,
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.25),
              Padding(
                padding: const EdgeInsets.only(right: 63),
                child: Text(
                  '¿Comenzamos?',
                  style: TextStyle(
                    fontSize: 39,
                    color: AppColors.mainBlue,
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.03),
              Text(
                'Primero, necesito saber un poco sobre ti. Esta información ayudará a crear una experiencia personalizada para cumplir tus objetivos.',
                style: TextStyle(
                  fontSize: 18,
                  color: AppColors.primary,
                ),
              ),
              SizedBox(height: size.height * 0.3),
              CustomButton(
                text: 'Comenzar',
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.signUp);
                },
                backgroundColor: AppColors.mainBlue,
                textColor: AppColors.secondary,
                fontSize: 17,
                padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                elevation: 4,
                width: 355,
                height: 55,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
