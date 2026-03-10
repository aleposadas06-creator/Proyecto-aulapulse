class Estudiante {
  final String id;
  final String nombre;
  final String cursoId;
  int totalPuntos;
  double porcentajeAsistencia;

  Estudiante({
    required this.id,
    required this.nombre,
    required this.cursoId,
    this.totalPuntos = 0,
    this.porcentajeAsistencia = 0,
  });
}