import 'package:flutter/material.dart';
import 'package:flutter_application_1/shared/themes/colors.dart';
import '../widgets/custom_button.dart';
import '/src/routes/app_routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class IdSportsCentersScreen extends StatefulWidget {
  final String emailUsuario;

  const IdSportsCentersScreen({Key? key, required this.emailUsuario}) : super(key: key);

  @override
  State<IdSportsCentersScreen> createState() => _IdSportsCentersScreenState();
}

class _IdSportsCentersScreenState extends State<IdSportsCentersScreen> {

  Future<void> verificarUdGimnasio() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('clientes')
          .where('Email', isEqualTo: widget.emailUsuario)
          .get();

      if (snapshot.docs.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No se encontró información del usuario en la base de datos.')),
        );
        return;
      }

      final datosUsuario = snapshot.docs.first.data();
      final udGimnasio = datosUsuario['UdGimnasio'];

      if (udGimnasio == null || udGimnasio == "false" || udGimnasio.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Espera a que el personal del gimansio te dé de alta.')),
        );
      } else {
        Navigator.pushNamed(context, AppRoutes.home, arguments: widget.emailUsuario);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al verificar: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: screenHeight * 0.04, vertical: screenHeight * 0.03),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(AppRoutes.login, arguments: 'backFilter');
                },
                icon: Image.asset(
                  'assets/images/Acciones/Icono_Atras.png',
                  width: 30,
                  height: 30,
                ),
              ),
              SizedBox(height: screenHeight * 0.3),
              Text(
                '¡Ya casi acabamos!',
                style: TextStyle(
                  fontSize: 40,
                  color: AppColors.mainBlue,
                ),
              ),
              SizedBox(height: screenHeight * 0.04),
              Text(
                'Solicita al personal de tu gimnasio que te dé acceso a la aplicación.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: AppColors.primary,
                ),
              ),
              SizedBox(height: screenHeight * 0.25),
              Center(
                child: CustomButton(
                  text: '¡Empezar!',
                  onPressed: verificarUdGimnasio,
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
