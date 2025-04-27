import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class EmailService {
  static String _generarContrasenaTemporal() {
    const String caracteres = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789@#%^&*';
    Random random = Random();
    return String.fromCharCodes(
      Iterable.generate(10, (_) => caracteres.codeUnitAt(random.nextInt(caracteres.length))),
    );
  }

  static Future<bool> restablecerContrasena(String email) async {
    try {
      final query = await FirebaseFirestore.instance
          .collection('clientes')
          .where('Email', isEqualTo: email) 
          .get();

      if (query.docs.isEmpty) {
        return false; // No existe el correo
      }

      final nuevaContrasena = _generarContrasenaTemporal();
      final usuarioId = query.docs.first.id;

      await FirebaseFirestore.instance
          .collection('clientes')
          .doc(usuarioId)
          .update({'Contraseña': nuevaContrasena}); // Actualizando "Contraseña" (mayúscula y ñ)

      await enviarCorreo(email, nuevaContrasena);

      return true;
    } catch (e) {
      print('Error al restablecer contraseña: $e');
      return false;
    }
  }

  static Future<void> enviarCorreo(String destinatario, String contrasenaTemporal) async {
    String username = 'dynamic.hsm100@gmail.com';
    String password = 'crctakixsgsaaxop'; // Tu contraseña de aplicación (correcta)

    final smtpServer = gmail(username, password);

    final mensaje = Message()
      ..from = Address(username, 'Dynamic HSM')
      ..recipients.add(destinatario)
      ..subject = 'Tu nueva contraseña temporal'
      ..text = 'Hola,\n\n'
          'Tu nueva contraseña temporal es: $contrasenaTemporal\n\n'
          'Te recomendamos cambiarla una vez que ingreses a la aplicación.\n\n'
          '¡Saludos de parte del equipo Dynamic!';

    try {
      await send(mensaje, smtpServer);
      print('Correo enviado correctamente a $destinatario');
    } catch (e) {
      print('Error al enviar correo: $e');
    }
  }
}
