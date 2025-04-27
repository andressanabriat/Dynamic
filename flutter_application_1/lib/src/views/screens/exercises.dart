import 'package:flutter/material.dart';
import 'package:flutter_application_1/shared/themes/colors.dart';
import '/src/routes/app_routes.dart';
import 'package:video_player/video_player.dart';

class Exercises extends StatefulWidget {
  @override
  _ExercisesState createState() => _ExercisesState();
}

class _ExercisesState extends State<Exercises> {
  bool _showFrontal = true;
  bool _sistemaMuscularSelected = true;
  bool _hombrosSelected = false;
  bool _bicepsSelected = false;
  bool _oblicuosSelected = false;
  bool _aductoresSelected = false;
  bool _tibiaAnteriorSelected = false;
  bool _pectoralesSelected = false;
  bool _abdomenSelected = false;
  bool _antebrazoSelected = false;
  bool _cuadricepsSelected = false;
  bool _cardioFSelected = false;
  
  bool _tricepsSelected = false;
  bool _lumbaresSelected = false;
  bool _isquitibialesSelected = false;
  bool _pantorrillasSelected = false;
  bool _trapeciosSelected = false;
  bool _dorsalesSelected = false;
  bool _gluteosSelected = false;
  bool _cardioTSelected = false;

  late VideoPlayerController _bicepsVideoController;

  final List<String> _hombrosExercises = [
    "Press militar con barra",
    "Elevaciones laterales",
    "Elevaciones frontales",
    "Pájaros con mancuernas",
    "Encogimientos de hombros",
    "Press Arnold",
    "Remo al mentón"
  ];

  final List<String> _bicepsExercises = [
    "Curl con mancuernas",
    "Curl con barra",
    "Curl tipo martillo",
    "Curl en banco inclinado",
    "Curl predicador",
    "Curl en polea"
  ];


  final Map<String, String> _abdomenGifs = {
    "Abdominales declivadas": "assets/images/Gifs/Abdomen/abdominalesDeclive.gif",
    "Abdominales con palanca": "assets/images/Gifs/Abdomen/abdominalesPalanca.gif",
    "Abdominales ponderadas con mancuernas": "assets/images/Gifs/Abdomen/abdominalesPonderadosMancuernas.gif",
  };

  final Map<String, String> _aductoresGifs = {
  "Aduccion de cadera en palanca sentada": "assets/images/Gifs/Aductores/aducciónCaderaPalancaSentada.gif",
  "Sentadilla sumo con mancuernas": "assets/images/Gifs/Aductores/sentadillaSumoMancuernas.gif",
  "Peso muerto sumo en maquina Smith": "assets/images/Gifs/Aductores/smithSumoDeadlift.gif",
  };

  final Map<String, String> _antebrazoGifs = {
    "Desviacion cubital con mancuernas": "assets/images/Gifs/Antebrazo/desviacionCubitalMancuernas.gif",
    "Flexion martillo de muñeca en banco con mancuernas": "assets/images/Gifs/Antebrazo/flexionMartilloMuñecaBancoMancuernas.gif",
    "Flexion de muñeca en banco con mancuernas": "assets/images/Gifs/Antebrazo/flexionMuñecaBancoMancuernas.gif",
  };

  final Map<String, String> _bicepsGifs = {
    "Curl de biceps inclinado con mancuernas": "assets/images/Gifs/Biceps/curlBicepsInclinadoMancuernas.gif",
    "Curl de biceps con mancuernas": "assets/images/Gifs/Biceps/curlBicepsMancuernas.gif",
    "Curl martillo cruzado con mancuernas": "assets/images/Gifs/Biceps/curlMartilloCuerpoCruzadoMancuernas.gif",
  };

  final Map<String, String> _cardioGifs = {
    "Bicicleta estatica": "assets/images/Gifs/Cardio/bicicletaEstatica.gif",
    "Cinta de correr": "assets/images/Gifs/Cardio/cinta.gif",
    "Maquina eliptica": "assets/images/Gifs/Cardio/maquinaEliptica.gif",
  };

  final Map<String, String> _cuadricepsGifs = {
    "Extension de piernas en palanca": "assets/images/Gifs/Cuadriceps/extensionPiernasPalanca.gif",
    "Prensa de piernas en trineo": "assets/images/Gifs/Cuadriceps/prensaPiernasTrineo.gif",
    "Sentadilla frontal en maquina Smith": "assets/images/Gifs/Cuadriceps/sentadillaFrontalSmith.gif",
  };

  final Map<String, String> _dorsalesGifs = {
    "Remo con barra inclinada": "assets/images/Gifs/Dorsales/barraInclinadaFila.gif",
    "Dominadas en cable": "assets/images/Gifs/Dorsales/dominadasCable.gif",
    "Remo bajo en palanca": "assets/images/Gifs/Dorsales/remoBajoPalanca.gif",
  };

  final Map<String, String> _gluteosGifs = {
    "Hiperextension inversa en Smith": "assets/images/Gifs/Gluteos/hiperextensionInversaSmith.gif",
    "Hip thrust en maquina": "assets/images/Gifs/Gluteos/maquinaHipThrust.gif",
    "Patada de burro en Smith": "assets/images/Gifs/Gluteos/patadaBurroSmith.gif",
  };

  final Map<String, String> _hombrosGifs = {
    "Elevacion lateral sentado con mancuernas": "assets/images/Gifs/Hombros/elevacionLateralMancuernasSentado.gif",
    "Levantamiento frontal de pie con mancuernas": "assets/images/Gifs/Hombros/levantamientoFrontalMancuernasDePie.gif",
    "Prensa con barra de pie": "assets/images/Gifs/Hombros/prensaBarraDePie.gif",
  };

  final Map<String, String> _isquiotibialesGifs = {
    "Flexion de pie en palanca": "assets/images/Gifs/Isquiotibiales/flexionPalancaDePie.gif",
    "Flexion sentada en palanca": "assets/images/Gifs/Isquiotibiales/flexionPalancaSentada.gif",
    "Flexion en posicion horizontal con palanca": "assets/images/Gifs/Isquiotibiales/flexionPosicionPalanca.gif",
  };

  final Map<String, String> _lumbaresGifs = {
    "Extension de espalda con mancuernas": "assets/images/Gifs/Lumbares/extensionEspaldaMncuernas.gif",
    "Iron man": "assets/images/Gifs/Lumbares/ironMan.gif",
    "Superman": "assets/images/Gifs/Lumbares/superman.gif",
  };

  final Map<String, String> _oblicuosGifs = {
    "Abdominales bicicleta": "assets/images/Gifs/Oblicuos/abdominalesBicicleta.gif",
    "Abdominales laterales": "assets/images/Gifs/Oblicuos/abdominalesLaterales.gif",
    "Puente lateral": "assets/images/Gifs/Oblicuos/puenteLateral.gif",
  };

  final Map<String, String> _pantorrillasGifs = {
    "Elevacion de pie en palanca": "assets/images/Gifs/Pantorrillas/elevacionDePiePalanca.gif",
    "Elevacion con mancuernas": "assets/images/Gifs/Pantorrillas/elevacionMancuernas.gif",
    "Elevacion sentado en palanca": "assets/images/Gifs/Pantorrillas/elevacionPalancaSentada.gif",
  };

  final Map<String, String> _pectoralesGifs = {
    "Jersey con mancuernas en banco": "assets/images/Gifs/Pectorales/jerseyMancuernasBanco.gif",
    "Press banca con barra": "assets/images/Gifs/Pectorales/pressBancaBarra.gif",
    "Press banca declinado con barra": "assets/images/Gifs/Pectorales/pressBancaBarraDeclinada.gif",
  };

