import 'package:flutter/material.dart';
import 'auth/login_screen.dart';
import 'services/data_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final dataService = DataService();


  await dataService.inicializarUsuarios();
  await dataService.inicializarEstudiantes();

  await dataService.cargarAsistencias();
  await dataService.cargarParticipaciones();

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