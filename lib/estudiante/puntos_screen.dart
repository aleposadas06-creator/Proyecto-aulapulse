import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class PuntosScreen extends StatelessWidget {
  const PuntosScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        title: const Text("Mis puntos"),
        backgroundColor: AppColors.primary,
      ),

    body:  Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          const Text(
            "Mis puntos",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 20),

          Card(
            child: ListTile(
              leading: const Icon(Icons.quiz),
              title: const Text("Actividad rapida"),
              trailing: const Text("+5"),
            ),
          ),

        ],
      ),
    ),
    );
  }
}