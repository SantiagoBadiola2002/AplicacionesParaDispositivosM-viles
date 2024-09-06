import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hola_mundo_flutter/firebase_options.dart';
import 'pages/Intro.dart'; // Importa el archivo de la pantalla de inicio de sesión

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tu Ferretería',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Intro(), // Usa la pantalla de inicio de sesión como home
    );
  }
}
