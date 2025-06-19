import 'dart:convert';
import 'emprendimiento_model.dart';

class ServicioModel {
  final int id;
  final String nombre;
  final String descripcion;
  final String precioReferencial;
  final int emprendedorId;
  final bool estado;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int capacidad;
  final String latitud;
  final String longitud;
  final String ubicacionReferencia;
  final EmprendimientoModel? emprendedor;
  final List<CategoriaModel> categorias;
  final List<HorarioModel> horarios;
  final List<dynamic> sliders;

  ServicioModel({
    required this.id,
    required this.nombre,
    required this.descripcion,
    required this.precioReferencial,
    required this.emprendedorId,
    required this.estado,
    required this.createdAt,
    required this.updatedAt,
    required this.capacidad,
    required this.latitud,
    required this.longitud,
    required this.ubicacionReferencia,
    this.emprendedor,
    this.categorias = const [],
    this.horarios = const [],
    this.sliders = const [],
  });

  factory ServicioModel.fromJson(Map<String, dynamic> json) {
    return ServicioModel(
      id: json['id'],
      nombre: json['nombre'] ?? '',
      descripcion: json['descripcion'] ?? '',
      precioReferencial: json['precio_referencial'] ?? '0.00',
      emprendedorId: json['emprendedor_id'] ?? 0,
      estado: json['estado'] ?? true,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      capacidad: json['capacidad'] ?? 1,
      latitud: json['latitud'] ?? '0.0',
      longitud: json['longitud'] ?? '0.0',
      ubicacionReferencia: json['ubicacion_referencia'] ?? '',
      emprendedor: json['emprendedor'] != null 
          ? EmprendimientoModel.fromJson(json['emprendedor']) 
          : null,
      categorias: json['categorias'] != null 
          ? (json['categorias'] as List).map((c) => CategoriaModel.fromJson(c)).toList()
          : [],
      horarios: json['horarios'] != null 
          ? (json['horarios'] as List).map((h) => HorarioModel.fromJson(h)).toList()
          : [],
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
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'capacidad': capacidad,
      'latitud': latitud,
      'longitud': longitud,
      'ubicacion_referencia': ubicacionReferencia,
      'emprendedor': emprendedor?.toJson(),
      'categorias': categorias.map((c) => c.toJson()).toList(),
      'horarios': horarios.map((h) => h.toJson()).toList(),
      'sliders': sliders,
    };
  }
}

class CategoriaModel {
  final int id;
  final String nombre;
  final String descripcion;
  final String iconoUrl;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Map<String, dynamic>? pivot;

  CategoriaModel({
    required this.id,
    required this.nombre,
    required this.descripcion,
    required this.iconoUrl,
    required this.createdAt,
    required this.updatedAt,
    this.pivot,
  });

  factory CategoriaModel.fromJson(Map<String, dynamic> json) {
    return CategoriaModel(
      id: json['id'],
      nombre: json['nombre'] ?? '',
      descripcion: json['descripcion'] ?? '',
      iconoUrl: json['icono_url'] ?? '',
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      pivot: json['pivot'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'descripcion': descripcion,
      'icono_url': iconoUrl,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'pivot': pivot,
    };
  }
}

class HorarioModel {
  final int id;
  final int servicioId;
  final String diaSemana;
  final String horaInicio;
  final String horaFin;
  final bool activo;
  final DateTime createdAt;
  final DateTime updatedAt;

  HorarioModel({
    required this.id,
    required this.servicioId,
    required this.diaSemana,
    required this.horaInicio,
    required this.horaFin,
    required this.activo,
    required this.createdAt,
    required this.updatedAt,
  });

  factory HorarioModel.fromJson(Map<String, dynamic> json) {
    return HorarioModel(
      id: json['id'],
      servicioId: json['servicio_id'],
      diaSemana: json['dia_semana'] ?? '',
      horaInicio: json['hora_inicio'] ?? '',
      horaFin: json['hora_fin'] ?? '',
      activo: json['activo'] ?? true,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'servicio_id': servicioId,
      'dia_semana': diaSemana,
      'hora_inicio': horaInicio,
      'hora_fin': horaFin,
      'activo': activo,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}