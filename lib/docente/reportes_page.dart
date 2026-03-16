import 'package:flutter/material.dart';

class ReportesPage extends StatefulWidget {
  const ReportesPage({super.key});

  @override
  State<ReportesPage> createState() => _ReportesPageState();
}

class _ReportesPageState extends State<ReportesPage> {

  List<String> observaciones = [
    "Carlos Pérez - No entregó tarea",
    "Luis García - Interrumpe la clase",
  ];

  void agregarObservacion(String texto) {
    setState(() {
      observaciones.add(texto);
    });
  }

  void mostrarDialogo() {

    TextEditingController controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {

        return AlertDialog(

          title: const Text("Editar Reportes"),

          content: TextField(
            controller: controller,
            decoration: const InputDecoration(
              hintText: "Añadir nueva nota",
            ),
          ),

          actions: [

            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancelar"),
            ),

            ElevatedButton(
              onPressed: () {

                if(controller.text.isNotEmpty){
                  agregarObservacion(controller.text);
                }

                Navigator.pop(context);
              },
              child: const Text("Guardar"),
            )

          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text(
          "Observaciones del Docente",
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

          const SizedBox(height: 10),

          /// LISTA DE OBSERVACIONES
          Expanded(
            child: ListView.builder(
              itemCount: observaciones.length,
              itemBuilder: (context, index) {

                return ListTile(
                  leading: const Icon(Icons.note),
                  title: Text(observaciones[index]),
                );

              },
            ),
          ),

          /// BOTON AGREGAR
          Padding(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton.icon(
              onPressed: mostrarDialogo,
              icon: const Icon(Icons.add),
              label: const Text(
                "Agregar Observación",
                style: TextStyle(
                  color: Colors.white
                ),),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF8E6AC8),
                minimumSize: const Size(double.infinity, 50),
              ),
            ),
          ),

        ],
      ),
    );
  }
}