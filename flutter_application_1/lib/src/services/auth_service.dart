import '../models/usuario.dart';

class AuthService {
  Future<Usuario> login(String email, String password) async {
    // Simulación de una llamada a una API de autenticación
    await Future.delayed(Duration(seconds: 2));

    if (email == 'test@example.com' && password == 'password') {
      return Usuario(id: '1', nombre: 'Juan Pérez', email: email);
    } else {
      throw Exception('Credenciales inválidas');
    }
  }
}
