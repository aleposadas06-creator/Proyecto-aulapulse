class Asistencia {
  final String id;
  final String estudianteId;
  final DateTime fecha;
  final bool presente;

  Asistencia({
    required this.id,
    required this.estudianteId,
    required this.fecha,
    required this.presente,
  });

  // 🔹 CONVERTIR A JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'estudianteId': estudianteId,
      'fecha': fecha.toIso8601String(),
      'presente': presente,
    };
  }

  // 🔹 CREAR DESDE JSON
  factory Asistencia.fromJson(Map<String, dynamic> json) {
    return Asistencia(
      id: json['id'],
      estudianteId: json['estudianteId'],
      fecha: DateTime.parse(json['fecha']),
      presente: json['presente'],
    );
  }
}