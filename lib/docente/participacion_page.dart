import 'package:flutter/material.dart';
import 'widgets/student_participation_tile.dart';
import '../services/data_service.dart';
import '../models/participacion.dart';

class ParticipacionPage extends StatefulWidget {
  const ParticipacionPage({super.key});

  @override
  State<ParticipacionPage> createState() => _ParticipacionPageState();
}

class _ParticipacionPageState extends State<ParticipacionPage> {

  final DataService dataService = DataService();

  List<String> students = [];
  List<int> participation = [];

  @override
  void initState() {
    super.initState();

    // Obtener estudiantes desde DataService
    students = dataService.estudiantes
        .map((e) => e.nombre)
        .toList();

    // Inicializar participaciones
    participation = List.generate(students.length, (index) => 0);
  }

  String getFechaActual() {
    final now = DateTime.now();

    const meses = [
      "Enero","Febrero","Marzo","Abril","Mayo","Junio",
      "Julio","Agosto","Septiembre","Octubre","Noviembre","Diciembre"
    ];

    return "${now.day} ${meses[now.month - 1]} ${now.year}";
  }

  int getTotalParticipaciones() {
    return participation.fold(0, (a, b) => a + b);
  }

  void guardarParticipaciones() {
    for (int i = 0; i < dataService.estudiantes.length; i++) {

      final estudiante = dataService.estudiantes[i];

      final participacionObj = Participacion(
      id: DateTime.now().millisecondsSinceEpoch.toString() + i.toString(),
      estudianteId: estudiante.id,
      tipoActividad: "Clase",
      puntos: participation[i],
      fecha: DateTime.now(),
    );

      dataService.participaciones.add(participacionObj);
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Participaciones guardadas"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    int total = getTotalParticipaciones();

    return Scaffold(

      appBar: AppBar(
        title: const Text(
          "Registrar Participación",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF1A2E6C),
        iconTheme: const IconThemeData(color: Colors.white),
      ),

      body: Column(
        children: [

          /// TARJETA DE RESUMEN
          Padding(
            padding: const EdgeInsets.all(16),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Fecha",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(getFechaActual()),
                      ],
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text(
                          "Participaciones",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          "$total",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                  ],
                ),
              ),
            ),
          ),

          /// LISTA
          Expanded(
            child: ListView.builder(
              itemCount: students.length,
              itemBuilder: (context, index) {

                return StudentParticipationTile(
                  name: students[index],
                  points: participation[index],

                  onAdd: () {
                    setState(() {
                      participation[index]++;
                    });

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        duration: const Duration(milliseconds: 600),
                        content: Text(
                          "Participación agregada a ${students[index]}"
                        ),
                      ),
                    );
                  },

                  onRemove: () {

                    if (participation[index] > 0) {
                      setState(() {
                        participation[index]--;
                      });
                    }

                  },
                );
              },
            ),
          ),

          /// BOTÓN GUARDAR
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: guardarParticipaciones,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1F7A4C),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  "Guardar Participaciones",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          )

        ],
      ),
    );
  }
}
