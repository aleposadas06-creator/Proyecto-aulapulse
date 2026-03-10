class Curso {
  final String id;
  final String nombreCurso;
  final String docenteId;
  final List<String> listaEstudiantes;

  Curso({
    required this.id,
    required this.nombreCurso,
    required this.docenteId,
    required this.listaEstudiantes,
  });
}