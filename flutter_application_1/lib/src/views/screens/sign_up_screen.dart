import 'package:flutter/material.dart';
import 'package:flutter_application_1/shared/themes/colors.dart';
import '../widgets/custom_button.dart';
import '/src/routes/app_routes.dart';
import '../widgets/custom_dropdown_button.dart';
import '../widgets/custom_date_picker_button.dart';
import '../widgets/scroll_Weight_Picker.dart';
import '../widgets/custom_Height_Picker.dart';
import '../widgets/custom_text_field.dart';
import 'package:intl/intl.dart';

class Usuario {
  String Nombre;
  String Apellido1;
  String Apellido2;
  String Genero;
  String FechaNacimiento;
  double Peso;
  double Altura;
  String Objetivo;
  double PesoIdeal;

  Usuario({
    required this.Nombre,
    required this.Apellido1,
    required this.Apellido2,
    required this.Genero,
    required this.FechaNacimiento,
    required this.Peso,
    required this.Altura,
    required this.Objetivo,
    required this.PesoIdeal,
  });
}

class SignUpScreen extends StatefulWidget {
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _nombreController = TextEditingController();
  final _apellido1Controller = TextEditingController();
  final _apellido2Controller = TextEditingController();
  String? _genero;
  String? _fechaNacimiento;
  double _peso = 80.0;
  double _altura = 1.70;
  String? _objetivo;
  double _pesoIdeal = 70.0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30.0, 24.0, 30.0, 24.0),
          child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(AppRoutes.priorSignUp, arguments: 'back');
                },
                icon: Image.asset(
                  'assets/images/Acciones/Icono_Atras.png',
                  width: 30,
                  height: 30,
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(                  
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Image.asset(
                          'assets/images/Logos/Nombre_Lema_Azul.png',
                          width: size.width * 0.5,
                          height: size.height * 0.1,
                        ),
                      ),
                      SizedBox(height: size.height * 0.03),
                      Padding(
                        padding: EdgeInsets.only(right: size.width * 0.25),
                        child: Text(
                          'Completa la información:',
                          style: TextStyle(fontSize: 18, color: AppColors.primary),
                        ),
                      ),
                      SizedBox(height: 15),
                      Padding(
                        padding: EdgeInsets.only(right: size.width * 0.6),
                        child: Text('Nombre:', style: TextStyle(fontSize: 18, color: AppColors.primary)),
                      ),
                      CustomTextField(
                        controller: _nombreController,
                        hintText: 'Nombre',
                        width: 355,
                        height: 55,
                        hintStyle: TextStyle(fontSize: 17, color: Color.fromARGB(255, 108, 97, 97)),
                        fillColor: Color.fromARGB(128, 186, 178, 178),
                        contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 25.0),
                      ),
                      SizedBox(height: 15),
                      Padding(
                        padding: EdgeInsets.only(right: size.width * 0.48),
                        child: Text('Primer apellido:', style: TextStyle(fontSize: 18, color: AppColors.primary)),
                      ),
                      CustomTextField(
                        controller: _apellido1Controller,
                        hintText: 'Apellido',
                        width: 355,
                        height: 55,
                        hintStyle: TextStyle(fontSize: 17, color: Color.fromARGB(255, 108, 97, 97)),
                        fillColor: Color.fromARGB(128, 186, 178, 178),
                        contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 25.0),
                      ),
                      SizedBox(height: 15),
                      Padding(
                        padding: EdgeInsets.only(right: size.width * 0.44),
                        child: Text('Segundo apellido:', style: TextStyle(fontSize: 18, color: AppColors.primary)),
                      ),
                      CustomTextField(
                        controller: _apellido2Controller,
                        hintText: 'Apellido',
                        width: 355,
                        height: 55,
                        hintStyle: TextStyle(fontSize: 17, color: Color.fromARGB(255, 108, 97, 97)),
                        fillColor: Color.fromARGB(128, 186, 178, 178),
                        contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 25.0),
                      ),
                      SizedBox(height: 15),
                      Padding(
                        padding: EdgeInsets.only(right: size.width * 0.6), // en vez de 0.7
                        child: Text(
                          'Género:',
                          style: TextStyle(fontSize: 18, color: AppColors.primary),
                        ),
                      ),
                      CustomDropdownButton(
                        hintText: 'Seleccione un género',
                        items: ['Masculino', 'Femenino',  'Otro'],
                        value: _genero,
                        onChanged: (value) => setState(() => _genero = value!),
                        backgroundColor: Color.fromARGB(128, 212, 203, 203),
                        textColor: Color.fromARGB(255, 84, 77, 77),
                        fontSize: 17,
                        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 4),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                        elevation: 0,
                        width: 355,
                        height: 55,
                      ),
                      SizedBox(height: 15),
                      Padding(
                        padding: EdgeInsets.only(right: size.width * 0.42),
                        child: Text('Fecha de nacimiento:', style: TextStyle(fontSize: 18, color: AppColors.primary)),
                      ),
                      CustomDatePickerButton(
                        hintText: 'Seleccione su fecha de nacimiento',
                        backgroundColor: Color.fromARGB(128, 172, 164, 164),
                        textColor: Color.fromARGB(255, 84, 77, 77),
                        fontSize: 17,
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                        elevation: 0,
                        width: 355,
                        height: 60,
                        onAgeCalculated: (age) {
                          final birthDate = DateTime.now().subtract(Duration(days: age * 365));
                          _fechaNacimiento = DateFormat('dd/MM/yyyy').format(birthDate);
                        },
                      ),
                      SizedBox(height: 15),
                      Padding(
                        padding: EdgeInsets.only(right: size.width * 0.7),
                        child: Text('Peso:', style: TextStyle(fontSize: 18, color: AppColors.primary)),
                      ),
                      DualWeightPickerButton(
                        minValue: 40,
                        maxValue: 150,
                        initialInteger: 80,
                        initialDecimal: 0,
                        onValueChanged: (value) => _peso = value,
                        backgroundColor: Color.fromARGB(128, 172, 164, 164),
                        textColor: Color.fromARGB(255, 108, 97, 97),
                        width: 355,
                        height: 55,
                      ),
                      SizedBox(height: 15),
                      Padding(
                        padding: EdgeInsets.only(right: size.width * 0.7),
                        child: Text('Altura:', style: TextStyle(fontSize: 18, color: AppColors.primary)),
                      ),
                      CustomHeightPicker(
                        onHeightChanged: (altura) => _altura = altura,
                        backgroundColor: const Color.fromARGB(128, 172, 164, 164),
                        textColor: const Color.fromARGB(255, 167, 153, 153),
                        width: 355,
                        height: 55,
                        valueStyle: TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: const Color.fromARGB(255, 108, 97, 97)),
                      ),
                      SizedBox(height: 15),
                      Padding(
                        padding: EdgeInsets.only(right: size.width * 0.38),
                        child: Text('¿Cuál es tu objetivo?', style: TextStyle(fontSize: 18, color: AppColors.primary)),
                      ),
                      CustomDropdownButton(
                        hintText: 'Seleccione su objetivo',
                        items: ['Hipertrofia', 'Definicion muscular', 'Perder peso'],
                        value: _objetivo,
                        onChanged: (value) => setState(() => _objetivo = value!),
                        backgroundColor: Color.fromARGB(128, 212, 203, 203),
                        textColor: Color.fromARGB(255, 84, 77, 77),
                        fontSize: 17,
                        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 4),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                        elevation: 0,
                        width: 355,
                        height: 55,
                      ),
                      SizedBox(height: 15),
                      Padding(
                        padding: EdgeInsets.only(right: size.width * 0.6),
                        child: Text('Peso Ideal:', style: TextStyle(fontSize: 18, color: AppColors.primary)),
                      ),
                      DualWeightPickerButton(
                        minValue: 40,
                        maxValue: 150,
                        initialInteger: 70,
                        initialDecimal: 0,
                        onValueChanged: (value) => _pesoIdeal = value,
                        backgroundColor: Color.fromARGB(128, 172, 164, 164),
                        textColor: Color.fromARGB(255, 108, 97, 97),
                        width: 355,
                        height: 55,
                      ),
                      SizedBox(height: 18),
                      CustomButton(
                        text: 'Siguiente',
                        onPressed: () {
                          if (_nombreController.text.isNotEmpty &&
                              _apellido1Controller.text.isNotEmpty &&
                              _apellido2Controller.text.isNotEmpty &&
                              _genero != null &&
                              _fechaNacimiento != null &&
                              _objetivo != null) {
                            final usuario = Usuario(
                              Nombre: _nombreController.text,
                              Apellido1: _apellido1Controller.text,
                              Apellido2: _apellido2Controller.text,
                              Genero: _genero!,
                              FechaNacimiento: _fechaNacimiento!,
                              Peso: _peso,
                              Altura: _altura,
                              Objetivo: _objetivo!,
                              PesoIdeal: _pesoIdeal,
                            );
                            Navigator.pushNamed(context, AppRoutes.signUp2, arguments: usuario);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Por favor completa todos los campos.')),
                            );
                          }
                        },
                        backgroundColor: AppColors.mainBlue,
                        textColor: AppColors.secondary,
                        fontSize: 17,
                        padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                        elevation: 4,
                        width: 355,
                        height: 55,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
