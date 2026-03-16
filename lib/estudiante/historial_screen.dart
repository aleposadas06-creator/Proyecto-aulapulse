import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class HistorialScreen extends StatelessWidget {
  const HistorialScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        title: const Text("Historial"),
        backgroundColor: AppColors.primary,
      ),

    body:  Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          const Text(
            "Historial",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 20),

          Card(
            child: ListTile(
              leading: const Icon(Icons.history),
              title: const Text("Participacion en clase"),
              subtitle: const Text("15 Marzo"),
              trailing: const Text("+10"),
            ),
          ),

          Card(
            child: ListTile(
              leading: const Icon(Icons.history),
              title: const Text("Actividad rapida"),
              subtitle: const Text("12 Marzo"),
              trailing: const Text("+5"),
            ),
          ),

        ],
      ),
    ),
    );
  }
}