import 'dart:convert';

class EventoModel {
  final int id;
  final String nombre;
  final String descripcion;
  final String categoria;
  final String organizadorId;
  final String organizadorNombre;
  final String ubicacion;
  final double latitud;
  final double longitud;
  final DateTime fechaInicio;
  final DateTime fechaFin;
  final String? horaInicio;
  final String? horaFin;
  final double? precio;
  final String moneda;
  final List<String> imagenes;
  final List<String> etiquetas;
  final int capacidad;
  final int registrados;
  final bool requiereRegistro;
  final bool estado;
  final DateTime createdAt;
  final DateTime updatedAt;

  EventoModel({
    required this.id,
    required this.nombre,
    required this.descripcion,
    required this.categoria,
    required this.organizadorId,
    required this.organizadorNombre,
    required this.ubicacion,
    required this.latitud,
    required this.longitud,
    required this.fechaInicio,
    required this.fechaFin,
    this.horaInicio,
    this.horaFin,
    this.precio,
    this.moneda = 'PEN',
    this.imagenes = const [],
    this.etiquetas = const [],
    this.capacidad = 0,
    this.registrados = 0,
    this.requiereRegistro = false,
    this.estado = true,
    required this.createdAt,
    required this.updatedAt,
  });

  factory EventoModel.fromJson(Map<String, dynamic> json) {
    return EventoModel(
      id: json['id'],
      nombre: json['nombre'] ?? '',
      descripcion: json['descripcion'] ?? '',
      categoria: json['categoria'] ?? '',
      organizadorId: json['organizador_id'] ?? '',
      organizadorNombre: json['organizador_nombre'] ?? '',
      ubicacion: json['ubicacion'] ?? '',
      latitud: (json['latitud'] ?? 0.0).toDouble(),
      longitud: (json['longitud'] ?? 0.0).toDouble(),
      fechaInicio: DateTime.parse(json['fecha_inicio'] ?? DateTime.now().toIso8601String()),
      fechaFin: DateTime.parse(json['fecha_fin'] ?? DateTime.now().toIso8601String()),
      horaInicio: json['hora_inicio'],
      horaFin: json['hora_fin'],
      precio: json['precio']?.toDouble(),
      moneda: json['moneda'] ?? 'PEN',
      imagenes: _parseImagenes(json['imagenes']),
      etiquetas: _parseEtiquetas(json['etiquetas']),
      capacidad: json['capacidad'] ?? 0,
      registrados: json['registrados'] ?? 0,
      requiereRegistro: json['requiere_registro'] ?? false,
      estado: json['estado'] ?? true,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
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

  static List<String> _parseEtiquetas(dynamic etiquetas) {
    if (etiquetas == null) return [];
    if (etiquetas is String) {
      try {
        final List<dynamic> parsed = json.decode(etiquetas);
        return parsed.map((e) => e.toString()).toList();
      } catch (e) {
        return [];
      }
    }
    if (etiquetas is List) {
      return etiquetas.map((e) => e.toString()).toList();
    }
    return [];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'descripcion': descripcion,
      'categoria': categoria,
      'organizador_id': organizadorId,
      'organizador_nombre': organizadorNombre,
      'ubicacion': ubicacion,
      'latitud': latitud,
      'longitud': longitud,
      'fecha_inicio': fechaInicio.toIso8601String(),
      'fecha_fin': fechaFin.toIso8601String(),
      'hora_inicio': horaInicio,
      'hora_fin': horaFin,
      'precio': precio,
      'moneda': moneda,
      'imagenes': json.encode(imagenes),
      'etiquetas': json.encode(etiquetas),
      'capacidad': capacidad,
      'registrados': registrados,
      'requiere_registro': requiereRegistro,
      'estado': estado,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  // Getters para compatibilidad con el código existente
  String get name => nombre;
  String get description => descripcion;
  String get category => categoria;
  String get organizerId => organizadorId;
  String get organizerName => organizadorNombre;
  String get location => ubicacion;
  double get latitude => latitud;
  double get longitude => longitud;
  DateTime get startDate => fechaInicio;
  DateTime get endDate => fechaFin;
  String? get startTime => horaInicio;
  String? get endTime => horaFin;
  double? get price => precio;
  String get currency => moneda;
  List<String> get images => imagenes;
  List<String> get tags => etiquetas;
  int get capacity => capacidad;
  int get registeredCount => registrados;
  bool get requiresRegistration => requiereRegistro;
  bool get isActive => estado;
}