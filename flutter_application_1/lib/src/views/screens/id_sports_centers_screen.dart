import 'package:flutter/material.dart';
import 'package:flutter_application_1/shared/themes/colors.dart';
import '../widgets/custom_button.dart';
import '/src/routes/app_routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class IdSportsCentersScreen extends StatefulWidget {
  final String emailUsuario; // ✅ Ahora correctamente recibido por el constructor

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

      // 🔥 Aquí corregimos: tratamos UdGimnasio como un String
      if (udGimnasio == null || udGimnasio == "false" || udGimnasio.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Espera a que el administrador te dé de alta.')),
        );
      } else {
        Navigator.pushNamed(context, AppRoutes.home);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al verificar: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30.0, 24.0, 30.0, 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Image.asset(
                    'assets/images/Acciones/Icono_Atras.png',
                    width: 30,
                    height: 30,
                  ),
                ),
              ),
              SizedBox(height: 300),
              Padding(
                padding: const EdgeInsets.only(right: 2),
                child: Text(
                  '¡Ya casi acabamos!',
                  style: TextStyle(
                    fontSize: 40,
                    color: AppColors.mainBlue,
                  ),
                ),
              ),
              SizedBox(height: 30),
              Text(
                'Solicita a tu administrador que te dé acceso a la aplicación.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: AppColors.primary,
                ),
              ),
              SizedBox(height: 250),
              CustomButton(
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
            ],
          ),
        ),
      ),
    );
  }
}
