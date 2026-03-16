import 'package:flutter/material.dart';

import 'progreso_screen.dart';
import 'puntos_screen.dart';
import 'mi_asistencia_screen.dart';
import 'historial_screen.dart';
import '../theme/app_colors.dart';

class EstudianteDashboard extends StatefulWidget {
  const EstudianteDashboard({super.key});

  @override
  State<EstudianteDashboard> createState() => _EstudianteDashboardState(); 
}

class _EstudianteDashboardState extends State<EstudianteDashboard>
    with SingleTickerProviderStateMixin {

      late AnimationController _controller;
      late Animation<double> _animation;

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
      Widget build(BuildContext context){

    return Scaffold(

      appBar: AppBar(
        title: const Text("Panel del Estudiante"),
        backgroundColor: AppColors.primary,
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
              value: Theme.of(context).brightness == Brightness.dark,
              onChanged: (value) {

              },
              ),

              const Divider(),

            const  ListTile(
              leading: Icon(Icons.logout),
              title: Text("Cerrar sesión"),
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

                const Text(
                  "Bienvenido Estudiante",
                  style: TextStyle(
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
                        "120",
                        Icons.star,
                        Colors.orange,
                      ),
                    ),

                    const SizedBox(width: 10),

                    Expanded(
                      child: _buildMetricCard(
                        "Participaciones",
                        "8",
                        Icons.record_voice_over,
                        Colors.blue,
                      ), 
                      ),
                  ],
                ),

                const SizedBox(height: 15),

                _buildMetricCard(
                  "Asistencia",
                  "92%",
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
                    ) ,
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

          Icon(
            icon,
            color: color,
            size: 30,
          ),

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

            Icon(
              icon,
              size: 50,
              color: Colors.white,
            ),

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