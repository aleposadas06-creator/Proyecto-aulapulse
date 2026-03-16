import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class ProgresoScreen extends StatelessWidget {
  const ProgresoScreen ({super.key});

  @override
  Widget build(BuildContext context) {

    int puntos = 120;
    double progreso = 0.6;

    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        title: const Text("Mi progreso"),
        backgroundColor: AppColors.primary,
      ),
    
    body: Padding(
      padding: const EdgeInsets.all(20),


      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
      children: [
          const Text(
            "Mi Progreso",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 20),

          Card(
            elevation: 4,
            color: AppColors.background,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(15),
            ),
            
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  
                  const Text(
                    "Nivel actual",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                    ),

                  const SizedBox(height: 15),

                  LinearProgressIndicator(
                    value: progreso,
                    color: AppColors.secondary,
                    backgroundColor: Colors.grey[300],
                    minHeight: 10,
                  ),

                  const SizedBox(height: 10),

                  Text(
                    "Puntos acumulados: $puntos",
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                    ),
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