import '../providers/tourism_provider.dart';
import '../models/emprendimiento_model.dart';
import '../models/servicio_model.dart';
import '../models/evento_model.dart';
import '../models/municipalidad_model.dart';
import '../../core/constants/api_config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TourismRepository {
  final TourismProvider _tourismProvider;

  TourismRepository(this._tourismProvider);

  Future<List<EmprendimientoModel>> getEmprendimientos() async {
    try {
      return await _tourismProvider.getEmprendimientos();
    } catch (e) {
      rethrow;
    }
  }

  Future<EmprendimientoModel> getEmprendimientoById(String id) async {
    try {
      return await _tourismProvider.getEmprendimientoById(id);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<ServicioModel>> getServicios() async {
    try {
      return await _tourismProvider.getServicios();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<EventoModel>> getEventos() async {
    try {
      return await _tourismProvider.getEventos();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<EmprendimientoModel>> searchEmprendimientos(String query) async {
    if (query.isEmpty) return [];
    final emprendimientos = await getEmprendimientos();
    return emprendimientos
        .where((e) => e.nombre.toLowerCase().contains(query.toLowerCase()) ||
        e.descripcion.toLowerCase().contains(query.toLowerCase()) ||
        e.tipoServicio.toLowerCase().contains(query.toLowerCase()) ||
        e.categoria.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  Future<List<ServicioModel>> getServiciosByCategory(String category) async {
    try {
      final servicios = await getServicios();
      return servicios.where((s) => 
        s.categorias.any((c) => c.nombre.toLowerCase() == category.toLowerCase())
      ).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<ServicioModel>> searchServicios(String query) async {
    if (query.isEmpty) return [];
    final servicios = await getServicios();
    return servicios
        .where((s) => s.nombre.toLowerCase().contains(query.toLowerCase()) ||
            s.descripcion.toLowerCase().contains(query.toLowerCase()) ||
            s.categorias.any((c) => c.nombre.toLowerCase().contains(query.toLowerCase())))
        .toList();
  }

  Future<List<EventoModel>> searchEventos(String query) async {
    if (query.isEmpty) return [];
    final eventos = await getEventos();
    return eventos
        .where((e) => e.nombre.toLowerCase().contains(query.toLowerCase()) ||
            e.descripcion.toLowerCase().contains(query.toLowerCase()) ||
            e.categoria.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  Future<List<EventoModel>> getUpcomingEventos() async {
    try {
      final eventos = await getEventos();
      final now = DateTime.now();
      return eventos
          .where((e) => e.startDate.isAfter(now) && e.isActive)
          .toList()
        ..sort((a, b) => a.startDate.compareTo(b.startDate));
    } catch (e) {
      rethrow;
    }
  }

  Future<MunicipalidadModel?> getMunicipalidad() async {
    try {
      final response = await http.get(
        Uri.parse('${ApiConfig.baseUrl}/municipalidad'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        
        if (jsonResponse['success'] == true && jsonResponse['data'] != null && jsonResponse['data'].isNotEmpty) {
          return MunicipalidadModel.fromJson(jsonResponse['data'][0]);
        } else {
          print('No se encontraron datos válidos en la respuesta');
          return null;
        }
      } else {
        print('Error en la respuesta: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error de conexión: $e');
      return null;
    }
  }
}