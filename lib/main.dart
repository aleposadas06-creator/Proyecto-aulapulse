import 'package:flutter/material.dart';
import 'auth/login_screen.dart';
import 'services/data_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  DataService dataService = DataService();
  await dataService.inicializarUsuarios();

  runApp(const AulaPulseApp());
}

class AulaPulseApp extends StatelessWidget {
  const AulaPulseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AulaPulse',
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}