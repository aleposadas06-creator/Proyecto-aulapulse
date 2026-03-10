class Asistencia {
  final String id;
  final String estudianteId;
  final DateTime fecha;
  bool presente;

  Asistencia({
    required this.id,
    required this.estudianteId,
    required this.fecha,
    this.presente = false,
  });
}