class ServicioDetalleModel {
  final int id;
  final String nombre;
  final String descripcion;
  final String precioReferencial;
  final String ubicacionReferencia;
  final bool estado;
  final DateTime createdAt;
  final DateTime updatedAt;
  final UbicacionModel? ubicacion;
  final DisponibilidadModel? disponibilidad;
  final EmprendedorDetalleModel? emprendedor;
  final CategoriaDetalleModel? categoria;

  ServicioDetalleModel({
    required this.id,
    required this.nombre,
    required this.descripcion,
    required this.precioReferencial,
    required this.ubicacionReferencia,
    required this.estado,
    required this.createdAt,
    required this.updatedAt,
    this.ubicacion,
    this.disponibilidad,
    this.emprendedor,
    this.categoria,
  });

  factory ServicioDetalleModel.fromJson(Map<String, dynamic> json) {
    return ServicioDetalleModel(
      id: json['id'],
      nombre: json['nombre'] ?? '',
      descripcion: json['descripcion'] ?? '',
      precioReferencial: json['precio_referencial'] ?? '0.00',
      ubicacionReferencia: json['ubicacion_referencia'] ?? '',
      estado: json['estado'] ?? true,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      ubicacion: json['ubicacion'] != null ? UbicacionModel.fromJson(json['ubicacion']) : null,
      disponibilidad: json['disponibilidad'] != null ? DisponibilidadModel.fromJson(json['disponibilidad']) : null,
      emprendedor: json['emprendedor'] != null ? EmprendedorDetalleModel.fromJson(json['emprendedor']) : null,
      categoria: json['categoria'] != null ? CategoriaDetalleModel.fromJson(json['categoria']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'descripcion': descripcion,
      'precio_referencial': precioReferencial,
      'ubicacion_referencia': ubicacionReferencia,
      'estado': estado,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'ubicacion': ubicacion?.toJson(),
      'disponibilidad': disponibilidad?.toJson(),
      'emprendedor': emprendedor?.toJson(),
      'categoria': categoria?.toJson(),
    };
  }
}

class UbicacionModel {
  final double latitud;
  final double longitud;
  final String direccion;
  final String? referencia;

  UbicacionModel({
    required this.latitud,
    required this.longitud,
    required this.direccion,
    this.referencia,
  });

  factory UbicacionModel.fromJson(Map<String, dynamic> json) {
    return UbicacionModel(
      latitud: (json['latitud'] ?? 0).toDouble(),
      longitud: (json['longitud'] ?? 0).toDouble(),
      direccion: json['direccion'] ?? '',
      referencia: json['referencia'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'latitud': latitud,
      'longitud': longitud,
      'direccion': direccion,
      'referencia': referencia,
    };
  }
}

class DisponibilidadModel {
  final bool disponible;
  final String? horario;
  final String? diasDisponibles;
  final String? notas;

  DisponibilidadModel({
    required this.disponible,
    this.horario,
    this.diasDisponibles,
    this.notas,
  });

  factory DisponibilidadModel.fromJson(Map<String, dynamic> json) {
    return DisponibilidadModel(
      disponible: json['disponible'] ?? false,
      horario: json['horario'],
      diasDisponibles: json['dias_disponibles'],
      notas: json['notas'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'disponible': disponible,
      'horario': horario,
      'dias_disponibles': diasDisponibles,
      'notas': notas,
    };
  }
}

class EmprendedorDetalleModel {
  final int id;
  final String nombre;
  final String descripcion;
  final String telefono;
  final String email;
  final String? sitioWeb;
  final String? redesSociales;

  EmprendedorDetalleModel({
    required this.id,
    required this.nombre,
    required this.descripcion,
    required this.telefono,
    required this.email,
    this.sitioWeb,
    this.redesSociales,
  });

  factory EmprendedorDetalleModel.fromJson(Map<String, dynamic> json) {
    return EmprendedorDetalleModel(
      id: json['id'],
      nombre: json['nombre'] ?? '',
      descripcion: json['descripcion'] ?? '',
      telefono: json['telefono'] ?? '',
      email: json['email'] ?? '',
      sitioWeb: json['sitio_web'],
      redesSociales: json['redes_sociales'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'descripcion': descripcion,
      'telefono': telefono,
      'email': email,
      'sitio_web': sitioWeb,
      'redes_sociales': redesSociales,
    };
  }
}

class CategoriaDetalleModel {
  final int id;
  final String nombre;
  final String descripcion;
  final String? icono;

  CategoriaDetalleModel({
    required this.id,
    required this.nombre,
    required this.descripcion,
    this.icono,
  });

  factory CategoriaDetalleModel.fromJson(Map<String, dynamic> json) {
    return CategoriaDetalleModel(
      id: json['id'],
      nombre: json['nombre'] ?? '',
      descripcion: json['descripcion'] ?? '',
      icono: json['icono'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'descripcion': descripcion,
      'icono': icono,
    };
  }
} 