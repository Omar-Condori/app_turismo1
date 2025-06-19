import '../models/reserva_model.dart';
import '../../core/constants/api_config.dart';
import '../../core/services/storage_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ReservasRepository {
  final StorageService _storageService;

  ReservasRepository(this._storageService);

  Future<List<ReservaModel>> getMisReservas() async {
    try {
      // Obtener el token de autenticación
      final token = await _storageService.getToken();
      
      if (token == null) {
        throw Exception('No hay token de autenticación');
      }

      final response = await http.get(
        Uri.parse('${ApiConfig.baseUrl}/reservas/mis-reservas'),
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
          final List<dynamic> reservasData = jsonResponse['data'];
          return reservasData.map((json) => ReservaModel.fromJson(json)).toList();
        } else {
          print('No se encontraron datos válidos en la respuesta');
          return [];
        }
      } else if (response.statusCode == 401) {
        throw Exception('No autorizado. Por favor, inicia sesión nuevamente.');
      } else {
        print('Error en la respuesta: ${response.statusCode}');
        print('Error body: ${response.body}');
        throw Exception('Error al cargar las reservas');
      }
    } catch (e) {
      print('Error de conexión: $e');
      rethrow;
    }
  }

  Future<ReservaModel?> getReservaById(int reservaId) async {
    try {
      final token = await _storageService.getToken();
      
      if (token == null) {
        throw Exception('No hay token de autenticación');
      }

      final response = await http.get(
        Uri.parse('${ApiConfig.baseUrl}/reservas/$reservaId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        
        if (jsonResponse['success'] == true && jsonResponse['data'] != null) {
          return ReservaModel.fromJson(jsonResponse['data']);
        } else {
          print('No se encontraron datos válidos en la respuesta');
          return null;
        }
      } else if (response.statusCode == 401) {
        throw Exception('No autorizado. Por favor, inicia sesión nuevamente.');
      } else {
        print('Error en la respuesta: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error de conexión: $e');
      rethrow;
    }
  }

  Future<bool> cancelarReserva(int reservaId) async {
    try {
      final token = await _storageService.getToken();
      
      if (token == null) {
        throw Exception('No hay token de autenticación');
      }

      final response = await http.put(
        Uri.parse('${ApiConfig.baseUrl}/reservas/$reservaId/cancelar'),
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