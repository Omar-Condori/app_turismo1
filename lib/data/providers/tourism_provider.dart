import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/emprendimiento_model.dart';
import '../models/servicio_model.dart';
import '../models/evento_model.dart';
import '../../core/constants/api_config.dart';

class TourismProvider {
  // Emprendimientos
  Future<List<EmprendimientoModel>> getEmprendimientos() async {
    try {
      final response = await http.get(
        Uri.parse('${ApiConfig.baseUrl}/emprendedores'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == true && data['data'] != null) {
          return (data['data']['data'] as List)
              .map((json) => EmprendimientoModel.fromJson(json))
              .toList();
        } else {
          throw Exception('No se pudieron cargar los emprendedores');
        }
      } else {
        throw Exception('Error al cargar emprendedores: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }

  Future<EmprendimientoModel> getEmprendimientoById(String id) async {
    try {
      final response = await http.get(
        Uri.parse('${ApiConfig.baseUrl}/emprendedores/$id'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == true && data['data'] != null) {
          return EmprendimientoModel.fromJson(data['data']);
        } else {
          throw Exception('No se pudo cargar el emprendedor');
        }
      } else {
        throw Exception('Error al cargar emprendedor: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }

  // Servicios
  Future<List<ServicioModel>> getServicios() async {
    try {
      final response = await http.get(
        Uri.parse('${ApiConfig.baseUrl}/servicios'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == true && data['data'] != null) {
          return (data['data']['data'] as List)
              .map((json) => ServicioModel.fromJson(json))
              .toList();
        } else {
          throw Exception('No se pudieron cargar los servicios');
        }
      } else {
        throw Exception('Error al cargar servicios: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }

  // Eventos
  Future<List<EventoModel>> getEventos() async {
    try {
      final response = await http.get(
        Uri.parse('${ApiConfig.baseUrl}/eventos'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == true && data['data'] != null) {
          return (data['data']['data'] as List)
              .map((json) => EventoModel.fromJson(json))
              .toList();
        } else {
          throw Exception('No se pudieron cargar los eventos');
        }
      } else {
        throw Exception('Error al cargar eventos: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }
}