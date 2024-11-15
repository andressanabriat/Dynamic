import 'package:flutter/material.dart';
import '../../providers/usuario_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final usuarioProvider = Provider.of<UsuarioProvider>(context);
    final usuario = usuarioProvider.usuario;

    return Scaffold(
      appBar: AppBar(
        title: Text('Inicio'),
      ),
      body: Center(
        child: Text('Bienvenido, ${usuario?.nombre ?? 'Usuario'}'),
      ),
    );
  }
}
