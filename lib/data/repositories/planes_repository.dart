import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/plan_model.dart';
import '../../core/constants/api_config.dart';

class PlanesRepository {
  Future<List<PlanModel>> getPlanesPublicos() async {
    try {
      final response = await http.get(
        Uri.parse('${ApiConfig.baseUrl}/planes/publicos'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((json) => PlanModel.fromJson(json)).toList();
      } else {
        throw Exception('Error al cargar planes: ${response.statusCode}');
      }
    } catch (e) {
      // Si hay error de conexión, retornar datos de prueba
      print('Error de conexión: $e');
      print('Retornando datos de prueba...');
      return _getPlanesDePrueba();
    }
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
        final Map<String, dynamic> jsonData = json.decode(response.body);
        return PlanModel.fromJson(jsonData);
      } else {
        throw Exception('Error al cargar plan: ${response.statusCode}');
      }
    } catch (e) {
      // Si hay error de conexión, retornar un plan de prueba
      print('Error de conexión: $e');
      print('Retornando plan de prueba...');
      return _getPlanesDePrueba().firstWhere((plan) => plan.id == id, 
        orElse: () => _getPlanesDePrueba().first);
    }
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
