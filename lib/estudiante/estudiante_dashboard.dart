import 'package:flutter/material.dart';
import '../services/data_service.dart';
import 'progreso_screen.dart';
import 'puntos_screen.dart';
import 'mi_asistencia_screen.dart';
import 'historial_screen.dart';
import '../theme/app_colors.dart';
import '../models/asistencia.dart';
import '../models/participacion.dart';
import '../models/estudiante.dart';
import '../auth/login_screen.dart';

class EstudianteDashboard extends StatefulWidget {
  const EstudianteDashboard({super.key});

  @override
  State<EstudianteDashboard> createState() => _EstudianteDashboardState(); 
}

class _EstudianteDashboardState extends State<EstudianteDashboard>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<double> _animation;

  bool isDarkMode = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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

// 🔹 Asistencia
final asistencias = estudiante != null
    ? dataService.obtenerAsistenciasPorEstudiante(estudiante.id)
    : <Asistencia>[];

double porcentaje = 0;

if (asistencias.isNotEmpty) {
  int presentes = asistencias.where((a) => a.presente).length;
  porcentaje = (presentes / asistencias.length) * 100;
}

// 🔹 Participaciones
final participaciones = estudiante != null
    ? dataService.obtenerParticipacionesPorEstudiante(estudiante.id)
    : <Participacion>[];

// 🔹 Totales
int totalParticipaciones = participaciones.length;

int totalPuntos = participaciones.fold(
  0,
  (int sum, p) => sum + p.puntos.toInt(),
);
    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : AppColors.background,

      appBar: AppBar(
        title: Text("Panel del Estudiante"),
        backgroundColor: isDarkMode ? Colors.grey[900] : AppColors.primary,
      ),
      
      drawer: Drawer(
        child: ListView(
          children: [
          
            const DrawerHeader(
              decoration: BoxDecoration(
                color: AppColors.primary,
              ),
              child: Text(
                "Opciones",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),

            SwitchListTile(
              secondary: const Icon(Icons.dark_mode),
              title: const Text("Modo oscuro"),
              value: isDarkMode,
              onChanged: (value) {
                setState(() {
                  isDarkMode = value;
                });
              },
            ),

            const Divider(),

            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Cerrar sesión"),
             onTap: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginScreen(),
                ),
                (route) => false,
              );
            },
            ),

          ],
        ),
      ),

      body: LayoutBuilder(
        builder: (context, constraints) {

          int crossAxisCount = constraints.maxWidth > 700 ? 3 : 2;

          return Padding(
            padding: const EdgeInsets.all(20),

            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                
                children: [

                  Text(
                    "Bienvenido ${usuario?.nombre ?? ''}",
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 20),

                  Row(
                    children: [

                      Expanded(
                        child: _buildMetricCard(
                          "Puntos",
                          "$totalPuntos",
                          Icons.star,
                          Colors.orange,
                        ),
                      ),

                      const SizedBox(width: 10),

                      Expanded(
                        child: _buildMetricCard(
                          "Participaciones",
                          "$totalParticipaciones",
                          Icons.record_voice_over,
                          Colors.blue,
                        ), 
                      ),
                    ],
                  ),

                  const SizedBox(height: 15),

                  _buildMetricCard(
                    "Asistencia",
                    "${porcentaje.toStringAsFixed(0)}%",
                    Icons.check_circle,
                    Colors.green,
                  ),

                  const SizedBox(height: 25),

                  const Text(
                    "Opciones",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 15),

                  FadeTransition(
                    opacity: _animation,

                    child: GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),

                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,

                      children: [

                        _buildCard(
                          context,
                          "Mi progreso",
                          Icons.trending_up,
                          AppColors.primary,
                          const ProgresoScreen(),
                        ),

                        _buildCard(
                          context,
                          "Mis puntos",
                          Icons.star,
                          AppColors.accent,
                          const PuntosScreen(),
                        ),

                        _buildCard(
                          context,
                          "Mi asistencia",
                          Icons.check_circle,
                          AppColors.success,
                          const MiAsistenciaScreen(),
                        ),

                        _buildCard(
                          context,
                          "Historial",
                          Icons.history,
                          AppColors.secondary,
                          const HistorialScreen(),
                        ),

                      ],
                    ),
                  ),

                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildMetricCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {

    return Container(
      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
          )
        ],
      ),

      child: Row(
        children: [

          Icon(icon, color: color, size: 30),

          const SizedBox(width: 10),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),

              Text(
                value,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildCard(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    Widget screen,
  ) {

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => screen),
        );
      },

      borderRadius: BorderRadius.circular(20),

      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),

        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 8,
              offset: Offset(0, 4),
            )
          ],
        ),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Icon(icon, size: 50, color: Colors.white),

            const SizedBox(height: 10),

            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

          ],
        ),
      ),
    );
  }
}