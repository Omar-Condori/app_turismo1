import 'package:get/get.dart';
import '../../data/repositories/tourism_repository.dart';
import '../../data/models/servicio_detalle_model.dart';

class ServicioDetalleController extends GetxController {
  final TourismRepository _tourismRepository;

  ServicioDetalleController(this._tourismRepository);

  // Variables observables
  final Rx<ServicioDetalleModel?> servicioDetalle = Rx<ServicioDetalleModel?>(null);
  final Rx<UbicacionModel?> ubicacion = Rx<UbicacionModel?>(null);
  final Rx<DisponibilidadModel?> disponibilidad = Rx<DisponibilidadModel?>(null);
  final Rx<EmprendedorDetalleModel?> emprendedor = Rx<EmprendedorDetalleModel?>(null);
  final Rx<CategoriaDetalleModel?> categoria = Rx<CategoriaDetalleModel?>(null);
  
  final RxBool isLoading = false.obs;
  final RxBool isLoadingUbicacion = false.obs;
  final RxBool isLoadingDisponibilidad = false.obs;
  final RxBool isLoadingEmprendedor = false.obs;
  final RxBool isLoadingCategoria = false.obs;
  
  final RxString errorMessage = ''.obs;

  // Cargar detalles completos del servicio
  Future<void> loadServicioDetalle(int servicioId) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      print('Iniciando carga de detalles para servicio ID: $servicioId');

      // Cargar detalles principales del servicio
      final detalle = await _tourismRepository.getServicioDetalle(servicioId);
      if (detalle != null) {
        print('Detalles cargados exitosamente');
        servicioDetalle.value = detalle;
        
        // Cargar información adicional si es necesario
        if (detalle.emprendedor == null && servicioId > 0) {
          print('Cargando detalles del emprendedor...');
          await loadEmprendedorDetalle(servicioId);
        }
        
        if (detalle.categoria == null && servicioId > 0) {
          print('Cargando detalles de la categoría...');
          await loadCategoriaDetalle(servicioId);
        }
      } else {
        print('No se pudieron cargar los detalles del servicio');
        errorMessage.value = 'No se pudieron cargar los detalles del servicio';
      }
    } catch (e) {
      print('Error en loadServicioDetalle: $e');
      errorMessage.value = 'Error al cargar los detalles: $e';
    } finally {
      isLoading.value = false;
    }
  }

  // Cargar ubicación del servicio
  Future<void> loadUbicacion(int servicioId) async {
    try {
      isLoadingUbicacion.value = true;
      final ubicacionData = await _tourismRepository.getServicioUbicacion(servicioId);
      ubicacion.value = ubicacionData;
    } catch (e) {
      print('Error al cargar ubicación: $e');
    } finally {
      isLoadingUbicacion.value = false;
    }
  }

  // Cargar disponibilidad del servicio
  Future<void> loadDisponibilidad(int servicioId) async {
    try {
      isLoadingDisponibilidad.value = true;
      final disponibilidadData = await _tourismRepository.getServicioDisponibilidad(servicioId);
      disponibilidad.value = disponibilidadData;
    } catch (e) {
      print('Error al cargar disponibilidad: $e');
    } finally {
      isLoadingDisponibilidad.value = false;
    }
  }

  // Cargar detalles del emprendedor
  Future<void> loadEmprendedorDetalle(int emprendedorId) async {
    try {
      isLoadingEmprendedor.value = true;
      final emprendedorData = await _tourismRepository.getEmprendedorDetalle(emprendedorId);
      emprendedor.value = emprendedorData;
    } catch (e) {
      print('Error al cargar emprendedor: $e');
    } finally {
      isLoadingEmprendedor.value = false;
    }
  }

  // Cargar detalles de la categoría
  Future<void> loadCategoriaDetalle(int categoriaId) async {
    try {
      isLoadingCategoria.value = true;
      final categoriaData = await _tourismRepository.getCategoriaDetalle(categoriaId);
      categoria.value = categoriaData;
    } catch (e) {
      print('Error al cargar categoría: $e');
    } finally {
      isLoadingCategoria.value = false;
    }
  }

  // Limpiar datos
  void clearData() {
    servicioDetalle.value = null;
    ubicacion.value = null;
    disponibilidad.value = null;
    emprendedor.value = null;
    categoria.value = null;
    errorMessage.value = '';
  }

  // Verificar si hay datos cargados
  bool get hasData => servicioDetalle.value != null;
  
  // Verificar si hay error
  bool get hasError => errorMessage.value.isNotEmpty;
  
  // Verificar si está cargando
  bool get isAnyLoading => isLoading.value || 
                          isLoadingUbicacion.value || 
                          isLoadingDisponibilidad.value || 
                          isLoadingEmprendedor.value || 
                          isLoadingCategoria.value;
} 