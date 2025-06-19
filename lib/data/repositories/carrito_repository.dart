import '../models/carrito_model.dart';
import '../../core/constants/api_config.dart';
import '../../core/services/storage_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CarritoRepository {
  final StorageService _storageService;

  CarritoRepository(this._storageService);

  Future<CarritoModel?> getCarrito() async {
    try {
      // Obtener el token de autenticación
      final token = await _storageService.getToken();
      
      if (token == null) {
        throw Exception('No hay token de autenticación');
      }

      final response = await http.get(
        Uri.parse('${ApiConfig.baseUrl}/reservas/carrito'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      print('Status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        
        if (jsonResponse['success'] == true && jsonResponse['data'] != null) {
          return CarritoModel.fromJson(jsonResponse['data']);
        } else {
          print('No se encontraron datos válidos en la respuesta');
          return null;
        }
      } else if (response.statusCode == 401) {
        throw Exception('No autorizado. Por favor, inicia sesión nuevamente.');
      } else {
        print('Error en la respuesta: ${response.statusCode}');
        print('Error body: ${response.body}');
        throw Exception('Error al cargar el carrito');
      }
    } catch (e) {
      print('Error de conexión: $e');
      rethrow;
    }
  }

  Future<bool> agregarAlCarrito(int servicioId, int cantidad) async {
    try {
      final token = await _storageService.getToken();
      
      if (token == null) {
        throw Exception('No hay token de autenticación');
      }

      final response = await http.post(
        Uri.parse('${ApiConfig.baseUrl}/reservas/carrito/agregar'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'servicio_id': servicioId,
          'cantidad': cantidad,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        return jsonResponse['success'] == true;
      } else if (response.statusCode == 401) {
        throw Exception('No autorizado. Por favor, inicia sesión nuevamente.');
      } else {
        print('Error en la respuesta: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Error de conexión: $e');
      rethrow;
    }
  }

  Future<bool> actualizarCantidad(int itemId, int cantidad) async {
    try {
      final token = await _storageService.getToken();
      
      if (token == null) {
        throw Exception('No hay token de autenticación');
      }

      final response = await http.put(
        Uri.parse('${ApiConfig.baseUrl}/reservas/carrito/actualizar'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'item_id': itemId,
          'cantidad': cantidad,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        return jsonResponse['success'] == true;
      } else if (response.statusCode == 401) {
        throw Exception('No autorizado. Por favor, inicia sesión nuevamente.');
      } else {
        print('Error en la respuesta: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Error de conexión: $e');
      rethrow;
    }
  }

  Future<bool> eliminarDelCarrito(int itemId) async {
    try {
      final token = await _storageService.getToken();
      
      if (token == null) {
        throw Exception('No hay token de autenticación');
      }

      final response = await http.delete(
        Uri.parse('${ApiConfig.baseUrl}/reservas/carrito/eliminar/$itemId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        return jsonResponse['success'] == true;
      } else if (response.statusCode == 401) {
        throw Exception('No autorizado. Por favor, inicia sesión nuevamente.');
      } else {
        print('Error en la respuesta: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Error de conexión: $e');
      rethrow;
    }
  }

  Future<bool> limpiarCarrito() async {
    try {
      final token = await _storageService.getToken();
      
      if (token == null) {
        throw Exception('No hay token de autenticación');
      }

      final response = await http.delete(
        Uri.parse('${ApiConfig.baseUrl}/reservas/carrito/limpiar'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        return jsonResponse['success'] == true;
      } else if (response.statusCode == 401) {
        throw Exception('No autorizado. Por favor, inicia sesión nuevamente.');
      } else {
        print('Error en la respuesta: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Error de conexión: $e');
      rethrow;
    }
  }
} 