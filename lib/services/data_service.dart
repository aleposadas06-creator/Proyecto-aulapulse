import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/usuario.dart';
import '../models/curso.dart';
import '../models/estudiante.dart';
import '../models/asistencia.dart';
import '../models/participacion.dart';

class DataService {
  static final DataService _instancia = DataService._interno();

  factory DataService() => _instancia;

  DataService._interno();

  Usuario? usuarioActual;

  List<Usuario> usuarios = [];
  List<Curso> cursos = [];
  List<Estudiante> estudiantes = [];
  List<Asistencia> asistencias = [];
  List<Participacion> participaciones = [];

  // =============================
  // 🔹 USUARIOS
  // =============================
  Future<void> guardarUsuarios() async {
    final prefs = await SharedPreferences.getInstance();

    List<Map<String, dynamic>> data =
        usuarios.map((u) => u.toJson()).toList();

    await prefs.setString("usuarios", jsonEncode(data));
  }

  Future<void> cargarUsuarios() async {
    final prefs = await SharedPreferences.getInstance();

    String? data = prefs.getString("usuarios");

    if (data != null) {
      List lista = jsonDecode(data);
      usuarios = lista.map((u) => Usuario.fromJson(u)).toList();
    }
  }

  Usuario? login(String correo, String password) {
    try {
      return usuarios.firstWhere(
        (u) => u.correo == correo && u.password == password,
      );
    } catch (e) {
      return null;
    }
  }

  // =============================
  // 🔹 ASISTENCIAS
  // =============================
  void agregarAsistencia(Asistencia asistencia) {
    asistencias.add(asistencia);
  }

  Future<void> guardarAsistencias() async {
    final prefs = await SharedPreferences.getInstance();

    List<Map<String, dynamic>> data =
        asistencias.map((a) => a.toJson()).toList();

    await prefs.setString("asistencias", jsonEncode(data));
  }

  Future<void> cargarAsistencias() async {
    final prefs = await SharedPreferences.getInstance();

    String? data = prefs.getString("asistencias");

    if (data != null) {
      List lista = jsonDecode(data);
      asistencias = lista.map((a) => Asistencia.fromJson(a)).toList();
    }
  }

  List<Asistencia> obtenerAsistenciasPorEstudiante(String estudianteId) {
    return asistencias
        .where((a) => a.estudianteId == estudianteId)
        .toList();
  }

  // =============================
  // 🔹 PARTICIPACIONES
  // =============================
  void agregarParticipacion(Participacion participacion) {
    participaciones.add(participacion);
  }

  Future<void> guardarParticipaciones() async {
    final prefs = await SharedPreferences.getInstance();

    List<Map<String, dynamic>> data =
        participaciones.map((p) => p.toJson()).toList();

    await prefs.setString("participaciones", jsonEncode(data));
  }

  Future<void> cargarParticipaciones() async {
    final prefs = await SharedPreferences.getInstance();

    String? data = prefs.getString("participaciones");

    if (data != null) {
      List lista = jsonDecode(data);
      participaciones =
          lista.map((p) => Participacion.fromJson(p)).toList();
    }
  }

  List<Participacion> obtenerParticipacionesPorEstudiante(String estudianteId) {
    return participaciones
        .where((p) => p.estudianteId == estudianteId)
        .toList();
  }

  // =============================
  // 🔹 ESTUDIANTES
  // =============================
  List<Estudiante> obtenerEstudiantesPorCurso(String cursoId) {
    return estudiantes
        .where((e) => e.cursoId == cursoId)
        .toList();
  }

  // =============================
  // 🔹 INICIALIZAR USUARIOS
  // =============================
  Future<void> inicializarUsuarios() async {
    await cargarUsuarios();

    if (usuarios.isEmpty) {
      usuarios.addAll([
        Usuario(
          id: "doc1",
          nombre: "Dra. Ana Martínez",
          correo: "ana.martinez@aulapulse.com",
          password: "1234",
          rol: "docente",
        ),

        // ⚠️ IDs deben coincidir con estudiantes
        Usuario(
          id: "2", // 👈 Carlos Pérez
          nombre: "Carlos Pérez",
          correo: "carlos.perez@aulapulse.com",
          password: "1234",
          rol: "estudiante",
        ),

        Usuario(
          id: "3", // 👈 María Rodríguez
          nombre: "María Rodríguez",
          correo: "maria.rodriguez@aulapulse.com",
          password: "1234",
          rol: "estudiante",
        ),
      ]);

      await guardarUsuarios();
    }
  }

  // =============================
  // 🔹 INICIALIZAR ESTUDIANTES
  // =============================
  Future<void> inicializarEstudiantes() async {
    if (estudiantes.isEmpty) {
      estudiantes.addAll([
        Estudiante(id: "1", nombre: "Ana López", cursoId: "curso1"),
        Estudiante(id: "2", nombre: "Carlos Pérez", cursoId: "curso1"),
        Estudiante(id: "3", nombre: "María Rodríguez", cursoId: "curso1"),
        Estudiante(id: "4", nombre: "Luis García", cursoId: "curso1"),
        Estudiante(id: "5", nombre: "Daniel Hernández", cursoId: "curso1"),
        Estudiante(id: "6", nombre: "Sofía Torres", cursoId: "curso1"),
        Estudiante(id: "7", nombre: "José Martínez", cursoId: "curso1"),
        Estudiante(id: "8", nombre: "Valeria Flores", cursoId: "curso1"),
        Estudiante(id: "9", nombre: "Pedro Sánchez", cursoId: "curso1"),
        Estudiante(id: "10", nombre: "Camila Reyes", cursoId: "curso1"),
      ]);
    }
  }
}