  final Map<String, String> _tibiaAnteriorGifs = {
    "Piernas en trineo horizontal": "assets/images/Gifs/TibiaAnterior/piernasHorizontalTrineo.gif",
  };

  final Map<String, String> _trapecioGifs = {
    "Encogimiento de pie con mancuernas": "assets/images/Gifs/Trapecio/encogimientoMancuernasDePie.gif",
    "Encogimiento en polea": "assets/images/Gifs/Trapecio/encogimientooPolea.gif",
    "Remo vertical en polea": "assets/images/Gifs/Trapecio/remoVerticalPolea.gif",
  };

  final Map<String, String> _tricepsGifs = {
    "Extension acostado con barra": "assets/images/Gifs/Triceps/extensionBarraAcostada.gif",
    "Extension por encima de la cabeza": "assets/images/Gifs/Triceps/extensionEncimaCabeza.gif",
    "Flexion de triceps en cable": "assets/images/Gifs/Triceps/flexionCable.gif",
};

  late Map<String, VideoPlayerController> _hombrosVideoControllers;

  void _toggleView() {
    setState(() {
      _showFrontal = !_showFrontal;
      _sistemaMuscularSelected = true;
      _hombrosSelected = false;
      _bicepsSelected = false;
      _oblicuosSelected = false;
      _aductoresSelected = false;
      _tibiaAnteriorSelected = false;
      _pectoralesSelected = false;
      _abdomenSelected = false;
      _antebrazoSelected = false;
      _cuadricepsSelected = false;
      _cardioFSelected = false;
    });
  }


  @override
  Widget build(BuildContext context) {
    // Frontal
    final String imageAsset = _showFrontal
      ? (_hombrosSelected
          ? 'assets/images/Musculacion/Hombros.png'
          : _bicepsSelected
              ? 'assets/images/Musculacion/Biceps.png'
              : _oblicuosSelected
                  ? 'assets/images/Musculacion/Oblicuos.png'
                  : _aductoresSelected
                      ? 'assets/images/Musculacion/Aductores.png'
                      : _tibiaAnteriorSelected
                          ? 'assets/images/Musculacion/TibiaAnterior.png'
                          : _pectoralesSelected
                              ? 'assets/images/Musculacion/Pectorales.png'
                              : _abdomenSelected
                                  ? 'assets/images/Musculacion/Abdomen.png'
                                  : _antebrazoSelected
                                      ? 'assets/images/Musculacion/Antebrazo.png'
                                      : _cuadricepsSelected
                                          ? 'assets/images/Musculacion/Cuadriceps.png'
                                          : _cardioFSelected
                                              ? 'assets/images/Musculacion/CardioF.png'
                                              : 'assets/images/Musculacion/Frontal.png')
                          
      // Traser
      : (_tricepsSelected
        ? 'assets/images/Musculacion/Triceps.png'
        : _lumbaresSelected
            ? 'assets/images/Musculacion/Lumbares.png'
            : _isquitibialesSelected
                ? 'assets/images/Musculacion/Isquiotibiales.png'
                : _pantorrillasSelected
                    ? 'assets/images/Musculacion/Pantorrillas.png'
                    : _trapeciosSelected
                        ? 'assets/images/Musculacion/Trapecios.png'
                        : _dorsalesSelected
                            ? 'assets/images/Musculacion/Dorsales.png'
                            : _gluteosSelected
                                ? 'assets/images/Musculacion/Gluteos.png'
                                : _cardioTSelected
                                    ? 'assets/images/Musculacion/CardioT.png'
                                    : 'assets/images/Musculacion/Trasera.png');

    // Determina si hay algún músculo seleccionado
    final bool anySelected = _showFrontal
        ? (_hombrosSelected ||
            _bicepsSelected ||
            _oblicuosSelected ||
            _aductoresSelected ||
            _tibiaAnteriorSelected ||
            _pectoralesSelected ||
            _abdomenSelected ||
            _antebrazoSelected ||
            _cuadricepsSelected ||
            _cardioFSelected)
        : (_tricepsSelected ||
            _lumbaresSelected ||
            _isquitibialesSelected ||
            _pantorrillasSelected ||
            _trapeciosSelected ||
            _dorsalesSelected ||
            _gluteosSelected ||
            _cardioTSelected);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // — Encabezado —
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Ejercicios',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  PopupMenuButton<String>(
                    onSelected: (value) {
                      if (value == "Cerrar sesión") {
                        Navigator.pushReplacementNamed(context, AppRoutes.login);
                      }
                    },
                    itemBuilder: (_) => [
                      PopupMenuItem(value: "Mi cuenta", child: Text("Mi cuenta")),
                      PopupMenuItem(value: "Ajustes", child: Text("Ajustes")),
                      PopupMenuItem(
                          value: "Cerrar sesión", child: Text("Cerrar sesión")),
                    ],
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: AppColors.mainBlue,
                      child: Text(
                        'U',
                        style: TextStyle(
                            color: AppColors.secondary, fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 10),

            // — Imagen interactiva —
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Stack(
                children: [
                  Image.asset(
                    imageAsset,
                    width: double.infinity,
                    fit: BoxFit.contain,
                  ),

                  // FRONTAL
                  // **ZONA ORIGINAL DE HOMBROS**
                  if (_showFrontal)
                    Positioned(
                      top: 60,
                      left: 0,
                      width: 100,
                      height: 35,
                      child: GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          setState(() {
                            _sistemaMuscularSelected = false;
                            _hombrosSelected = true;
                            _bicepsSelected = false;
                            _oblicuosSelected = false;
                            _aductoresSelected = false;
                            _tibiaAnteriorSelected = false;
                            _pectoralesSelected = false;
                            _abdomenSelected = false;
                            _antebrazoSelected = false;
                            _cuadricepsSelected = false;
                            _cardioFSelected = false;

                            _tricepsSelected = false;
                            _lumbaresSelected = false;
                            _isquitibialesSelected = false;
                            _pantorrillasSelected = false;
                            _trapeciosSelected = false;
                            _dorsalesSelected = false;
                            _gluteosSelected = false;
                            _cardioTSelected = false;
                          });
                        },
                        //child: Container(color: const Color.fromARGB(255, 4, 255, 0).withOpacity(0.3)),
                      ),
                    ),

                  // **ZONA ORIGINAL DE BÍCEPS**
                  if (_showFrontal)
                    Positioned(
                      top: 120,
                      left: 0,
                      width: 100,
                      height: 35,
                      child: GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          setState(() {
                            _sistemaMuscularSelected = false;
                            _hombrosSelected = false;
                            _bicepsSelected = true;
                            _oblicuosSelected = false;
                            _aductoresSelected = false;
                            _tibiaAnteriorSelected = false;
                            _pectoralesSelected = false;
                            _abdomenSelected = false;
                            _antebrazoSelected = false;
                            _cuadricepsSelected = false;
                            _cardioFSelected = false;

                            _tricepsSelected = false;
                            _lumbaresSelected = false;
                            _isquitibialesSelected = false;
                            _pantorrillasSelected = false;
                            _trapeciosSelected = false;
                            _dorsalesSelected = false;
                            _gluteosSelected = false;
                            _cardioTSelected = false;
                          });
                        },
                        //child: Container(color: const Color.fromARGB(255, 4, 255, 0).withOpacity(0.3)),
                      ),
                    ),

