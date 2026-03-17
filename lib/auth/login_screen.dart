import 'package:flutter/material.dart';
import '../services/data_service.dart';
import '../models/usuario.dart';
import '../docente/teacher_dashboard_page.dart';
import '../estudiante/estudiante_dashboard.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final DataService dataService = DataService();

  final TextEditingController correoController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("AulaPulse"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            TextField(
              controller: correoController,
              decoration: const InputDecoration(
                labelText: "Correo",
              ),
            ),

            const SizedBox(height: 10),

            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Contraseña",
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () async {

                // 🔹 IMPORTANTE: cargar usuarios desde almacenamiento
                await dataService.cargarUsuarios();

                Usuario? usuario = dataService.login(
                  correoController.text.trim(), // 👈 evita errores por espacios
                  passwordController.text.trim(),
                );

                if (usuario != null) {

                  // 🔹 Guardar usuario actual
                  dataService.usuarioActual = usuario;

                  // 🔹 Redirección según rol
                  if (usuario.rol == "docente") {

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TeacherDashboardPage(),
                      ),
                    );

                  } else {

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const EstudianteDashboard(),
                      ),
                    );

                  }

                } else {

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Credenciales incorrectas"),
                    ),
                  );

                }

              },
              child: const Text("Iniciar sesión"),
            )

          ],
        ),
      ),
    );
  }
}