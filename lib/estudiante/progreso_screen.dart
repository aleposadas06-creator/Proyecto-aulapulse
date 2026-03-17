import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../services/data_service.dart';
import '../models/estudiante.dart';
import '../models/participacion.dart';

class ProgresoScreen extends StatelessWidget {
  const ProgresoScreen ({super.key});

  @override
  Widget build(BuildContext context) {

    final dataService = DataService();
    final usuario = dataService.usuarioActual;

    // 🔹 Buscar estudiante
    Estudiante? estudiante;

    try {
      estudiante = dataService.estudiantes.firstWhere(
        (e) => e.id == usuario?.id,
      );
    } catch (e) {
      estudiante = null;
    }

    // 🔹 Obtener participaciones
    final participaciones = estudiante != null
        ? dataService.obtenerParticipacionesPorEstudiante(estudiante.id)
        : <Participacion>[];

    // 🔹 Total puntos
    int puntos = participaciones.fold(
      0,
      (int sum, p) => sum + p.puntos,
    );

    // 🔹 Progreso (puedes ajustar la meta)
    double progreso = 0;
    int meta = 200; // meta de puntos

    if (meta > 0) {
      progreso = puntos / meta;
      if (progreso > 1) progreso = 1; // máximo 100%
    }

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
                borderRadius: BorderRadius.circular(15),
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