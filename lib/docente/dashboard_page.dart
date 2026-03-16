import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text(
          "Dashboard del Curso",
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

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [

              /// TARJETAS DE RESUMEN
              Row(
                children: [

                  Expanded(
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: const [
                            Icon(Icons.people, size: 30),
                            SizedBox(height: 8),
                            Text("20",
                                style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold)),
                            Text("Estudiantes"),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: const [
                            Icon(Icons.check_circle, size: 30),
                            SizedBox(height: 8),
                            Text("87%",
                                style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold)),
                            Text("Asistencia"),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: const [
                            Icon(Icons.star, size: 30),
                            SizedBox(height: 8),
                            Text("12",
                                style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold)),
                            Text("Participaciones"),
                          ],
                        ),
                      ),
                    ),
                  ),

                ],
              ),

              const SizedBox(height: 25),

              /// ESTUDIANTE DESTACADO
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: const [

                      Text(
                        "⭐ Estudiante Destacado",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: 10),

                      Text(
                        "Ana López",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: 5),

                      Text("12 participaciones"),

                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: const [

                      Text(
                        "📝 Última Observación",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: 10),

                      Text(
                        "Carlos Pérez - No entregó tarea",
                        textAlign: TextAlign.center,
                      ),

                    ],
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}