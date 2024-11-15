import 'package:flutter/material.dart';
import '../models/usuario.dart';
import '../services/auth_service.dart';

class UsuarioProvider with ChangeNotifier {
  String _email = '';
  String _password = '';
  Usuario? _usuario;
  final AuthService _authService = AuthService();

  Usuario? get usuario => _usuario;

  void setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  void setPassword(String password) {
    _password = password;
    notifyListeners();
  }

  Future<void> login(BuildContext context) async {
    try {
      _usuario = await _authService.login(_email, _password);
      notifyListeners();
      Navigator.pushReplacementNamed(context, '/home');
    } catch (e) {
      // Manejar errores, mostrar mensajes al usuario, etc.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al iniciar sesión')),
      );
    }
  }
}
