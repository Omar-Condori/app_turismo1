import '../providers/tourism_provider.dart';
import '../models/emprendimiento_model.dart';
import '../models/servicio_model.dart';
import '../models/evento_model.dart';

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
    try {
      final emprendimientos = await getEmprendimientos();
      return emprendimientos
          .where((e) => e.name.toLowerCase().contains(query.toLowerCase()) ||
          e.description.toLowerCase().contains(query.toLowerCase()))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<ServicioModel>> getServiciosByCategory(String category) async {
    try {
      final servicios = await getServicios();
      return servicios.where((s) => 
        s.categorias.any((c) => c['nombre']?.toLowerCase() == category.toLowerCase())
      ).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<ServicioModel>> searchServicios(String query) async {
    try {
      final servicios = await getServicios();
      return servicios
          .where((s) => s.nombre.toLowerCase().contains(query.toLowerCase()) ||
              s.descripcion.toLowerCase().contains(query.toLowerCase()))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<EventoModel>> searchEventos(String query) async {
    try {
      final eventos = await getEventos();
      return eventos
          .where((e) => e.name.toLowerCase().contains(query.toLowerCase()) ||
              e.description.toLowerCase().contains(query.toLowerCase()))
          .toList();
    } catch (e) {
      rethrow;
    }
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
}