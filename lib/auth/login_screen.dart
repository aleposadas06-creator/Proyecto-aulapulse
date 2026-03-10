import 'package:flutter/material.dart';
import '../services/data_service.dart';
import '../models/usuario.dart';
import '../docente/docente_dashboard.dart';
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

                // cargar usuarios guardados
                await dataService.cargarUsuarios();

                Usuario? usuario = dataService.login(
                  correoController.text,
                  passwordController.text,
                );

                if (usuario != null) {

                  if (usuario.rol == "docente") {

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DocenteDashboard(),
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