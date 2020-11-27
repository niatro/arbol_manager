import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutterapparbol/features/arbol/presentation/pages/arbol_modulos_prueba.dart';
import 'package:flutterapparbol/injection_auto.dart';
import 'package:injectable/injectable.dart';
import 'features/arbol/presentation/widgets/app_widget.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // abajo el await se produce porque estoy esperando
  // el futuro de shared preferences
  await configureInjection(Environment.prod);
  runApp(AppWidget());
  //Lo de abajo es la injeccion de todo el proyecto original
//  await di.init();
//  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Arboles',
      theme: ThemeData(
        primaryColor: Colors.green.shade800,
        accentColor: Colors.green.shade600,
      ),
//      home: ArbolesEntityPage(),
      home: ArbolModuloSQLDosPrueba(),
    );
  }
}
