import 'dart:convert';

class CarritoModel {
  final int id;
  final int userId;
  final List<CarritoItemModel> items;
  final String total;
  final int cantidadItems;
  final DateTime createdAt;
  final DateTime updatedAt;

  CarritoModel({
    required this.id,
    required this.userId,
    required this.items,
    required this.total,
    required this.cantidadItems,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CarritoModel.fromJson(Map<String, dynamic> json) {
    return CarritoModel(
      id: json['id'],
      userId: json['user_id'] ?? 0,
      items: json['items'] != null 
          ? (json['items'] as List).map((item) => CarritoItemModel.fromJson(item)).toList()
          : [],
      total: json['total'] ?? '0.00',
      cantidadItems: json['cantidad_items'] ?? 0,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'items': items.map((item) => item.toJson()).toList(),
      'total': total,
      'cantidad_items': cantidadItems,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  // Método para verificar si el carrito está vacío
  bool get estaVacio => items.isEmpty;

  // Método para obtener el total como double
  double get totalDouble => double.tryParse(total) ?? 0.0;
}

class CarritoItemModel {
  final int id;
  final int carritoId;
  final int servicioId;
  final int cantidad;
  final String precioUnitario;
  final String subtotal;
  final DateTime createdAt;
  final DateTime updatedAt;
  final ServicioCarritoModel? servicio;

  CarritoItemModel({
    required this.id,
    required this.carritoId,
    required this.servicioId,
    required this.cantidad,
    required this.precioUnitario,
    required this.subtotal,
    required this.createdAt,
    required this.updatedAt,
    this.servicio,
  });

  factory CarritoItemModel.fromJson(Map<String, dynamic> json) {
    return CarritoItemModel(
      id: json['id'],
      carritoId: json['carrito_id'] ?? 0,
      servicioId: json['servicio_id'] ?? 0,
      cantidad: json['cantidad'] ?? 1,
      precioUnitario: json['precio_unitario'] ?? '0.00',
      subtotal: json['subtotal'] ?? '0.00',
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      servicio: json['servicio'] != null 
          ? ServicioCarritoModel.fromJson(json['servicio']) 
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'carrito_id': carritoId,
      'servicio_id': servicioId,
      'cantidad': cantidad,
      'precio_unitario': precioUnitario,
      'subtotal': subtotal,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'servicio': servicio?.toJson(),
    };
  }

  // Método para obtener el precio unitario como double
  double get precioUnitarioDouble => double.tryParse(precioUnitario) ?? 0.0;

  // Método para obtener el subtotal como double
  double get subtotalDouble => double.tryParse(subtotal) ?? 0.0;
}

class ServicioCarritoModel {
  final int id;
  final String nombre;
  final String descripcion;
  final String precioReferencial;
  final String? imagenUrl;
  final EmprendimientoCarritoModel? emprendedor;

  ServicioCarritoModel({
    required this.id,
    required this.nombre,
    required this.descripcion,
    required this.precioReferencial,
    this.imagenUrl,
    this.emprendedor,
  });

  factory ServicioCarritoModel.fromJson(Map<String, dynamic> json) {
    return ServicioCarritoModel(
      id: json['id'],
      nombre: json['nombre'] ?? '',
      descripcion: json['descripcion'] ?? '',
      precioReferencial: json['precio_referencial'] ?? '0.00',
      imagenUrl: json['imagen_url'],
      emprendedor: json['emprendedor'] != null 
          ? EmprendimientoCarritoModel.fromJson(json['emprendedor']) 
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

class EmprendimientoCarritoModel {
  final int id;
  final String nombre;
  final String descripcion;
  final String? imagenUrl;

  EmprendimientoCarritoModel({
    required this.id,
    required this.nombre,
    required this.descripcion,
    this.imagenUrl,
  });

  factory EmprendimientoCarritoModel.fromJson(Map<String, dynamic> json) {
    return EmprendimientoCarritoModel(
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