import 'dart:convert';

class ReservaModel {
  final int id;
  final int userId;
  final int servicioId;
  final String fechaReserva;
  final String horaReserva;
  final int cantidadPersonas;
  final String estado;
  final String? observaciones;
  final DateTime createdAt;
  final DateTime updatedAt;
  final ServicioReservaModel? servicio;
  final UserReservaModel? usuario;

  ReservaModel({
    required this.id,
    required this.userId,
    required this.servicioId,
    required this.fechaReserva,
    required this.horaReserva,
    required this.cantidadPersonas,
    required this.estado,
    this.observaciones,
    required this.createdAt,
    required this.updatedAt,
    this.servicio,
    this.usuario,
  });

  factory ReservaModel.fromJson(Map<String, dynamic> json) {
    return ReservaModel(
      id: json['id'],
      userId: json['user_id'] ?? 0,
      servicioId: json['servicio_id'] ?? 0,
      fechaReserva: json['fecha_reserva'] ?? '',
      horaReserva: json['hora_reserva'] ?? '',
      cantidadPersonas: json['cantidad_personas'] ?? 1,
      estado: json['estado'] ?? 'pendiente',
      observaciones: json['observaciones'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      servicio: json['servicio'] != null 
          ? ServicioReservaModel.fromJson(json['servicio']) 
          : null,
      usuario: json['usuario'] != null 
          ? UserReservaModel.fromJson(json['usuario']) 
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'servicio_id': servicioId,
      'fecha_reserva': fechaReserva,
      'hora_reserva': horaReserva,
      'cantidad_personas': cantidadPersonas,
      'estado': estado,
      'observaciones': observaciones,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'servicio': servicio?.toJson(),
      'usuario': usuario?.toJson(),
    };
  }

  // Método para obtener el estado en español
  String get estadoEspanol {
    switch (estado.toLowerCase()) {
      case 'pending':
        return 'Pendiente';
      case 'confirmed':
        return 'Confirmada';
      case 'cancelled':
        return 'Cancelada';
      case 'completed':
        return 'Completada';
      default:
        return estado;
    }
  }

  // Método para obtener el color del estado
  String get estadoColor {
    switch (estado.toLowerCase()) {
      case 'pending':
        return '#FFA000'; // Naranja
      case 'confirmed':
        return '#4CAF50'; // Verde
      case 'cancelled':
        return '#F44336'; // Rojo
      case 'completed':
        return '#2196F3'; // Azul
      default:
        return '#757575'; // Gris
    }
  }
}

class ServicioReservaModel {
  final int id;
  final String nombre;
  final String descripcion;
  final String precioReferencial;
  final String? imagenUrl;
  final EmprendimientoReservaModel? emprendedor;

  ServicioReservaModel({
    required this.id,
    required this.nombre,
    required this.descripcion,
    required this.precioReferencial,
    this.imagenUrl,
    this.emprendedor,
  });

  factory ServicioReservaModel.fromJson(Map<String, dynamic> json) {
    return ServicioReservaModel(
      id: json['id'],
      nombre: json['nombre'] ?? '',
      descripcion: json['descripcion'] ?? '',
      precioReferencial: json['precio_referencial'] ?? '0.00',
      imagenUrl: json['imagen_url'],
      emprendedor: json['emprendedor'] != null 
          ? EmprendimientoReservaModel.fromJson(json['emprendedor']) 
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'descripcion': descripcion,
      'precio_referencial': precioReferencial,
      'imagen_url': imagenUrl,
      'emprendedor': emprendedor?.toJson(),
    };
  }
}

class EmprendimientoReservaModel {
  final int id;
  final String nombre;
  final String descripcion;
  final String? imagenUrl;

  EmprendimientoReservaModel({
    required this.id,
    required this.nombre,
    required this.descripcion,
    this.imagenUrl,
  });

  factory EmprendimientoReservaModel.fromJson(Map<String, dynamic> json) {
    return EmprendimientoReservaModel(
      id: json['id'],
      nombre: json['nombre'] ?? '',
      descripcion: json['descripcion'] ?? '',
      imagenUrl: json['imagen_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'descripcion': descripcion,
      'imagen_url': imagenUrl,
    };
  }
}

class UserReservaModel {
  final int id;
  final String nombre;
  final String email;
  final String? telefono;

  UserReservaModel({
    required this.id,
    required this.nombre,
    required this.email,
    this.telefono,
  });

  factory UserReservaModel.fromJson(Map<String, dynamic> json) {
    return UserReservaModel(
      id: json['id'],
      nombre: json['nombre'] ?? '',
      email: json['email'] ?? '',
      telefono: json['telefono'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'email': email,
      'telefono': telefono,
    };
  }
} 