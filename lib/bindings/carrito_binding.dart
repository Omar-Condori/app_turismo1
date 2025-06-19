import 'package:get/get.dart';
import '../data/repositories/carrito_repository.dart';
import '../core/services/storage_service.dart';
import '../presentation/controllers/carrito_controller.dart';

class CarritoBinding extends Bindings {
  @override
  void dependencies() {
    // Inyectar el servicio de almacenamiento
    Get.lazyPut<StorageService>(() => StorageService());
    
    // Inyectar el repositorio de carrito
    Get.lazyPut<CarritoRepository>(() => 
      CarritoRepository(Get.find<StorageService>())
    );
    
    // Inyectar el controlador de carrito
    Get.lazyPut<CarritoController>(() => 
      CarritoController(Get.find<CarritoRepository>(), Get.find<StorageService>())
    );
  }
} 