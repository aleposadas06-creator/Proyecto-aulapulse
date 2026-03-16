import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class MiAsistenciaScreen extends StatelessWidget {
  const MiAsistenciaScreen({super.key});

  @override
  Widget build(BuildContext context){

    double asistencia = 0.92;

    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        title: const Text("Mi asistencia"),
        backgroundColor: AppColors.primary,
      ),

    body:  Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          const Text(
            "Mi Asistencia",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 20),

          Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [

                  const Text("Porcentaje de asistencia"),

                  const SizedBox(height: 10),

                  LinearProgressIndicator(
                    value: asistencia,
                  ),

                  const SizedBox(height: 10),

                  Text("Asistencia: ${(asistencia * 100).toInt()}%"),
                ],
              ),
            ),
          ),

        ],
      ),
    ),
    );
  }
}