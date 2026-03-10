import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/usuario.dart';
import '../models/curso.dart';
import '../models/estudiante.dart';
import '../models/asistencia.dart';
import '../models/participacion.dart';

class DataService {

  List<Usuario> usuarios = [];
  List<Curso> cursos = [];
  List<Estudiante> estudiantes = [];
  List<Asistencia> asistencias = [];
  List<Participacion> participaciones = [];

  // -----------------------------
  // GUARDAR USUARIOS
  // -----------------------------
  Future<void> guardarUsuarios() async {
    final prefs = await SharedPreferences.getInstance();

    List<Map<String, dynamic>> data =
        usuarios.map((u) => u.toJson()).toList();

    prefs.setString("usuarios", jsonEncode(data));
  }

  // -----------------------------
  // CARGAR USUARIOS
  // -----------------------------
  Future<void> cargarUsuarios() async {
    final prefs = await SharedPreferences.getInstance();

    String? data = prefs.getString("usuarios");

    if (data != null) {
      List lista = jsonDecode(data);
      usuarios = lista.map((u) => Usuario.fromJson(u)).toList();
    }
  }

  // -----------------------------
  // LOGIN
  // -----------------------------
  Usuario? login(String correo, String password) {
    try {
      return usuarios.firstWhere(
        (u) => u.correo == correo && u.password == password,
      );
    } catch (e) {
      return null;
    }
  }

  // -----------------------------
  // ASISTENCIA
  // -----------------------------
  void agregarAsistencia(Asistencia asistencia) {
    asistencias.add(asistencia);
  }

  List<Asistencia> obtenerAsistenciasPorEstudiante(String estudianteId) {
    return asistencias
        .where((a) => a.estudianteId == estudianteId)
        .toList();
  }

  // -----------------------------
  // PARTICIPACION
  // -----------------------------
  void agregarParticipacion(Participacion participacion) {
    participaciones.add(participacion);
  }

  List<Participacion> obtenerParticipacionesPorEstudiante(String estudianteId) {
    return participaciones
        .where((p) => p.estudianteId == estudianteId)
        .toList();
  }

  // -----------------------------
  // ESTUDIANTES
  // -----------------------------
  List<Estudiante> obtenerEstudiantesPorCurso(String cursoId) {
    return estudiantes.where((e) => e.cursoId == cursoId).toList();
  }

  // -----------------------------
  // USUARIOS INICIALES
  // -----------------------------
  Future<void> inicializarUsuarios() async {

    await cargarUsuarios();

    if (usuarios.isEmpty) {

      usuarios.add(
        Usuario(
          id: "doc1",
          nombre: "Dra. Ana Martínez",
          correo: "ana.martinez@aulapulse.com",
          password: "1234",
          rol: "docente",
        ),
      );

      usuarios.add(
        Usuario(
          id: "est1",
          nombre: "Luis Gómez",
          correo: "luis.gomez@aulapulse.com",
          password: "1234",
          rol: "estudiante",
        ),
      );

      usuarios.add(
        Usuario(
          id: "est2",
          nombre: "Maria López",
          correo: "maria.lopez@aulapulse.com",
          password: "1234",
          rol: "estudiante",
        ),
      );

      usuarios.add(
        Usuario(
          id: "est3",
          nombre: "Carlos Rivera",
          correo: "carlos.rivera@aulapulse.com",
          password: "1234",
          rol: "estudiante",
        ),
      );

      await guardarUsuarios();
    }
  }
}