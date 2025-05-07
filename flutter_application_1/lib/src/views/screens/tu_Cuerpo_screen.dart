import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/shared/themes/colors.dart';
import '/src/routes/app_routes.dart';
import '../widgets/custom_dropdown_button.dart';
import '../widgets/scroll_Weight_Picker.dart';
import '../widgets/custom_height_picker.dart';
import '../widgets/custom_button.dart';
import 'mi_cuenta_screen.dart';


class TuCuerpoScreen extends StatefulWidget {
  final String userEmail;
  const TuCuerpoScreen({Key? key, required this.userEmail}) : super(key: key);

  @override
  State<TuCuerpoScreen> createState() => _TuCuerpoScreenState();
}

class _TuCuerpoScreenState extends State<TuCuerpoScreen> {
  double? _peso;
  double? _altura;
  double? _pesoIdeal;
  String? _objetivo;

  double? _editPeso;
  double? _editAltura;
  double? _editPesoIdeal;
  String? _editObjetivo;

  String _inicialNombre = "";

  bool _editando = false;
  bool _cargando = true;

  @override
  void initState() {
    super.initState();
    _cargarDatos();
  }

  Future<void> _cargarDatos() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('clientes')
        .where('Email', isEqualTo: widget.userEmail)
        .get();

    if (snapshot.docs.isNotEmpty) {
      final data = snapshot.docs.first.data();
      setState(() {
        _peso = (data['Peso'] ?? 0).toDouble();
        _altura = (data['Altura'] ?? 0).toDouble();
        _pesoIdeal = (data['PesoIdeal'] ?? 0).toDouble();
        _objetivo = data['Objetivo'] ?? 'No especificado';
        _inicialNombre = (data['Nombre'] ?? 'U').toString().trim().isNotEmpty
            ? data['Nombre'][0].toUpperCase()
            : 'U';
        _cargando = false;
      });
    } else {
      setState(() => _cargando = false);
    }
  }

  Future<void> _guardarCambios() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('clientes')
        .where('Email', isEqualTo: widget.userEmail)
        .get();

    if (snapshot.docs.isNotEmpty) {
      final docId = snapshot.docs.first.id;
      await FirebaseFirestore.instance.collection('clientes').doc(docId).update({
        'Peso': _editPeso,
        'Altura': _editAltura,
        'PesoIdeal': _editPesoIdeal,
        'Objetivo': _editObjetivo,
      });

      setState(() {
        _peso = _editPeso;
        _altura = _editAltura;
        _pesoIdeal = _editPesoIdeal;
        _objetivo = _editObjetivo;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Datos actualizados correctamente')),
      );
    }
  }

  void _mostrarModalEdicion() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          left: 24,
          right: 24,
          bottom: MediaQuery.of(context).viewInsets.bottom + 16,
          top: 24,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCampoEdicion("Altura", CustomHeightPicker(
              onHeightChanged: (value) => _editAltura = value,
              width: 180,
              height: 45,
              backgroundColor: Colors.grey[200],
              textColor: Colors.black,
            )),
            _buildCampoEdicion("Peso", DualWeightPickerButton(
              minValue: 40,
              maxValue: 150,
              initialInteger: _editPeso!.toInt(),
              initialDecimal: ((_editPeso! - _editPeso!.toInt()) * 10).round(),
              onValueChanged: (value) => _editPeso = value,
              width: 180,
              height: 45,
              backgroundColor: Colors.grey[200],
              textColor: const Color.fromARGB(255, 67, 67, 67),
            )),
            _buildCampoEdicion("Peso Ideal", DualWeightPickerButton(
              minValue: 40,
              maxValue: 150,
              initialInteger: _editPesoIdeal!.toInt(),
              initialDecimal: ((_editPesoIdeal! - _editPesoIdeal!.toInt()) * 10).round(),
              onValueChanged: (value) => _editPesoIdeal = value,
              width: 180,
              height: 45,
              backgroundColor: Colors.grey[200],
              textColor: const Color.fromARGB(255, 67, 67, 67),
            )),
            SizedBox(height: 10),
            CustomDropdownButton(
              hintText: 'Seleccione su objetivo',
              items: ['Hipertrofia', 'Definicion muscular', 'Perder peso'],
              value: _editObjetivo,
              onChanged: (val) => setState(() => _editObjetivo = val!),
              width: double.infinity,
              height: 55,
              backgroundColor: Colors.grey[200],
              textColor: const Color.fromARGB(255, 67, 67, 67),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomButton(
                  text: 'Cancelar',
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  backgroundColor: Colors.grey,
                  textColor: Colors.white,
                  width: 150,
                  height: 45,
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                CustomButton(
                  text: 'Guardar',
                  onPressed: () async {
                    await _guardarCambios();
                    Navigator.pop(context);
                  },
                  backgroundColor: AppColors.mainBlue,
                  textColor: AppColors.secondary,
                  width: 150,
                  height: 45,
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCampoEdicion(String etiqueta, Widget campo) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            etiqueta,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          campo,
        ],
      ),
    );
  }

  String _obtenerTip(String objetivo) {
    switch (objetivo) {
      case 'Hipertrofia':
        return '💪 Para ganar masa muscular, combina entrenamiento de fuerza con una alimentación rica en proteínas y descanso adecuado.';
      case 'Definicion muscular':
        return '🔥 Para definir, enfócate en mantener el músculo mientras reduces grasa con dieta limpia y entrenamiento intenso.';
      case 'Perder peso':
        return '🥗 La clave para perder peso está en el déficit calórico y una alimentación balanceada. ¡Sé constante y verás resultados!';
      default:
        return '🔍 Establece un objetivo claro para recibir un consejo personalizado.';
    }
  }

  @override
  Widget build(BuildContext context) {
    double progreso;
    if (_peso != null && _pesoIdeal != null && _objetivo != null && _pesoIdeal != 0) {
      double currentPeso = _peso!;
      double idealPeso = _pesoIdeal!;
      String objetivo = _objetivo!;

      if (objetivo == 'Perder peso') {
        if (currentPeso > idealPeso) { // Estás por encima de tu peso ideal
          progreso = (idealPeso / currentPeso).clamp(0.0, 1.0);
        } else { // Estás en tu peso ideal o por debajo
          progreso = (currentPeso / idealPeso).clamp(0.0, 1.0);
        }
      } else if (objetivo == 'Hipertrofia') {
        if (currentPeso >= idealPeso) {
          progreso = 1.0;
        } else { // currentPeso < idealPeso
          progreso = (currentPeso / idealPeso).clamp(0.0, 1.0);
        }
      } else if (objetivo == 'Definicion muscular') {
        if (currentPeso == idealPeso) {
          progreso = 1.0;
        } else if (currentPeso > idealPeso) { // Necesita perder peso para definición
          progreso = (idealPeso / currentPeso).clamp(0.0, 1.0);
        } else { // currentPeso < idealPeso (Necesita ganar masa magra para definición en idealPeso)
          progreso = (currentPeso / idealPeso).clamp(0.0, 1.0);
        }
      } else {
        // Fallback para objetivos desconocidos: lógica original
        progreso = (currentPeso / idealPeso).clamp(0.0, 1.0);
      }
    } else {
      progreso = 0.0; // Si falta algún dato crucial
    }

    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Tu Cuerpo',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: AppColors.mainBlue,
                ),
              ),
              PopupMenuButton<String>(
                onSelected: (value) {
                  if (value == "Mi cuenta") {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MiCuentaScreen(userEmail: widget.userEmail),
                      ),
                    );
                  } else if (value == "Cerrar sesión") {
                    Navigator.pushReplacementNamed(context, AppRoutes.login);
                  }
                },
                itemBuilder: (context) => [
                  PopupMenuItem(value: "Mi cuenta", child: Text("Mi cuenta")),
                  PopupMenuItem(value: "Cerrar sesión", child: Text("Cerrar sesión")),
                ],
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: AppColors.mainBlue,
                  child: Text(
                    _inicialNombre,
                    style: TextStyle(
                      color: AppColors.secondary,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          if (_cargando)
            Center(child: CircularProgressIndicator())
          else if (_peso == null || _altura == null || _pesoIdeal == null || _objetivo == null)
            Center(child: Text('No se encontró la información del usuario.'))
          else ...[
            Center(
              child: Text(
                '$_objetivo',
                style: TextStyle(
                  fontSize: 25,
                  color: const Color.fromARGB(255, 0, 0, 0),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 45),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _datoGrande('${_altura!.toStringAsFixed(2)} m', 'Tu Altura'),
                      _datoGrande('${_peso!.toStringAsFixed(1)} kg', 'Tu Peso'),
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _datoGrande('${_pesoIdeal!.toStringAsFixed(1)} kg', 'Peso ideal', color: AppColors.mainBlue),
                      _datoGrande('${(_pesoIdeal! - _peso!).toStringAsFixed(1)} kg', 'Diferencia', color: Colors.red),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Progreso hacia tu objetivo", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: LinearProgressIndicator(
                      value: progreso,
                      backgroundColor: Colors.grey[300],
                      color: AppColors.mainBlue,
                      minHeight: 10,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text("${(progreso * 100).toStringAsFixed(1)}% completado", style: TextStyle(color: Colors.grey[700]))
                ],
              ),
            ),
            SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.mainBlue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  _obtenerTip(_objetivo ?? ''),
                  style: TextStyle(fontSize: 15, color: Colors.black87),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(height: 24),
            CustomButton(
              text: 'Actualizar datos',
              onPressed: () {
                _editando = true;
                _editPeso = _peso;
                _editAltura = _altura;
                _editPesoIdeal = _pesoIdeal;
                _editObjetivo = _objetivo;
                _mostrarModalEdicion();
              },
              backgroundColor: AppColors.mainBlue,
              textColor: AppColors.secondary,
              width: double.infinity,
              height: 50,
              fontSize: 16,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _datoGrande(String valor, String etiqueta, {Color? color}) {
    return Column(
      children: [
        Text(
          valor,
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: color ?? Colors.black,
          ),
        ),
        SizedBox(height: 4),
        Text(
          etiqueta,
          style: TextStyle(
            fontSize: 14,
            color: color ?? Colors.black,
          ),
        ),
      ],
    );
  }
}
