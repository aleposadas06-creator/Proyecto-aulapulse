import 'package:flutter/material.dart';
import 'widgets/student_participation_tile.dart';

class ParticipacionPage extends StatefulWidget {
  const ParticipacionPage({super.key});

  @override
  State<ParticipacionPage> createState() => _ParticipacionPageState();
}

class _ParticipacionPageState extends State<ParticipacionPage> {

  final List<String> students = [
    "Ana López",
    "Carlos Pérez",
    "María Rodríguez",
    "Luis García",
    "Daniel Hernández",
    "Sofía Torres",
    "José Martínez",
    "Valeria Flores",
    "Pedro Sánchez",
    "Camila Reyes",
    "Andrés Castro",
    "Laura Mendoza",
    "Miguel Ramos",
    "Daniela Cruz",
    "Fernando Ortiz",
    "Paola Vargas",
    "Ricardo Díaz",
    "Alejandro Morales",
    "Gabriela Silva",
    "Jorge Navarro",
  ];

  List<int> participation = List.generate(20, (index) => 0);

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

        ],
      ),
    );
  }
}
