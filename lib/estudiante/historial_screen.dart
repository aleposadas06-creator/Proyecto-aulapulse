import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../services/data_service.dart';
import '../models/estudiante.dart';
import '../models/asistencia.dart';
import '../models/participacion.dart';

class HistorialScreen extends StatelessWidget {
  const HistorialScreen({super.key});

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

    // 🔹 Obtener datos
    final asistencias = estudiante != null
        ? dataService.obtenerAsistenciasPorEstudiante(estudiante.id)
        : <Asistencia>[];

    final participaciones = estudiante != null
        ? dataService.obtenerParticipacionesPorEstudiante(estudiante.id)
        : <Participacion>[];

    // 🔹 Crear lista combinada (historial)
    List<Map<String, dynamic>> historial = [];

    for (var a in asistencias) {
      historial.add({
        "tipo": "Asistencia",
        "fecha": a.fecha,
        "detalle": a.presente ? "Presente" : "Ausente",
        "puntos": 0,
      });
    }

    for (var p in participaciones) {
      historial.add({
        "tipo": "Participación",
        "fecha": p.fecha,
        "detalle": "Participación en clase",
        "puntos": p.puntos,
      });
    }

    // 🔹 Ordenar por fecha (más reciente primero)
    historial.sort((a, b) => b["fecha"].compareTo(a["fecha"]));

    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        title: const Text("Historial"),
        backgroundColor: AppColors.primary,
      ),

      body: Padding(
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

            Expanded(
              child: historial.isEmpty
                  ? const Center(
                      child: Text("No hay registros aún"),
                    )
                  : ListView.builder(
                      itemCount: historial.length,
                      itemBuilder: (context, index) {

                        final item = historial[index];
                        final fecha = item["fecha"] as DateTime;

                        return Card(
                          child: ListTile(
                            leading: const Icon(Icons.history),
                            title: Text(item["detalle"]),
                            subtitle: Text(
                              "${fecha.day}/${fecha.month}/${fecha.year}",
                            ),
                            trailing: item["puntos"] > 0
                                ? Text("+${item["puntos"]}")
                                : const Text(""),
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