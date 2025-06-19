import 'package:get/get.dart';
import '../presentation/controllers/auth_controller.dart';
import '../data/repositories/auth_repository.dart';
import '../data/providers/auth_provider.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    print('=== AUTH BINDING INITIALIZATION ===');
    
    // Registrar providers si no están registrados
    if (!Get.isRegistered<AuthProvider>()) {
      Get.lazyPut<AuthProvider>(() => AuthProvider());
    }
    
    if (!Get.isRegistered<AuthRepository>()) {
      Get.lazyPut<AuthRepository>(() => AuthRepository(Get.find()));
    }
    
    // Registrar controller si no está registrado
    if (!Get.isRegistered<AuthController>()) {
      Get.lazyPut<AuthController>(() => AuthController());
    }
    
    print('=== AUTH BINDING COMPLETED ===');
  }
}