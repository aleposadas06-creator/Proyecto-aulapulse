class Usuario {
  final String id;
  final String nombre;
  final String correo;
  final String password;
  final String rol;

  Usuario({
    required this.id,
    required this.nombre,
    required this.correo,
    required this.password,
    required this.rol,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "nombre": nombre,
      "correo": correo,
      "password": password,
      "rol": rol,
    };
  }

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      id: json["id"],
      nombre: json["nombre"],
      correo: json["correo"],
      password: json["password"],
      rol: json["rol"],
    );
  }
}