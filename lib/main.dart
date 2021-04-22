
import 'package:flutter/material.dart';
import 'Screens/Login.dart';
import 'Screens/LandingPage.dart';
import 'package:flutter/services.dart';
void main() {
    WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MaterialApp(home:MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AlumniPortal',
      home: LandingPage(),
    );
  }
}

