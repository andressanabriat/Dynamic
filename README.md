# Dynamic App

Aplicación de gestión de rutinas de entrenamiento y seguimiento corporal, diseñada para usuarios y centros deportivos. Este proyecto está construido con **Flutter** y utiliza **Firebase** como backend.

---

## Requisitos previos

IMPORTANTE: Cuando se descarga el fichero desde git revisar que la carpeta del proyecto se debe llamar (Flutter Entreno) y dentro dos carpetas (.idea y flutter_application_1) que en flutter_application_1 es donde esta todo el proyecto. 
Antes de ejecutar este proyecto, asegúrate de tener lo siguiente instalado en tu sistema:

### Instalar Flutter y Dart ###

1. Flutter SDK:
   - Descarga e instala Flutter: [https://docs.flutter.dev/get-started/install](https://docs.flutter.dev/get-started/install)
   - Sigue los pasos para agregar Flutter a tu PATH.

2. Verifica la instalación:
   ```bash
   flutter doctor

3. Instalar dependencias:
   flutter pub get

4. Configurar Firebase:
  Importante: Este proyecto utiliza Firebase. Si estás clonando el repositorio, debes configurar tu propio proyecto de Firebase.
  
  Pasos:
  - Ve a https://console.firebase.google.com/ y crea un nuevo proyecto.
  
  - Agrega una aplicación para Android y/o iOS.
  
  - Descarga el archivo google-services.json (para Android) o GoogleService-Info.plist (para iOS) y colócalo en las ubicaciones correctas:
  
  - Android: android/app/google-services.json
  
  - iOS: ios/Runner/GoogleService-Info.plist
  
  - Habilita Firestore Database y Authentication (si lo usas).
  
  - Asegúrate de tener estas líneas en tu android/build.gradle y android/app/build.gradle según documentación oficial.

  - Configura Firebase en Flutter: 
     npm install -g firebase-tools

5. Limpieza y build:
  flutter clean
  flutter pub get
  flutter build apk --release

