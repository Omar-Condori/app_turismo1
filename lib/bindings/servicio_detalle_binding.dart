import 'package:get/get.dart';
import '../data/providers/tourism_provider.dart';
import '../data/repositories/tourism_repository.dart';
import '../presentation/controllers/servicio_detalle_controller.dart';

class ServicioDetalleBinding extends Bindings {
  @override
  void dependencies() {
    // Registrar el provider
    Get.lazyPut<TourismProvider>(() => TourismProvider());
    
    // Registrar el repositorio con dependencia del provider
    Get.lazyPut<TourismRepository>(() => TourismRepository(Get.find<TourismProvider>()));
    
    // Registrar el controlador con dependencia del repositorio
    Get.lazyPut<ServicioDetalleController>(() => ServicioDetalleController(Get.find<TourismRepository>()));
  }
} 