                  // **ZONA ORIGINAL DE OBLICUOS**
                  if (_showFrontal)
                    Positioned(
                      top: 178,
                      left: 0,
                      width: 100,
                      height: 35,
                      child: GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          setState(() {
                            _sistemaMuscularSelected = false;
                            _hombrosSelected = false;
                            _bicepsSelected = false;
                            _oblicuosSelected = true;
                            _aductoresSelected = false;
                            _tibiaAnteriorSelected = false;
                            _pectoralesSelected = false;
                            _abdomenSelected = false;
                            _antebrazoSelected = false;
                            _cuadricepsSelected = false;
                            _cardioFSelected = false;

                            _tricepsSelected = false;
                            _lumbaresSelected = false;
                            _isquitibialesSelected = false;
                            _pantorrillasSelected = false;
                            _trapeciosSelected = false;
                            _dorsalesSelected = false;
                            _gluteosSelected = false;
                            _cardioTSelected = false;
                          });
                        },
                        //child: Container(color: const Color.fromARGB(255, 4, 255, 0).withOpacity(0.3)),
                      ),
                    ),

                    // **ZONA ORIGINAL DE ADUCTORES**
                    if (_showFrontal)
                    Positioned(
                      top: 315,
                      left: 0,
                      width: 100,
                      height: 35,
                      child: GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          setState(() {
                            _sistemaMuscularSelected = false;
                            _hombrosSelected = false;
                            _bicepsSelected = false;
                            _oblicuosSelected = false;
                            _aductoresSelected = true;
                            _tibiaAnteriorSelected = false;
                            _pectoralesSelected = false;
                            _abdomenSelected = false;
                            _antebrazoSelected = false;
                            _cuadricepsSelected = false;
                            _cardioFSelected = false;

                            _tricepsSelected = false;
                            _lumbaresSelected = false;
                            _isquitibialesSelected = false;
                            _pantorrillasSelected = false;
                            _trapeciosSelected = false;
                            _dorsalesSelected = false;
                            _gluteosSelected = false;
                            _cardioTSelected = false;
                          });
                        },
                        //child: Container(color: const Color.fromARGB(255, 4, 255, 0).withOpacity(0.3)),
                      ),
                    ),

                    // **ZONA ORIGINAL DE TIBIA ANTERIOR**
                    if (_showFrontal)
                    Positioned(
                      top: 395,
                      left: 0,
                      width: 100,
                      height: 35,
                      child: GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          setState(() {
                            _sistemaMuscularSelected = false;
                            _hombrosSelected = false;
                            _bicepsSelected = false;
                            _oblicuosSelected = false;
                            _aductoresSelected = false;
                            _tibiaAnteriorSelected = true;
                            _pectoralesSelected = false;
                            _abdomenSelected = false;
                            _antebrazoSelected = false;
                            _cuadricepsSelected = false;
                            _cardioFSelected = false;

                            _tricepsSelected = false;
                            _lumbaresSelected = false;
                            _isquitibialesSelected = false;
                            _pantorrillasSelected = false;
                            _trapeciosSelected = false;
                            _dorsalesSelected = false;
                            _gluteosSelected = false;
                            _cardioTSelected = false;
                          });
                        },
                        //child: Container(color: const Color.fromARGB(255, 4, 255, 0).withOpacity(0.3)),
                      ),
                    ),

                    // **ZONA ORIGINAL DE PECTORALES**
                    if (_showFrontal)
                    Positioned(
                      top: 60,
                      left: 191,
                      width: 100,
                      height: 35,
                      child: GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          setState(() {
                            _sistemaMuscularSelected = false;
                            _hombrosSelected = false;
                            _bicepsSelected = false;
                            _oblicuosSelected = false;
                            _aductoresSelected = false;
                            _tibiaAnteriorSelected = false;
                            _pectoralesSelected = true;
                            _abdomenSelected = false;
                            _antebrazoSelected = false;
                            _cuadricepsSelected = false;
                            _cardioFSelected = false;

                            _tricepsSelected = false;
                            _lumbaresSelected = false;
                            _isquitibialesSelected = false;
                            _pantorrillasSelected = false;
                            _trapeciosSelected = false;
                            _dorsalesSelected = false;
                            _gluteosSelected = false;
                            _cardioTSelected = false;
                          });
                        },
                        //child: Container(color: const Color.fromARGB(255, 4, 255, 0).withOpacity(0.3)),
                      ),
                    ),

                    // **ZONA ORIGINAL DE ABDOMEN**
                    if (_showFrontal)
                    Positioned(
                      top: 125,
                      left: 191,
                      width: 100,
                      height: 35,
                      child: GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          setState(() {
                            _sistemaMuscularSelected = false;
                            _hombrosSelected = false;
                            _bicepsSelected = false;
                            _oblicuosSelected = false;
                            _aductoresSelected = false;
                            _tibiaAnteriorSelected = false;
                            _pectoralesSelected = false;
                            _abdomenSelected = true;
                            _antebrazoSelected = false;
                            _cuadricepsSelected = false;
                            _cardioFSelected = false;

                            _tricepsSelected = false;
                            _lumbaresSelected = false;
                            _isquitibialesSelected = false;
                            _pantorrillasSelected = false;
                            _trapeciosSelected = false;
                            _dorsalesSelected = false;
                            _gluteosSelected = false;
                            _cardioTSelected = false;
                          });
                        },
                        //child: Container(color: const Color.fromARGB(255, 4, 255, 0).withOpacity(0.3)),
                      ),
                    ),

                    // **ZONA ORIGINAL DE ANTEBRAZO**
                    if (_showFrontal)
                    Positioned(
                      top: 292,
                      left: 191,
                      width: 100,
                      height: 35,
                      child: GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          setState(() {
                            _sistemaMuscularSelected = false;
                            _hombrosSelected = false;
                            _bicepsSelected = false;
                            _oblicuosSelected = false;
                            _aductoresSelected = false;
                            _tibiaAnteriorSelected = false;
                            _pectoralesSelected = false;
                            _abdomenSelected = false;
                            _antebrazoSelected = true;
                            _cuadricepsSelected = false;
                            _cardioFSelected = false;

                            _tricepsSelected = false;
                            _lumbaresSelected = false;
                            _isquitibialesSelected = false;
                            _pantorrillasSelected = false;
                            _trapeciosSelected = false;
                            _dorsalesSelected = false;
                            _gluteosSelected = false;
                            _cardioTSelected = false;
                          });
                        },
                        //child: Container(color: const Color.fromARGB(255, 4, 255, 0).withOpacity(0.3)),
                      ),
                    ),

                    // **ZONA ORIGINAL DE CUADRICEPS**
                    if (_showFrontal)
                    Positioned(
                      top: 358,
                      left: 191,
                      width: 100,
                      height: 35,
                      child: GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          setState(() {
                            _sistemaMuscularSelected = false;
                            _hombrosSelected = false;
                            _bicepsSelected = false;
                            _oblicuosSelected = false;
                            _aductoresSelected = false;
                            _tibiaAnteriorSelected = false;
                            _pectoralesSelected = false;
                            _abdomenSelected = false;
                            _antebrazoSelected = false;
                            _cuadricepsSelected = true;
                            _cardioFSelected = false;

                            _tricepsSelected = false;
                            _lumbaresSelected = false;
                            _isquitibialesSelected = false;
                            _pantorrillasSelected = false;
                            _trapeciosSelected = false;
                            _dorsalesSelected = false;
                            _gluteosSelected = false;
                            _cardioTSelected = false;
                          });
                        },
                        //child: Container(color: const Color.fromARGB(255, 4, 255, 0).withOpacity(0.3)),
                      ),
                    ),

                    // **ZONA ORIGINAL DE CARDIO FRONTAL**
                    if (_showFrontal)
                    Positioned(
                      top: 440,
                      left: 198,
                      width: 80,
                      height: 35,
                      child: GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          setState(() {
                            _sistemaMuscularSelected = false;
                            _hombrosSelected = false;
                            _bicepsSelected = false;
                            _oblicuosSelected = false;
                            _aductoresSelected = false;
                            _tibiaAnteriorSelected = false;
                            _pectoralesSelected = false;
                            _abdomenSelected = false;
                            _antebrazoSelected = false;
                            _cuadricepsSelected = false;
                            _cardioFSelected = true;

                            _tricepsSelected = false;
                            _lumbaresSelected = false;
                            _isquitibialesSelected = false;
                            _pantorrillasSelected = false;
                            _trapeciosSelected = false;
                            _dorsalesSelected = false;
                            _gluteosSelected = false;
                            _cardioTSelected = false;
                          });
                        },
                        //child: Container(color: const Color.fromARGB(255, 4, 255, 0).withOpacity(0.3)),
                      ),
                    ),

                    //TRASERA
                    // **ZONA ORIGINAL DE TRICEPS**
                    if (!_showFrontal)
                    Positioned(
                      top: 89,
                      left: 0,
                      width: 100,
                      height: 35,
                      child: GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          setState(() {
                            _sistemaMuscularSelected = false;
                            _hombrosSelected = false;
                            _bicepsSelected = false;
                            _oblicuosSelected = false;
                            _aductoresSelected = false;
                            _tibiaAnteriorSelected = false;
                            _pectoralesSelected = false;
                            _abdomenSelected = false;
                            _antebrazoSelected = false;
                            _cuadricepsSelected = false;
                            _cardioFSelected = false;

                            _sistemaMuscularSelected = false;
                            _tricepsSelected = true;
                            _lumbaresSelected = false;
                            _isquitibialesSelected = false;
                            _pantorrillasSelected = false;
                            _trapeciosSelected = false;
                            _dorsalesSelected = false;
                            _gluteosSelected = false;
                            _cardioTSelected = false;
                          });
                        },
                        //child: Container(color: const Color.fromARGB(255, 4, 255, 0).withOpacity(0.3)),
                      ),
                    ),

                    // **ZONA ORIGINAL DE LUMBARES**
                    if (!_showFrontal)
                    Positioned(
                      top: 160,
                      left: 0,
                      width: 100,
                      height: 35,
                      child: GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          setState(() {
                            _sistemaMuscularSelected = false;
                            _hombrosSelected = false;
                            _bicepsSelected = false;
                            _oblicuosSelected = false;
                            _aductoresSelected = false;
                            _tibiaAnteriorSelected = false;
                            _pectoralesSelected = false;
                            _abdomenSelected = false;
                            _antebrazoSelected = false;
                            _cuadricepsSelected = false;
                            _cardioFSelected = false;

                            _tricepsSelected = false;
                            _lumbaresSelected = true;
                            _isquitibialesSelected = false;
                            _pantorrillasSelected = false;
                            _trapeciosSelected = false;
                            _dorsalesSelected = false;
                            _gluteosSelected = false;
                            _cardioTSelected = false;
                          });
                        },
                        //child: Container(color: const Color.fromARGB(255, 4, 255, 0).withOpacity(0.3)),
                      ),
                    ),

                    // **ZONA ORIGINAL DE ISQUIOTIBIALES**
                    if (!_showFrontal)
                    Positioned(
                      top: 310,
                      left: 0,
                      width: 100,
                      height: 35,
                      child: GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          setState(() {
                            _sistemaMuscularSelected = false;
                            _hombrosSelected = false;
                            _bicepsSelected = false;
                            _oblicuosSelected = false;
                            _aductoresSelected = false;
                            _tibiaAnteriorSelected = false;
                            _pectoralesSelected = false;
                            _abdomenSelected = false;
                            _antebrazoSelected = false;
                            _cuadricepsSelected = false;
                            _cardioFSelected = false;

                            _tricepsSelected = false;
                            _lumbaresSelected = false;
                            _isquitibialesSelected = true;
                            _pantorrillasSelected = false;
                            _trapeciosSelected = false;
                            _dorsalesSelected = false;
                            _gluteosSelected = false;
                            _cardioTSelected = false;
                          });
                        },
                        //child: Container(color: const Color.fromARGB(255, 4, 255, 0).withOpacity(0.3)),
                      ),
                    ),

                    // **ZONA ORIGINAL DE PANTORRILLAS**
                    if (!_showFrontal)
                    Positioned(
                      top: 380,
                      left: 0,
                      width: 100,
                      height: 35,
                      child: GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          setState(() {
                            _sistemaMuscularSelected = false;
                            _hombrosSelected = false;
                            _bicepsSelected = false;
                            _oblicuosSelected = false;
                            _aductoresSelected = false;
                            _tibiaAnteriorSelected = false;
                            _pectoralesSelected = false;
                            _abdomenSelected = false;
                            _antebrazoSelected = false;
                            _cuadricepsSelected = false;
                            _cardioFSelected = false;

                            _tricepsSelected = false;
                            _lumbaresSelected = false;
                            _isquitibialesSelected = false;
                            _pantorrillasSelected = true;
                            _trapeciosSelected = false;
                            _dorsalesSelected = false;
                            _gluteosSelected = false;
                            _cardioTSelected = false;
                          });
                        },
                        //child: Container(color: const Color.fromARGB(255, 4, 255, 0).withOpacity(0.3)),
                      ),
                    ),

                    // **ZONA ORIGINAL DE TRAPECIO**
                    if (!_showFrontal)
                    Positioned(
                      top: 88,
                      left: 191,
                      width: 100,
                      height: 35,
                      child: GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          setState(() {
                            _sistemaMuscularSelected = false;
                            _hombrosSelected = false;
                            _bicepsSelected = false;
                            _oblicuosSelected = false;
                            _aductoresSelected = false;
                            _tibiaAnteriorSelected = false;
                            _pectoralesSelected = false;
                            _abdomenSelected = false;
                            _antebrazoSelected = false;
                            _cuadricepsSelected = false;
                            _cardioFSelected = false;

                            _tricepsSelected = false;
                            _lumbaresSelected = false;
                            _isquitibialesSelected = false;
                            _pantorrillasSelected = false;
                            _trapeciosSelected = true;
                            _dorsalesSelected = false;
                            _gluteosSelected = false;
                            _cardioTSelected = false;
                          });
                        },
                        //child: Container(color: const Color.fromARGB(255, 4, 255, 0).withOpacity(0.3)),
                      ),
                    ),

                    // **ZONA ORIGINAL DE DORSALES**
                    if (!_showFrontal)
                    Positioned(
                      top: 150,
                      left: 191,
                      width: 100,
                      height: 35,
                      child: GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          setState(() {
                            _sistemaMuscularSelected = false;
                            _hombrosSelected = false;
                            _bicepsSelected = false;
                            _oblicuosSelected = false;
                            _aductoresSelected = false;
                            _tibiaAnteriorSelected = false;
                            _pectoralesSelected = false;
                            _abdomenSelected = false;
                            _antebrazoSelected = false;
                            _cuadricepsSelected = false;
                            _cardioFSelected = false;

                            _tricepsSelected = false;
                            _lumbaresSelected = false;
                            _isquitibialesSelected = false;
                            _pantorrillasSelected = false;
                            _trapeciosSelected = false;
                            _dorsalesSelected = true;
                            _gluteosSelected = false;
                            _cardioTSelected = false;
                          });
                        },
                        //child: Container(color: const Color.fromARGB(255, 4, 255, 0).withOpacity(0.3)),
                      ),
                    ),

                    // **ZONA ORIGINAL DE GLUTEOS**
                    if (!_showFrontal)
                    Positioned(
                      top: 320,
                      left: 191,
                      width: 100,
                      height: 35,
                      child: GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          setState(() {
                            _sistemaMuscularSelected = false;
                            _hombrosSelected = false;
                            _bicepsSelected = false;
                            _oblicuosSelected = false;
                            _aductoresSelected = false;
                            _tibiaAnteriorSelected = false;
                            _pectoralesSelected = false;
                            _abdomenSelected = false;
                            _antebrazoSelected = false;
                            _cuadricepsSelected = false;
                            _cardioFSelected = false;

                            _tricepsSelected = false;
                            _lumbaresSelected = false;
                            _isquitibialesSelected = false;
                            _pantorrillasSelected = false;
                            _trapeciosSelected = false;
                            _dorsalesSelected = false;
                            _gluteosSelected = true;
                            _cardioTSelected = false;
                          });
                        },
                        //child: Container(color: const Color.fromARGB(255, 4, 255, 0).withOpacity(0.3)),
                      ),
                    ),

                    // **ZONA ORIGINAL DE CARDIO TRASERO**
                    if (!_showFrontal)
                    Positioned(
                      top: 440,
                      left: 198,
                      width: 80,
                      height: 35,
                      child: GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          setState(() {
                            _sistemaMuscularSelected = false;
                            _hombrosSelected = false;
                            _bicepsSelected = false;
                            _oblicuosSelected = false;
                            _aductoresSelected = false;
                            _tibiaAnteriorSelected = false;
                            _pectoralesSelected = false;
                            _abdomenSelected = false;
                            _antebrazoSelected = false;
                            _cuadricepsSelected = false;
                            _cardioFSelected = false;

                            _tricepsSelected = false;
                            _lumbaresSelected = false;
                            _isquitibialesSelected = false;
                            _pantorrillasSelected = false;
                            _trapeciosSelected = false;
                            _dorsalesSelected = false;
                            _gluteosSelected = false;
                            _cardioTSelected = true;
                          });
                        },
                        //child: Container(color: const Color.fromARGB(255, 4, 255, 0).withOpacity(0.3)),
                      ),
                    ),
                ],
              ),
            ),

            SizedBox(height: 10),

            // — Botón “Cambio” —
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 30, 10),
              child: Align(
                alignment: Alignment.center,
                child: ElevatedButton.icon(
                  onPressed: _toggleView,
                  icon: Icon(
                    Icons.autorenew,
                    color: AppColors.secondary,  // color del icono
                  ),
                  label: Text(
                    "Cambio",
                    style: TextStyle(color: AppColors.secondary),  // color del texto
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.mainBlue,  // color de fondo
                  ),
                ),
              ),
            ),

            // justo después del botón “Cambio”
            if (_sistemaMuscularSelected) 
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 0, 30, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sistema Muscular',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'El sistema muscular es el conjunto de más de 600 músculos y tejidos asociados '
                      'que permiten el movimiento, mantienen la postura y generan calor corporal.',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),

            // FRONTAL
            // — Ejercicios para Hombros —
            if (_hombrosSelected)
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 0, 30, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Ejercicios para Hombros',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                    SizedBox(height: 6),
                    ..._hombrosGifs.entries.map((entry) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            entry.key,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 4),
                          Image.asset(
                            entry.value,
                            width: double.infinity,
                            fit: BoxFit.contain,
                          ),
                          SizedBox(height: 12),
                        ],
                      );
                    }).toList(),
                  ],
                ),
              ),

            // — Ejercicios para Bíceps —
            if (_bicepsSelected)
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 0, 30, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Ejercicios para Biceps',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                    SizedBox(height: 6),
                    ..._bicepsGifs.entries.map((entry) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            entry.key,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 4),
                          Image.asset(
                            entry.value,
                            width: double.infinity,
                            fit: BoxFit.contain,
                          ),
                          SizedBox(height: 12),
                        ],
                      );
                    }).toList(),
                  ],
                ),
              ),

            // — Ejercicios para Oblicuos —
            if (_oblicuosSelected)
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 0, 30, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Ejercicios para Oblicuos',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                    SizedBox(height: 6),
                    ..._oblicuosGifs.entries.map((entry) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            entry.key,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 4),
                          Image.asset(
                            entry.value,
                            width: double.infinity,
                            fit: BoxFit.contain,
                          ),
                          SizedBox(height: 12),
                        ],
                      );
                    }).toList(),
                  ],
                ),
              ),

            // — Ejercicios para Aductores —
            if (_aductoresSelected)
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 0, 30, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Ejercicios para Aductores',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                    SizedBox(height: 6),
                    ..._aductoresGifs.entries.map((entry) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            entry.key,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 4),
                          Image.asset(
                            entry.value,
                            width: double.infinity,
                            fit: BoxFit.contain,
                          ),
                          SizedBox(height: 12),
                        ],
                      );
                    }).toList(),
                  ],
                ),
              ),

            // — Ejercicios para Tibia Anterior —
            if (_tibiaAnteriorSelected)
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 0, 30, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Ejercicios para Tibia Anterior',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                    SizedBox(height: 6),
                    ..._tibiaAnteriorGifs.entries.map((entry) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            entry.key,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 4),
                          Image.asset(
                            entry.value,
                            width: double.infinity,
                            fit: BoxFit.contain,
                          ),
                          SizedBox(height: 12),
                        ],
                      );
                    }).toList(),
                  ],
                ),
              ),

            // — Ejercicios para Pectorales —
            if (_pectoralesSelected)
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 0, 30, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Ejercicios para Pectorales',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                    SizedBox(height: 6),
                    ..._pectoralesGifs.entries.map((entry) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            entry.key,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 4),
                          Image.asset(
                            entry.value,
                            width: double.infinity,
                            fit: BoxFit.contain,
                          ),
                          SizedBox(height: 12),
                        ],
                      );
                    }).toList(),
                  ],
                ),
              ),


              // — Ejercicios para Abdomen —
              if (_abdomenSelected)
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 0, 30, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Ejercicios para Abdomen',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                    SizedBox(height: 6),
                    // Para cada ejercicio: título + GIF
                    ..._abdomenGifs.entries.map((entry) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            entry.key,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 4),
                          // GIF animado
                          Image.asset(
                            entry.value,
                            width: double.infinity,
                            fit: BoxFit.contain,
                          ),
                          SizedBox(height: 12),
                        ],
                      );
                    }).toList(),
                  ],
                ),
              ),

              // — Ejercicios para Antebrazo —
              if (_antebrazoSelected)
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Ejercicios para Antebrazo',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                      SizedBox(height: 6),
                      ..._antebrazoGifs.entries.map((entry) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              entry.key,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 4),
                            Image.asset(
                              entry.value,
                              width: double.infinity,
                              fit: BoxFit.contain,
                            ),
                            SizedBox(height: 12),
                          ],
                        );
                      }).toList(),
                    ],
                  ),
                ),

              // — Ejercicios para Cuadriceps —
              if (_cuadricepsSelected)
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Ejercicios para Cuadriceps',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                      SizedBox(height: 6),
                      ..._cuadricepsGifs.entries.map((entry) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              entry.key,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 4),
                            Image.asset(
                              entry.value,
                              width: double.infinity,
                              fit: BoxFit.contain,
                            ),
                            SizedBox(height: 12),
                          ],
                        );
                      }).toList(),
                    ],
                  ),
                ),

              // — Ejercicios para Cardio —
              if (_cardioFSelected)
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Ejercicios para Cardio',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                      SizedBox(height: 6),
                      ..._cardioGifs.entries.map((entry) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              entry.key,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 4),
                            Image.asset(
                              entry.value,
                              width: double.infinity,
                              fit: BoxFit.contain,
                            ),
                            SizedBox(height: 12),
                          ],
                        );
                      }).toList(),
                    ],
                  ),
                ),

              // — Ejercicios para Triceps —
              if (_tricepsSelected)
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Ejercicios para Triceps',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                      SizedBox(height: 6),
                      ..._tricepsGifs.entries.map((entry) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              entry.key,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 4),
                            Image.asset(
                              entry.value,
                              width: double.infinity,
                              fit: BoxFit.contain,
                            ),
                            SizedBox(height: 12),
                          ],
                        );
                      }).toList(),
                    ],
                  ),
                ),

              // — Ejercicios para Lumbares —
              if (_lumbaresSelected)
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Ejercicios para Lumbares',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                      SizedBox(height: 6),
                      ..._lumbaresGifs.entries.map((entry) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              entry.key,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 4),
                            Image.asset(
                              entry.value,
                              width: double.infinity,
                              fit: BoxFit.contain,
                            ),
                            SizedBox(height: 12),
                          ],
                        );
                      }).toList(),
                    ],
                  ),
                ),

              // — Ejercicios para Isquitibiales —
              if (_isquitibialesSelected)
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Ejercicios para Isquiotibiales',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                      SizedBox(height: 6),
                      ..._isquiotibialesGifs.entries.map((entry) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              entry.key,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 4),
                            Image.asset(
                              entry.value,
                              width: double.infinity,
                              fit: BoxFit.contain,
                            ),
                            SizedBox(height: 12),
                          ],
                        );
                      }).toList(),
                    ],
                  ),
                ),

              // — Ejercicios para Pantorrillas —
              if (_pantorrillasSelected)
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Ejercicios para Pantorrillas',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                      SizedBox(height: 6),
                      ..._pantorrillasGifs.entries.map((entry) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              entry.key,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 4),
                            Image.asset(
                              entry.value,
                              width: double.infinity,
                              fit: BoxFit.contain,
                            ),
                            SizedBox(height: 12),
                          ],
                        );
                      }).toList(),
                    ],
                  ),
                ),

              // — Ejercicios para Trapecio —
              if (_trapeciosSelected)
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Ejercicios para Trapecio',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                      SizedBox(height: 6),
                      ..._trapecioGifs.entries.map((entry) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              entry.key,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 4),
                            Image.asset(
                              entry.value,
                              width: double.infinity,
                              fit: BoxFit.contain,
                            ),
                            SizedBox(height: 12),
                          ],
                        );
                      }).toList(),
                    ],
                  ),
                ),

              // — Ejercicios para Dorsales —
              if (_dorsalesSelected)
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Ejercicios para Dorsales',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                      SizedBox(height: 6),
                      ..._dorsalesGifs.entries.map((entry) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              entry.key,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 4),
                            Image.asset(
                              entry.value,
                              width: double.infinity,
                              fit: BoxFit.contain,
                            ),
                            SizedBox(height: 12),
                          ],
                        );
                      }).toList(),
                    ],
                  ),
                ),

              // — Ejercicios para Gluteos —
              if (_gluteosSelected)
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Ejercicios para Gluteos',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                      SizedBox(height: 6),
                      ..._gluteosGifs.entries.map((entry) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              entry.key,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 4),
                            Image.asset(
                              entry.value,
                              width: double.infinity,
                              fit: BoxFit.contain,
                            ),
                            SizedBox(height: 12),
                          ],
                        );
                      }).toList(),
                    ],
                  ),
                ),

              // — Ejercicios para Cardio —
              if (_cardioTSelected || _cardioFSelected)
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Ejercicios para Cardio',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                      SizedBox(height: 6),
                      ..._cardioGifs.entries.map((entry) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              entry.key,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 4),
                            Image.asset(
                              entry.value,
                              width: double.infinity,
                              fit: BoxFit.contain,
                            ),
                            SizedBox(height: 12),
                          ],
                        );
                      }).toList(),
                    ],
                  ),
                ),

          ],
        ),
      ),
    );
  }
}

