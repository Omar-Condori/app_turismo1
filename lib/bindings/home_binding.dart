import 'package:get/get.dart';
import '../presentation/controllers/home_controller.dart';
import '../data/repositories/tourism_repository.dart';
import '../data/providers/tourism_provider.dart';
import '../data/repositories/auth_repository.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TourismProvider>(() => TourismProvider());
    Get.lazyPut<TourismRepository>(() => TourismRepository(Get.find()));
    Get.lazyPut<AuthRepository>(() => AuthRepository(Get.find()));
    Get.lazyPut<HomeController>(() => HomeController());
  }
}