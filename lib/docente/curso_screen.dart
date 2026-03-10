import 'package:flutter/material.dart';

class CursoScreen extends StatefulWidget {
  const CursoScreen({super.key});

  @override
  State<CursoScreen> createState() => _CursoScreenState();
}

class _CursoScreenState extends State<CursoScreen> {

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Curso"),
      ),

      body: const Center(
        child: Text("Contenido del curso"),
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,

        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: "Resumen",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check),
            label: "Asistencia",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: "Participación",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: "Reportes",
          ),
        ],
      ),
    );
  }
}