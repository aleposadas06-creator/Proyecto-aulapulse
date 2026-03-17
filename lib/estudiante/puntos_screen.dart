import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../services/data_service.dart';
import '../models/estudiante.dart';
import '../models/participacion.dart';

class PuntosScreen extends StatelessWidget {
  const PuntosScreen({super.key});

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

    // 🔹 Obtener participaciones reales
    final participaciones = estudiante != null
        ? dataService.obtenerParticipacionesPorEstudiante(estudiante.id)
        : <Participacion>[];

    // 🔹 Total puntos
    int totalPuntos = participaciones.fold(
      0,
      (int sum, p) => sum + p.puntos,
    );

    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        title: const Text("Mis puntos"),
        backgroundColor: AppColors.primary,
      ),

      body: Padding(
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

            const SizedBox(height: 10),

            Text(
              "Total: $totalPuntos puntos",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            /// 🔹 LISTA DE PARTICIPACIONES
            Expanded(
              child: participaciones.isEmpty
                  ? const Center(
                      child: Text("No hay participaciones registradas"),
                    )
                  : ListView.builder(
                      itemCount: participaciones.length,
                      itemBuilder: (context, index) {

                        final p = participaciones[index];

                        return Card(
                          child: ListTile(
                            leading: const Icon(Icons.star),
                            title: const Text("Participación"),
                            subtitle: Text(
                              "${p.fecha.day}/${p.fecha.month}/${p.fecha.year}",
                            ),
                            trailing: Text("+${p.puntos}"),
                          ),
                        );
                      },
                    ),
            ),

          ],
        ),
      ),
    );
  }
}