class ServicioModel {
  final int? id;
  final String? nombre;
  final String? descripcion;
  final String? precioReferencial;
  final int? emprendedorId;
  final bool? estado;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? capacidad;
  final String? latitud;
  final String? longitud;
  final String? ubicacionReferencia;
  final Map<String, dynamic>? emprendedor;
  final List<Map<String, dynamic>>? categorias;
  final List<Map<String, dynamic>>? horarios;
  final List<dynamic>? sliders;

  ServicioModel({
    this.id,
    this.nombre,
    this.descripcion,
    this.precioReferencial,
    this.emprendedorId,
    this.estado,
    this.createdAt,
    this.updatedAt,
    this.capacidad,
    this.latitud,
    this.longitud,
    this.ubicacionReferencia,
    this.emprendedor,
    this.categorias,
    this.horarios,
    this.sliders,
  });

  factory ServicioModel.fromJson(Map<String, dynamic> json) {
    return ServicioModel(
      id: json['id'],
      nombre: json['nombre'],
      descripcion: json['descripcion'],
      precioReferencial: json['precio_referencial'],
      emprendedorId: json['emprendedor_id'],
      estado: json['estado'],
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
      capacidad: json['capacidad'],
      latitud: json['latitud'],
      longitud: json['longitud'],
      ubicacionReferencia: json['ubicacion_referencia'],
      emprendedor: json['emprendedor'],
      categorias: json['categorias'] != null ? List<Map<String, dynamic>>.from(json['categorias']) : [],
      horarios: json['horarios'] != null ? List<Map<String, dynamic>>.from(json['horarios']) : [],
      sliders: json['sliders'] ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'descripcion': descripcion,
      'precio_referencial': precioReferencial,
      'emprendedor_id': emprendedorId,
      'estado': estado,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'capacidad': capacidad,
      'latitud': latitud,
      'longitud': longitud,
      'ubicacion_referencia': ubicacionReferencia,
      'emprendedor': emprendedor,
      'categorias': categorias,
      'horarios': horarios,
      'sliders': sliders,
    };
  }
}