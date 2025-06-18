class PlanModel {
  final int id;
  final String nombre;
  final String descripcion;
  final double precio;
  final String duracion;
  final List<String> caracteristicas;
  final bool activo;
  final DateTime fechaCreacion;

  PlanModel({
    required this.id,
    required this.nombre,
    required this.descripcion,
    required this.precio,
    required this.duracion,
    required this.caracteristicas,
    required this.activo,
    required this.fechaCreacion,
  });

  factory PlanModel.fromJson(Map<String, dynamic> json) {
    return PlanModel(
      id: json['id'] ?? 0,
      nombre: json['nombre'] ?? '',
      descripcion: json['descripcion'] ?? '',
      precio: (json['precio'] ?? 0).toDouble(),
      duracion: json['duracion'] ?? '',
      caracteristicas: List<String>.from(json['caracteristicas'] ?? []),
      activo: json['activo'] ?? true,
      fechaCreacion: DateTime.parse(json['fecha_creacion'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'descripcion': descripcion,
      'precio': precio,
      'duracion': duracion,
      'caracteristicas': caracteristicas,
      'activo': activo,
      'fecha_creacion': fechaCreacion.toIso8601String(),
    };
  }
}