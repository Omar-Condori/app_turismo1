import 'dart:convert';

class EmprendimientoModel {
  final int id;
  final String nombre;
  final String tipoServicio;
  final String descripcion;
  final String ubicacion;
  final String telefono;
  final String email;
  final String? paginaWeb;
  final String horarioAtencion;
  final String precioRango;
  final List<String> metodosPago;
  final int capacidadAforo;
  final int numeroPersonasAtiende;
  final String comentariosResenas;
  final List<String> imagenes;
  final String categoria;
  final String certificaciones;
  final String idiomasHablados;
  final String opcionesAcceso;
  final bool facilidadesDiscapacidad;
  final bool estado;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int? asociacionId;
  final AsociacionModel? asociacion;
  final List<dynamic> slidersPrincipales;
  final List<dynamic> slidersSecundarios;

  EmprendimientoModel({
    required this.id,
    required this.nombre,
    required this.tipoServicio,
    required this.descripcion,
    required this.ubicacion,
    required this.telefono,
    required this.email,
    this.paginaWeb,
    required this.horarioAtencion,
    required this.precioRango,
    required this.metodosPago,
    required this.capacidadAforo,
    required this.numeroPersonasAtiende,
    required this.comentariosResenas,
    required this.imagenes,
    required this.categoria,
    required this.certificaciones,
    required this.idiomasHablados,
    required this.opcionesAcceso,
    required this.facilidadesDiscapacidad,
    required this.estado,
    required this.createdAt,
    required this.updatedAt,
    this.asociacionId,
    this.asociacion,
    this.slidersPrincipales = const [],
    this.slidersSecundarios = const [],
  });

  factory EmprendimientoModel.fromJson(Map<String, dynamic> json) {
    return EmprendimientoModel(
      id: json['id'],
      nombre: json['nombre'] ?? '',
      tipoServicio: json['tipo_servicio'] ?? '',
      descripcion: json['descripcion'] ?? '',
      ubicacion: json['ubicacion'] ?? '',
      telefono: json['telefono'] ?? '',
      email: json['email'] ?? '',
      paginaWeb: json['pagina_web'],
      horarioAtencion: json['horario_atencion'] ?? '',
      precioRango: json['precio_rango'] ?? '',
      metodosPago: _parseMetodosPago(json['metodos_pago']),
      capacidadAforo: json['capacidad_aforo'] ?? 0,
      numeroPersonasAtiende: json['numero_personas_atiende'] ?? 0,
      comentariosResenas: json['comentarios_resenas'] ?? '',
      imagenes: _parseImagenes(json['imagenes']),
      categoria: json['categoria'] ?? '',
      certificaciones: json['certificaciones'] ?? '',
      idiomasHablados: json['idiomas_hablados'] ?? '',
      opcionesAcceso: json['opciones_acceso'] ?? '',
      facilidadesDiscapacidad: json['facilidades_discapacidad'] ?? false,
      estado: json['estado'] ?? true,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      asociacionId: json['asociacion_id'],
      asociacion: json['asociacion'] != null 
          ? AsociacionModel.fromJson(json['asociacion']) 
          : null,
      slidersPrincipales: json['sliders_principales'] ?? [],
      slidersSecundarios: json['sliders_secundarios'] ?? [],
    );
  }

  static List<String> _parseMetodosPago(dynamic metodosPago) {
    if (metodosPago == null) return [];
    if (metodosPago is String) {
      try {
        final List<dynamic> parsed = json.decode(metodosPago);
        return parsed.map((e) => e.toString()).toList();
      } catch (e) {
        return [];
      }
    }
    if (metodosPago is List) {
      return metodosPago.map((e) => e.toString()).toList();
    }
    return [];
  }

  static List<String> _parseImagenes(dynamic imagenes) {
    if (imagenes == null) return [];
    if (imagenes is String) {
      try {
        final List<dynamic> parsed = json.decode(imagenes);
        return parsed.map((e) => e.toString()).toList();
      } catch (e) {
        return [];
      }
    }
    if (imagenes is List) {
      return imagenes.map((e) => e.toString()).toList();
    }
    return [];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'tipo_servicio': tipoServicio,
      'descripcion': descripcion,
      'ubicacion': ubicacion,
      'telefono': telefono,
      'email': email,
      'pagina_web': paginaWeb,
      'horario_atencion': horarioAtencion,
      'precio_rango': precioRango,
      'metodos_pago': json.encode(metodosPago),
      'capacidad_aforo': capacidadAforo,
      'numero_personas_atiende': numeroPersonasAtiende,
      'comentarios_resenas': comentariosResenas,
      'imagenes': json.encode(imagenes),
      'categoria': categoria,
      'certificaciones': certificaciones,
      'idiomas_hablados': idiomasHablados,
      'opciones_acceso': opcionesAcceso,
      'facilidades_discapacidad': facilidadesDiscapacidad,
      'estado': estado,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'asociacion_id': asociacionId,
      'asociacion': asociacion?.toJson(),
      'sliders_principales': slidersPrincipales,
      'sliders_secundarios': slidersSecundarios,
    };
  }
}

class AsociacionModel {
  final int id;
  final String nombre;
  final String descripcion;
  final String telefono;
  final String email;
  final int municipalidadId;
  final bool estado;
  final DateTime createdAt;
  final DateTime updatedAt;
  final double latitud;
  final double longitud;
  final String imagen;
  final String imagenUrl;

  AsociacionModel({
    required this.id,
    required this.nombre,
    required this.descripcion,
    required this.telefono,
    required this.email,
    required this.municipalidadId,
    required this.estado,
    required this.createdAt,
    required this.updatedAt,
    required this.latitud,
    required this.longitud,
    required this.imagen,
    required this.imagenUrl,
  });

  factory AsociacionModel.fromJson(Map<String, dynamic> json) {
    return AsociacionModel(
      id: json['id'],
      nombre: json['nombre'] ?? '',
      descripcion: json['descripcion'] ?? '',
      telefono: json['telefono'] ?? '',
      email: json['email'] ?? '',
      municipalidadId: json['municipalidad_id'] ?? 0,
      estado: json['estado'] ?? true,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      latitud: (json['latitud'] ?? 0.0).toDouble(),
      longitud: (json['longitud'] ?? 0.0).toDouble(),
      imagen: json['imagen'] ?? '',
      imagenUrl: json['imagen_url'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'descripcion': descripcion,
      'telefono': telefono,
      'email': email,
      'municipalidad_id': municipalidadId,
      'estado': estado,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'latitud': latitud,
      'longitud': longitud,
      'imagen': imagen,
      'imagen_url': imagenUrl,
    };
  }
}