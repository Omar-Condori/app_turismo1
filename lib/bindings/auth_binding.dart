import 'package:get/get.dart';
import '../presentation/controllers/auth_controller.dart';
import '../data/repositories/auth_repository.dart';
import '../data/providers/auth_provider.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthProvider>(() => AuthProvider());
    Get.lazyPut<AuthRepository>(() => AuthRepository(Get.find()));
    Get.lazyPut<AuthController>(() => AuthController());
  }
}