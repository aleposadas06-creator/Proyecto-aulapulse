import 'package:flutter/material.dart';

class EstudianteDashboard extends StatelessWidget {
  const EstudianteDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Panel del Estudiante"),
      ),
      body: const Center(
        child: Text("Bienvenido Estudiante"),
      ),
    );
  }
}