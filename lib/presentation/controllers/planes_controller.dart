import 'package:get/get.dart';
import '../../data/models/plan_model.dart';
import '../../data/repositories/planes_repository.dart';

class PlanesController extends GetxController {
  final PlanesRepository _repository = PlanesRepository();

  // Variables observables
  final RxList<PlanModel> planes = <PlanModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final Rx<PlanModel?> selectedPlan = Rx<PlanModel?>(null);
  final RxString searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadPlanes();
  }

  Future<void> loadPlanes() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final List<PlanModel> planesData = await _repository.getPlanes();
      planes.assignAll(planesData);

    } catch (e) {
      errorMessage.value = e.toString();
      Get.snackbar(
        'Error',
        'No se pudieron cargar los planes',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void searchPlanes(String query) {
    searchQuery.value = query;
    if (query.isEmpty) {
      loadPlanes();
    } else {
      _repository.searchPlanes(query).then((result) {
        planes.assignAll(result);
      }).catchError((error) {
        Get.snackbar(
          'Error',
          'Error al buscar planes',
          snackPosition: SnackPosition.BOTTOM,
        );
      });
    }
  }

  Future<void> refreshPlanes() async {
    await loadPlanes();
  }

  void selectPlan(PlanModel plan) {
    selectedPlan.value = plan;
  }

  Future<void> loadPlanDetails(int planId) async {
    try {
      isLoading.value = true;
      final PlanModel plan = await _repository.getPlanPorId(planId);
      selectedPlan.value = plan;
    } catch (e) {
      errorMessage.value = e.toString();
      Get.snackbar(
        'Error',
        'No se pudo cargar el detalle del plan',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }
}