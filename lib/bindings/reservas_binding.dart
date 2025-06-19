import 'package:get/get.dart';
import '../data/repositories/reservas_repository.dart';
import '../core/services/storage_service.dart';
import '../presentation/controllers/reservas_controller.dart';

class ReservasBinding extends Bindings {
  @override
  void dependencies() {
    // Inyectar el servicio de almacenamiento
    Get.lazyPut<StorageService>(() => StorageService());
    
    // Inyectar el repositorio de reservas
    Get.lazyPut<ReservasRepository>(() => 
      ReservasRepository(Get.find<StorageService>())
    );
    
    // Inyectar el controlador de reservas
    Get.lazyPut<ReservasController>(() => 
      ReservasController(Get.find<ReservasRepository>(), Get.find<StorageService>())
    );
  }
} 