import 'package:flutter/material.dart';

class DocenteDashboard extends StatelessWidget {
  const DocenteDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Panel del Docente"),
      ),
      body: const Center(
        child: Text("Bienvenido Docente"),
      ),
    );
  }
}