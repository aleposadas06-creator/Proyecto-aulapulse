import 'package:flutter/material.dart';
import 'widgets/menu_card.dart';
import 'asistencia_page.dart';
import 'participacion_page.dart';
import 'reportes_page.dart';
import 'dashboard_page.dart';
import '../auth/login_screen.dart';

class TeacherDashboardPage extends StatefulWidget {
  const TeacherDashboardPage({super.key});

  @override
  State<TeacherDashboardPage> createState() => _TeacherDashboardPageState();
}

class _TeacherDashboardPageState extends State<TeacherDashboardPage> {

  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {

    final drawerTextColor = isDarkMode ? Colors.white : Colors.black;

    return Scaffold(

     appBar: AppBar(
  title: const Text(
    "Panel del Docente",
    style: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 22,
      letterSpacing: 0.5,
    ),
  ),
  centerTitle: true,
  backgroundColor: const Color(0xFF1A2E6C),
  iconTheme: const IconThemeData(
    color: Colors.white,
  ),

  actions: [
    IconButton(
      icon: const Icon(Icons.logout),
      onPressed: () {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
          (route) => false,
        );
      },
    ),
  ],
),

      backgroundColor: isDarkMode ? Colors.black : const Color(0xFFF2F2F2),

      drawer: Drawer(
        backgroundColor: isDarkMode ? Colors.grey[900] : Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [

            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF1A2E6C),
              ),
              child: Text(
                "Opciones",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            ListTile(
              leading: Icon(
                isDarkMode ? Icons.light_mode : Icons.dark_mode,
                color: isDarkMode ? Colors.yellow : Colors.black,
              ),
              title: Text(
                isDarkMode ? "Modo Claro" : "Modo Nocturno",
                style: TextStyle(color: drawerTextColor),
              ),
              onTap: () {
                setState(() {
                  isDarkMode = !isDarkMode;
                });
                Navigator.pop(context);
              },
            ),

            const Divider(),

            ListTile(
              leading: Icon(Icons.logout, color: drawerTextColor),
              title: Text(
                "Cerrar Sesión",
                style: TextStyle(color: drawerTextColor),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),

      body: LayoutBuilder(
        builder: (context, constraints) {

          int crossAxisCount = 2;

          if (constraints.maxWidth > 1200) {
            crossAxisCount = 4;
          } else if (constraints.maxWidth > 800) {
            crossAxisCount = 3;
          } else {
            crossAxisCount = 2;
          }

          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1200),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: GridView.count(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  children: [

                    MenuCard(
                      title: "Dashboard",
                      icon: Icons.dashboard,
                      color: const Color(0xFF1A2E6C),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DashboardPage(),
                          ),
                        );
                      },
                    ),

                    MenuCard(
                      title: "Asistencia",
                      icon: Icons.check_circle,
                      color: const Color(0xFF1F7A4C),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AsistenciaPage(),
                          ),
                        );
                      },
                    ),

                    MenuCard(
                      title: "Participación",
                      icon: Icons.record_voice_over,
                      color: const Color(0xFFD4A017),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ParticipacionPage(),
                          ),
                        );
                      },
                    ),

                    MenuCard(
                      title: "Reportes",
                      icon: Icons.bar_chart,
                      color: const Color(0xFF8E6AC8),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ReportesPage(),
                          ),
                        );
                      },
                    ),

                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}