class Participacion {
  final String id;
  final String estudianteId;
  final int puntos;
  final String tipoActividad; 
  final DateTime fecha;

  Participacion({
    required this.id,
    required this.estudianteId,
    required this.puntos,
    required this.tipoActividad, 
    required this.fecha,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'estudianteId': estudianteId,
      'puntos': puntos,
      'tipoActividad': tipoActividad, 
      'fecha': fecha.toIso8601String(),
    };
  }

  factory Participacion.fromJson(Map<String, dynamic> json) {
    return Participacion(
      id: json['id'],
      estudianteId: json['estudianteId'],
      puntos: json['puntos'],
      tipoActividad: json['tipoActividad'], // 👈 NUEVO
      fecha: DateTime.parse(json['fecha']),
    );
  }
}