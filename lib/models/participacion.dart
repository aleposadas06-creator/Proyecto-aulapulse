class Participacion {
  final String id;
  final String estudianteId;
  final String tipoActividad;
  final int puntos;
  final DateTime fecha;

  Participacion({
    required this.id,
    required this.estudianteId,
    required this.tipoActividad,
    required this.puntos,
    required this.fecha,
  });
}