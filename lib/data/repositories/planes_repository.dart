import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/plan_model.dart';
import '../../core/constants/api_config.dart';

class PlanesRepository {
  Future<List<PlanModel>> getPlanes() async {
    try {
      final response = await http.get(
        Uri.parse('${ApiConfig.baseUrl}/planes'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        
        if (jsonResponse['success'] == true && jsonResponse['data'] != null) {
          final List<dynamic> planesData = jsonResponse['data']['data'] ?? [];
          return planesData.map((json) => PlanModel.fromJson(json)).toList();
        } else {
          print('No se encontraron datos válidos en la respuesta');
          return [];
        }
      } else {
        print('Error en la respuesta: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error de conexión: $e');
      print('Retornando datos de prueba...');
      return _getPlanesDePrueba();
    }
  }

  Future<List<PlanModel>> searchPlanes(String query) async {
    if (query.isEmpty) return [];
    final planes = await getPlanes();
    return planes
        .where((p) => p.nombre.toLowerCase().contains(query.toLowerCase()) ||
            p.descripcion.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  Future<PlanModel> getPlanPorId(int id) async {
    try {
      final response = await http.get(
        Uri.parse('${ApiConfig.baseUrl}/planes/$id'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        
        if (jsonResponse['success'] == true && jsonResponse['data'] != null) {
          return PlanModel.fromJson(jsonResponse['data']);
        } else {
          throw Exception('No se encontraron datos válidos');
        }
      } else {
        throw Exception('Error al cargar plan: ${response.statusCode}');
      }
    } catch (e) {
      print('Error de conexión: $e');
      print('Retornando plan de prueba...');
      return _getPlanesDePrueba().firstWhere((plan) => plan.id == id, 
        orElse: () => _getPlanesDePrueba().first);
    }
  }

  // Método para compatibilidad con código existente
  Future<List<PlanModel>> getPlanesPublicos() async {
    return getPlanes();
  }

  // Datos de prueba para cuando el API no esté disponible
  List<PlanModel> _getPlanesDePrueba() {
    return [
      PlanModel(
        id: 1,
        nombre: 'Plan Básico Capachica',
        descripcion: 'Disfruta de una experiencia básica en Capachica con visitas a los principales atractivos turísticos.',
        precio: 150.0,
        duracion: '1 día',
        caracteristicas: [
          'Guía turístico local',
          'Transporte desde Puno',
          'Almuerzo típico',
          'Visita a miradores',
          'Fotos profesionales',
        ],
        activo: true,
        fechaCreacion: DateTime.now(),
      ),
      PlanModel(
        id: 2,
        nombre: 'Plan Completo Capachica',
        descripcion: 'Vive la experiencia completa de Capachica con todas las actividades y servicios incluidos.',
        precio: 350.0,
        duracion: '2 días',
        caracteristicas: [
          'Guía turístico especializado',
          'Transporte privado',
          'Hospedaje en comunidad local',
          '3 comidas incluidas',
          'Actividades culturales',
          'Visita a islas flotantes',
          'Paseo en bote tradicional',
          'Taller de artesanías',
        ],
        activo: true,
        fechaCreacion: DateTime.now(),
      ),
      PlanModel(
        id: 3,
        nombre: 'Plan Premium Capachica',
        descripcion: 'La experiencia más exclusiva en Capachica con servicios premium y atención personalizada.',
        precio: 650.0,
        duracion: '3 días',
        caracteristicas: [
          'Guía turístico exclusivo',
          'Transporte de lujo',
          'Hospedaje premium',
          'Gastronomía gourmet',
          'Actividades exclusivas',
          'Visita privada a sitios arqueológicos',
          'Experiencia con comunidades',
          'Spa y masajes tradicionales',
          'Fotografía profesional completa',
          'Souvenirs artesanales',
        ],
        activo: true,
        fechaCreacion: DateTime.now(),
      ),
      PlanModel(
        id: 4,
        nombre: 'Plan Familiar Capachica',
        descripcion: 'Ideal para familias que quieren conocer Capachica de manera divertida y educativa.',
        precio: 280.0,
        duracion: '1 día',
        caracteristicas: [
          'Guía especializado en turismo familiar',
          'Transporte familiar',
          'Almuerzo familiar',
          'Actividades para niños',
          'Visita a granjas educativas',
          'Talleres de manualidades',
          'Juegos tradicionales',
          'Fotos familiares',
        ],
        activo: true,
        fechaCreacion: DateTime.now(),
      ),
    ];
  }
}
