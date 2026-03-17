import 'package:flutter/material.dart';
import 'widgets/student_checkbox_tile.dart';
import '../services/data_service.dart';
import '../models/asistencia.dart';

class AsistenciaPage extends StatefulWidget {
  const AsistenciaPage({super.key});

  @override
  State<AsistenciaPage> createState() => _AsistenciaPageState();
}

class _AsistenciaPageState extends State<AsistenciaPage> {

  final DataService dataService = DataService();

  bool asistenciaRegistrada = false;

  List<String> students = [];
  List<bool> attendance = [];

  @override
  void initState() {
    super.initState();

    // 🔥 OBTENER ESTUDIANTES CORRECTAMENTE
    final lista = dataService.obtenerEstudiantesPorCurso("curso1");

    students = lista.map((e) => e.nombre).toList();
    attendance = List.generate(students.length, (index) => false);
  }

  Future<bool> _onWillPop() async {

    if (asistenciaRegistrada) return true;

    final salir = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Asistencia no registrada"),
        content: const Text(
          "Aún no has registrado la asistencia. ¿Deseas salir de todas formas?"
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Cancelar"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("Salir"),
          ),
        ],
      ),
    );

    return salir ?? false;
  }

  void registerAttendance() {

    int presentes = attendance.where((a) => a).length;

    // 🔥 OBTENER LISTA REAL
    final lista = dataService.obtenerEstudiantesPorCurso("curso1");

    for (int i = 0; i < lista.length; i++) {

      final estudiante = lista[i];

      final asistencia = Asistencia(
        id: DateTime.now().millisecondsSinceEpoch.toString() + i.toString(),
        estudianteId: estudiante.id,
        fecha: DateTime.now(),
        presente: attendance[i],
      );

      dataService.agregarAsistencia(asistencia);
    }

    setState(() {
      asistenciaRegistrada = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Asistencia registrada: $presentes presentes"),
      ),
    );
  }

  String getFechaActual() {
    final now = DateTime.now();

    const meses = [
      "Enero","Febrero","Marzo","Abril","Mayo","Junio",
      "Julio","Agosto","Septiembre","Octubre","Noviembre","Diciembre"
    ];

    return "${now.day} ${meses[now.month - 1]} ${now.year}";
  }

  @override
  Widget build(BuildContext context) {

    int presentes = attendance.where((a) => a).length;

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(

        appBar: AppBar(
          title: const Text(
            "Registrar Asistencia",
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
                          Text(
                            getFechaActual(),
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text(
                            "Presentes",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            "$presentes / ${students.length}",
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

            /// LISTA DE ESTUDIANTES
            Expanded(
              child: ListView.builder(
                itemCount: students.length,
                itemBuilder: (context, index) {

                  return StudentCheckboxTile(
                    name: students[index],
                    value: attendance[index],
                    onChanged: (value) {
                      setState(() {
                        attendance[index] = value!;
                      });
                    },
                  );
                },
              ),
            ),

            /// BOTÓN
            Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: asistenciaRegistrada ? null : registerAttendance,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1F7A4C),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Text(
                    asistenciaRegistrada
                        ? "Asistencia Registrada"
                        : "Registrar Asistencia",
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
}