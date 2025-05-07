import 'package:flutter/material.dart';
import '/src/routes/app_routes.dart';
import 'package:flutter_application_1/shared/themes/colors.dart';
import '../widgets/custom_button.dart';

class UserFilterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            width * 0.08,
            height * 0.03,
            width * 0.08,
            height * 0.03,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 300),
              Align(
                alignment: Alignment.center,
                child: Image.asset(
                  'assets/images/Logos/Logo_Dynamic_Nombre_Lema.png',
                  width: width * 0.5,
                  height: width * 0.5,
                ),
              ),
              SizedBox(height: height * 0.06),
              Align(
                alignment: Alignment.center,
                child: Text(
                  '¡Bienvenido a Dynamic!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              ),
              SizedBox(height: height * 0.01),
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Tu camino hacia una vida más activa y saludable empieza aquí.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: AppColors.primary,
                  ),
                ),
              ),
              SizedBox(height: 100),
              CustomButton(
                text: '¡Empezar!',
                onPressed: () {
                  Navigator.of(context).pushNamed(AppRoutes.login);
                },
                backgroundColor: AppColors.mainBlue,
                textColor: AppColors.secondary,
                fontSize: 17,
                padding: EdgeInsets.symmetric(horizontal: width * 0.2, vertical: height * 0.015),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                elevation: 4,
                width: width * 0.8,
                height: height * 0.07,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
