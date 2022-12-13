import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_todo/screens/home.dart';
import 'package:flutter_application_todo/model/db_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.green));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AnimatedSplashScreen(
        splash: 'assets/images/three.png',
        nextScreen: LetDoIt(),
        splashTransition: SplashTransition.rotationTransition,
        duration: 3000,
        backgroundColor: Colors.white,
      ),
    );
  }
}