/* // FRONTAL
                  // **ZONA ORIGINAL DE HOMBROS**
                  if (_showFrontal)
                    Positioned(
                      top: 75,
                      left: 0,
                      width: 100,
                      height: 35,
                      child: GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          setState(() {
                            _sistemaMuscularSelected = false;
                            _hombrosSelected = true;
                            _bicepsSelected = false;
                            _oblicuosSelected = false;
                            _aductoresSelected = false;
                            _tibiaAnteriorSelected = false;
                            _pectoralesSelected = false;
                            _abdomenSelected = false;
                            _antebrazoSelected = false;
                            _cuadricepsSelected = false;
                            _cardioFSelected = false;

                            _tricepsSelected = false;
                            _lumbaresSelected = false;
                            _isquitibialesSelected = false;
                            _pantorrillasSelected = false;
                            _trapeciosSelected = false;
                            _dorsalesSelected = false;
                            _gluteosSelected = false;
                            _cardioTSelected = false;
                          });
                        },
                        //child: Container(color: const Color.fromARGB(255, 4, 255, 0).withOpacity(0.3)),
                      ),
                    ),

                  // **ZONA ORIGINAL DE BÍCEPS**
                  if (_showFrontal)
                    Positioned(
                      top: 147,
                      left: 0,
                      width: 100,
                      height: 35,
                      child: GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          setState(() {
                            _sistemaMuscularSelected = false;
                            _hombrosSelected = false;
                            _bicepsSelected = true;
                            _oblicuosSelected = false;
                            _aductoresSelected = false;
                            _tibiaAnteriorSelected = false;
                            _pectoralesSelected = false;
                            _abdomenSelected = false;
                            _antebrazoSelected = false;
                            _cuadricepsSelected = false;
                            _cardioFSelected = false;

                            _tricepsSelected = false;
                            _lumbaresSelected = false;
                            _isquitibialesSelected = false;
                            _pantorrillasSelected = false;
                            _trapeciosSelected = false;
                            _dorsalesSelected = false;
                            _gluteosSelected = false;
                            _cardioTSelected = false;
                          });
                        },
                        //child: Container(color: const Color.fromARGB(255, 4, 255, 0).withOpacity(0.3)),
                      ),
                    ),

                  // **ZONA ORIGINAL DE OBLICUOS**
                  if (_showFrontal)
                    Positioned(
                      top: 220,
                      left: 0,
                      width: 100,
                      height: 35,
                      child: GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          setState(() {
                            _sistemaMuscularSelected = false;
                            _hombrosSelected = false;
                            _bicepsSelected = false;
                            _oblicuosSelected = true;
                            _aductoresSelected = false;
                            _tibiaAnteriorSelected = false;
                            _pectoralesSelected = false;
                            _abdomenSelected = false;
                            _antebrazoSelected = false;
                            _cuadricepsSelected = false;
                            _cardioFSelected = false;

                            _tricepsSelected = false;
                            _lumbaresSelected = false;
                            _isquitibialesSelected = false;
                            _pantorrillasSelected = false;
                            _trapeciosSelected = false;
                            _dorsalesSelected = false;
                            _gluteosSelected = false;
                            _cardioTSelected = false;
                          });
                        },
                        //child: Container(color: const Color.fromARGB(255, 4, 255, 0).withOpacity(0.3)),
                      ),
                    ),

                    // **ZONA ORIGINAL DE ADUCTORES**
                    if (_showFrontal)
                    Positioned(
                      top: 385,
                      left: 0,
                      width: 100,
                      height: 35,
                      child: GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          setState(() {
                            _sistemaMuscularSelected = false;
                            _hombrosSelected = false;
                            _bicepsSelected = false;
                            _oblicuosSelected = false;
                            _aductoresSelected = true;
                            _tibiaAnteriorSelected = false;
                            _pectoralesSelected = false;
                            _abdomenSelected = false;
                            _antebrazoSelected = false;
                            _cuadricepsSelected = false;
                            _cardioFSelected = false;

                            _tricepsSelected = false;
                            _lumbaresSelected = false;
                            _isquitibialesSelected = false;
                            _pantorrillasSelected = false;
                            _trapeciosSelected = false;
                            _dorsalesSelected = false;
                            _gluteosSelected = false;
                            _cardioTSelected = false;
                          });
                        },
                        //child: Container(color: const Color.fromARGB(255, 4, 255, 0).withOpacity(0.3)),
                      ),
                    ),

                    // **ZONA ORIGINAL DE TIBIA ANTERIOR**
                    if (_showFrontal)
                    Positioned(
                      top: 485,
                      left: 0,
                      width: 100,
                      height: 35,
                      child: GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          setState(() {
                            _sistemaMuscularSelected = false;
                            _hombrosSelected = false;
                            _bicepsSelected = false;
                            _oblicuosSelected = false;
                            _aductoresSelected = false;
                            _tibiaAnteriorSelected = true;
                            _pectoralesSelected = false;
                            _abdomenSelected = false;
                            _antebrazoSelected = false;
                            _cuadricepsSelected = false;
                            _cardioFSelected = false;

                            _tricepsSelected = false;
                            _lumbaresSelected = false;
                            _isquitibialesSelected = false;
                            _pantorrillasSelected = false;
                            _trapeciosSelected = false;
                            _dorsalesSelected = false;
                            _gluteosSelected = false;
                            _cardioTSelected = false;
                          });
                        },
                        //child: Container(color: const Color.fromARGB(255, 4, 255, 0).withOpacity(0.3)),
                      ),
                    ),

                    // **ZONA ORIGINAL DE PECTORALES**
                    if (_showFrontal)
                    Positioned(
                      top: 75,
                      left: 249,
                      width: 100,
                      height: 35,
                      child: GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          setState(() {
                            _sistemaMuscularSelected = false;
                            _hombrosSelected = false;
                            _bicepsSelected = false;
                            _oblicuosSelected = false;
                            _aductoresSelected = false;
                            _tibiaAnteriorSelected = false;
                            _pectoralesSelected = true;
                            _abdomenSelected = false;
                            _antebrazoSelected = false;
                            _cuadricepsSelected = false;
                            _cardioFSelected = false;

                            _tricepsSelected = false;
                            _lumbaresSelected = false;
                            _isquitibialesSelected = false;
                            _pantorrillasSelected = false;
                            _trapeciosSelected = false;
                            _dorsalesSelected = false;
                            _gluteosSelected = false;
                            _cardioTSelected = false;
                          });
                        },
                        //child: Container(color: const Color.fromARGB(255, 4, 255, 0).withOpacity(0.3)),
                      ),
                    ),

                    // **ZONA ORIGINAL DE ABDOMEN**
                    if (_showFrontal)
                    Positioned(
                      top: 153,
                      left: 249,
                      width: 100,
                      height: 35,
                      child: GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          setState(() {
                            _sistemaMuscularSelected = false;
                            _hombrosSelected = false;
                            _bicepsSelected = false;
                            _oblicuosSelected = false;
                            _aductoresSelected = false;
                            _tibiaAnteriorSelected = false;
                            _pectoralesSelected = false;
                            _abdomenSelected = true;
                            _antebrazoSelected = false;
                            _cuadricepsSelected = false;
                            _cardioFSelected = false;

                            _tricepsSelected = false;
                            _lumbaresSelected = false;
                            _isquitibialesSelected = false;
                            _pantorrillasSelected = false;
                            _trapeciosSelected = false;
                            _dorsalesSelected = false;
                            _gluteosSelected = false;
                            _cardioTSelected = false;
                          });
                        },
                        //child: Container(color: const Color.fromARGB(255, 4, 255, 0).withOpacity(0.3)),
                      ),
                    ),

                    // **ZONA ORIGINAL DE ANTEBRAZO**
                    if (_showFrontal)
                    Positioned(
                      top: 353,
                      left: 249,
                      width: 100,
                      height: 35,
                      child: GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          setState(() {
                            _sistemaMuscularSelected = false;
                            _hombrosSelected = false;
                            _bicepsSelected = false;
                            _oblicuosSelected = false;
                            _aductoresSelected = false;
                            _tibiaAnteriorSelected = false;
                            _pectoralesSelected = false;
                            _abdomenSelected = false;
                            _antebrazoSelected = true;
                            _cuadricepsSelected = false;
                            _cardioFSelected = false;

                            _tricepsSelected = false;
                            _lumbaresSelected = false;
                            _isquitibialesSelected = false;
                            _pantorrillasSelected = false;
                            _trapeciosSelected = false;
                            _dorsalesSelected = false;
                            _gluteosSelected = false;
                            _cardioTSelected = false;
                          });
                        },
                        //child: Container(color: const Color.fromARGB(255, 4, 255, 0).withOpacity(0.3)),
                      ),
                    ),

                    // **ZONA ORIGINAL DE CUADRICEPS**
                    if (_showFrontal)
                    Positioned(
                      top: 435,
                      left: 249,
                      width: 100,
                      height: 35,
                      child: GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          setState(() {
                            _sistemaMuscularSelected = false;
                            _hombrosSelected = false;
                            _bicepsSelected = false;
                            _oblicuosSelected = false;
                            _aductoresSelected = false;
                            _tibiaAnteriorSelected = false;
                            _pectoralesSelected = false;
                            _abdomenSelected = false;
                            _antebrazoSelected = false;
                            _cuadricepsSelected = true;
                            _cardioFSelected = false;

                            _tricepsSelected = false;
                            _lumbaresSelected = false;
                            _isquitibialesSelected = false;
                            _pantorrillasSelected = false;
                            _trapeciosSelected = false;
                            _dorsalesSelected = false;
                            _gluteosSelected = false;
                            _cardioTSelected = false;
                          });
                        },
                        //child: Container(color: const Color.fromARGB(255, 4, 255, 0).withOpacity(0.3)),
                      ),
                    ),

                    // **ZONA ORIGINAL DE CARDIO FRONTAL**
                    if (_showFrontal)
                    Positioned(
                      top: 533,
                      left: 245,
                      width: 80,
                      height: 35,
                      child: GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          setState(() {
                            _sistemaMuscularSelected = false;
                            _hombrosSelected = false;
                            _bicepsSelected = false;
                            _oblicuosSelected = false;
                            _aductoresSelected = false;
                            _tibiaAnteriorSelected = false;
                            _pectoralesSelected = false;
                            _abdomenSelected = false;
                            _antebrazoSelected = false;
                            _cuadricepsSelected = false;
                            _cardioFSelected = true;

                            _tricepsSelected = false;
                            _lumbaresSelected = false;
                            _isquitibialesSelected = false;
                            _pantorrillasSelected = false;
                            _trapeciosSelected = false;
                            _dorsalesSelected = false;
                            _gluteosSelected = false;
                            _cardioTSelected = false;
                          });
                        },
                        //child: Container(color: const Color.fromARGB(255, 4, 255, 0).withOpacity(0.3)),
                      ),
                    ),

                    //TRASERA
                    // **ZONA ORIGINAL DE TRICEPS**
                    if (!_showFrontal)
                    Positioned(
                      top: 113,
                      left: 0,
                      width: 100,
                      height: 35,
                      child: GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          setState(() {
                            _sistemaMuscularSelected = false;
                            _hombrosSelected = false;
                            _bicepsSelected = false;
                            _oblicuosSelected = false;
                            _aductoresSelected = false;
                            _tibiaAnteriorSelected = false;
                            _pectoralesSelected = false;
                            _abdomenSelected = false;
                            _antebrazoSelected = false;
                            _cuadricepsSelected = false;
                            _cardioFSelected = false;

                            _sistemaMuscularSelected = false;
                            _tricepsSelected = true;
                            _lumbaresSelected = false;
                            _isquitibialesSelected = false;
                            _pantorrillasSelected = false;
                            _trapeciosSelected = false;
                            _dorsalesSelected = false;
                            _gluteosSelected = false;
                            _cardioTSelected = false;
                          });
                        },
                        //child: Container(color: const Color.fromARGB(255, 4, 255, 0).withOpacity(0.3)),
                      ),
                    ),

                    // **ZONA ORIGINAL DE LUMBARES**
                    if (!_showFrontal)
                    Positioned(
                      top: 195,
                      left: 0,
                      width: 100,
                      height: 35,
                      child: GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          setState(() {
                            _sistemaMuscularSelected = false;
                            _hombrosSelected = false;
                            _bicepsSelected = false;
                            _oblicuosSelected = false;
                            _aductoresSelected = false;
                            _tibiaAnteriorSelected = false;
                            _pectoralesSelected = false;
                            _abdomenSelected = false;
                            _antebrazoSelected = false;
                            _cuadricepsSelected = false;
                            _cardioFSelected = false;

                            _tricepsSelected = false;
                            _lumbaresSelected = true;
                            _isquitibialesSelected = false;
                            _pantorrillasSelected = false;
                            _trapeciosSelected = false;
                            _dorsalesSelected = false;
                            _gluteosSelected = false;
                            _cardioTSelected = false;
                          });
                        },
                        //child: Container(color: const Color.fromARGB(255, 4, 255, 0).withOpacity(0.3)),
                      ),
                    ),

                    // **ZONA ORIGINAL DE ISQUIOTIBIALES**
                    if (!_showFrontal)
                    Positioned(
                      top: 375,
                      left: 0,
                      width: 100,
                      height: 35,
                      child: GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          setState(() {
                            _sistemaMuscularSelected = false;
                            _hombrosSelected = false;
                            _bicepsSelected = false;
                            _oblicuosSelected = false;
                            _aductoresSelected = false;
                            _tibiaAnteriorSelected = false;
                            _pectoralesSelected = false;
                            _abdomenSelected = false;
                            _antebrazoSelected = false;
                            _cuadricepsSelected = false;
                            _cardioFSelected = false;

                            _tricepsSelected = false;
                            _lumbaresSelected = false;
                            _isquitibialesSelected = true;
                            _pantorrillasSelected = false;
                            _trapeciosSelected = false;
                            _dorsalesSelected = false;
                            _gluteosSelected = false;
                            _cardioTSelected = false;
                          });
                        },
                        //child: Container(color: const Color.fromARGB(255, 4, 255, 0).withOpacity(0.3)),
                      ),
                    ),

                    // **ZONA ORIGINAL DE PANTORRILLAS**
                    if (!_showFrontal)
                    Positioned(
                      top: 465,
                      left: 0,
                      width: 100,
                      height: 35,
                      child: GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          setState(() {
                            _sistemaMuscularSelected = false;
                            _hombrosSelected = false;
                            _bicepsSelected = false;
                            _oblicuosSelected = false;
                            _aductoresSelected = false;
                            _tibiaAnteriorSelected = false;
                            _pectoralesSelected = false;
                            _abdomenSelected = false;
                            _antebrazoSelected = false;
                            _cuadricepsSelected = false;
                            _cardioFSelected = false;

                            _tricepsSelected = false;
                            _lumbaresSelected = false;
                            _isquitibialesSelected = false;
                            _pantorrillasSelected = true;
                            _trapeciosSelected = false;
                            _dorsalesSelected = false;
                            _gluteosSelected = false;
                            _cardioTSelected = false;
                          });
                        },
                        //child: Container(color: const Color.fromARGB(255, 4, 255, 0).withOpacity(0.3)),
                      ),
                    ),

                    // **ZONA ORIGINAL DE TRAPECIO**
                    if (!_showFrontal)
                    Positioned(
                      top: 110,
                      left: 250,
                      width: 100,
                      height: 35,
                      child: GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          setState(() {
                            _sistemaMuscularSelected = false;
                            _hombrosSelected = false;
                            _bicepsSelected = false;
                            _oblicuosSelected = false;
                            _aductoresSelected = false;
                            _tibiaAnteriorSelected = false;
                            _pectoralesSelected = false;
                            _abdomenSelected = false;
                            _antebrazoSelected = false;
                            _cuadricepsSelected = false;
                            _cardioFSelected = false;

                            _tricepsSelected = false;
                            _lumbaresSelected = false;
                            _isquitibialesSelected = false;
                            _pantorrillasSelected = false;
                            _trapeciosSelected = true;
                            _dorsalesSelected = false;
                            _gluteosSelected = false;
                            _cardioTSelected = false;
                          });
                        },
                        //child: Container(color: const Color.fromARGB(255, 4, 255, 0).withOpacity(0.3)),
                      ),
                    ),

                    // **ZONA ORIGINAL DE DORSALES**
                    if (!_showFrontal)
                    Positioned(
                      top: 183,
                      left: 250,
                      width: 100,
                      height: 35,
                      child: GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          setState(() {
                            _sistemaMuscularSelected = false;
                            _hombrosSelected = false;
                            _bicepsSelected = false;
                            _oblicuosSelected = false;
                            _aductoresSelected = false;
                            _tibiaAnteriorSelected = false;
                            _pectoralesSelected = false;
                            _abdomenSelected = false;
                            _antebrazoSelected = false;
                            _cuadricepsSelected = false;
                            _cardioFSelected = false;

                            _tricepsSelected = false;
                            _lumbaresSelected = false;
                            _isquitibialesSelected = false;
                            _pantorrillasSelected = false;
                            _trapeciosSelected = false;
                            _dorsalesSelected = true;
                            _gluteosSelected = false;
                            _cardioTSelected = false;
                          });
                        },
                        //child: Container(color: const Color.fromARGB(255, 4, 255, 0).withOpacity(0.3)),
                      ),
                    ),

                    // **ZONA ORIGINAL DE GLUTEOS**
                    if (!_showFrontal)
                    Positioned(
                      top: 393,
                      left: 250,
                      width: 100,
                      height: 35,
                      child: GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          setState(() {
                            _sistemaMuscularSelected = false;
                            _hombrosSelected = false;
                            _bicepsSelected = false;
                            _oblicuosSelected = false;
                            _aductoresSelected = false;
                            _tibiaAnteriorSelected = false;
                            _pectoralesSelected = false;
                            _abdomenSelected = false;
                            _antebrazoSelected = false;
                            _cuadricepsSelected = false;
                            _cardioFSelected = false;

                            _tricepsSelected = false;
                            _lumbaresSelected = false;
                            _isquitibialesSelected = false;
                            _pantorrillasSelected = false;
                            _trapeciosSelected = false;
                            _dorsalesSelected = false;
                            _gluteosSelected = true;
                            _cardioTSelected = false;
                          });
                        },
                        //child: Container(color: const Color.fromARGB(255, 4, 255, 0).withOpacity(0.3)),
                      ),
                    ),

                    // **ZONA ORIGINAL DE CARDIO TRASERO**
                    if (!_showFrontal)
                    Positioned(
                      top: 533,
                      left: 245,
                      width: 80,
                      height: 35,
                      child: GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          setState(() {
                            _sistemaMuscularSelected = false;
                            _hombrosSelected = false;
                            _bicepsSelected = false;
                            _oblicuosSelected = false;
                            _aductoresSelected = false;
                            _tibiaAnteriorSelected = false;
                            _pectoralesSelected = false;
                            _abdomenSelected = false;
                            _antebrazoSelected = false;
                            _cuadricepsSelected = false;
                            _cardioFSelected = false;

                            _tricepsSelected = false;
                            _lumbaresSelected = false;
                            _isquitibialesSelected = false;
                            _pantorrillasSelected = false;
                            _trapeciosSelected = false;
                            _dorsalesSelected = false;
                            _gluteosSelected = false;
                            _cardioTSelected = true;
                          });
                        },
                        //child: Container(color: const Color.fromARGB(255, 4, 255, 0).withOpacity(0.3)),
                      ),
                    ),*/
