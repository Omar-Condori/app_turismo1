import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/emprendimiento_model.dart';
import '../models/servicio_model.dart';
import '../models/evento_model.dart';

class TourismProvider {
  final String baseUrl = 'https://api.capachica-tourism.com';

  // Emprendimientos
  Future<List<EmprendimientoModel>> getEmprendimientos() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/emprendimientos'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return (data['emprendimientos'] as List)
            .map((json) => EmprendimientoModel.fromJson(json))
            .toList();
      } else {
        throw Exception('Error al cargar emprendimientos');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }

  Future<EmprendimientoModel> getEmprendimientoById(String id) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/emprendimientos/$id'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return EmprendimientoModel.fromJson(data['emprendimiento']);
      } else {
        throw Exception('Error al cargar emprendimiento');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }

  // Servicios
  Future<List<ServicioModel>> getServicios() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/servicios'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return (data['servicios'] as List)
            .map((json) => ServicioModel.fromJson(json))
            .toList();
      } else {
        throw Exception('Error al cargar servicios');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }

  // Eventos
  Future<List<EventoModel>> getEventos() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/eventos'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return (data['eventos'] as List)
            .map((json) => EventoModel.fromJson(json))
            .toList();
      } else {
        throw Exception('Error al cargar eventos');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }
}