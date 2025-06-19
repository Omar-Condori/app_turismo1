import 'package:get/get.dart';
import '../presentation/controllers/maps_controller.dart';
import '../data/repositories/tourism_repository.dart';
import '../data/providers/tourism_provider.dart';

class MapsBinding extends Bindings {
  @override
  void dependencies() {
    // Registrar el provider si no está registrado
    if (!Get.isRegistered<TourismProvider>()) {
      Get.lazyPut<TourismProvider>(() => TourismProvider());
    }
    
    // Registrar el repositorio si no está registrado
    if (!Get.isRegistered<TourismRepository>()) {
      Get.lazyPut<TourismRepository>(() => TourismRepository(Get.find()));
    }
    
    // Registrar el controlador de mapas
    Get.lazyPut<MapsController>(() => MapsController());
  }
} 