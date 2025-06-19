import 'package:get/get.dart';
import '../presentation/controllers/home_controller.dart';
import '../data/repositories/tourism_repository.dart';
import '../data/providers/tourism_provider.dart';
import '../data/repositories/auth_repository.dart';
import '../data/providers/auth_provider.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    print('=== HOME BINDING INITIALIZATION ===');
    
    // Registrar providers si no están registrados
    if (!Get.isRegistered<TourismProvider>()) {
      Get.lazyPut<TourismProvider>(() => TourismProvider());
    }
    
    if (!Get.isRegistered<AuthProvider>()) {
      Get.lazyPut<AuthProvider>(() => AuthProvider());
    }
    
    // Registrar repositories si no están registrados
    if (!Get.isRegistered<TourismRepository>()) {
      Get.lazyPut<TourismRepository>(() => TourismRepository(Get.find()));
    }
    
    if (!Get.isRegistered<AuthRepository>()) {
      Get.lazyPut<AuthRepository>(() => AuthRepository(Get.find()));
    }
    
    // Usar put en lugar de lazyPut para mantener la misma instancia
    if (!Get.isRegistered<HomeController>()) {
      print('Creating new HomeController instance');
      Get.put<HomeController>(HomeController(), permanent: true);
    } else {
      print('HomeController already exists, reusing instance');
    }
    print('=== HOME BINDING COMPLETED ===');
  }
}