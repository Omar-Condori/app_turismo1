import 'package:get/get.dart';
import '../../presentation/controllers/planes_controller.dart';

class PlanesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PlanesController>(() => PlanesController());
  }
}