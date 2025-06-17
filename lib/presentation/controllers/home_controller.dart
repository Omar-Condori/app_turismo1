import 'package:get/get.dart';
import '../../data/models/emprendimiento_model.dart';
import '../../data/models/servicio_model.dart';
import '../../data/models/evento_model.dart';
import '../../data/repositories/tourism_repository.dart';
import '../../data/repositories/auth_repository.dart';
import '../../data/models/user_model.dart';

class HomeController extends GetxController {
  final TourismRepository _repository = Get.find<TourismRepository>();
  final AuthRepository _authRepository = Get.find<AuthRepository>();

  final RxList<EmprendimientoModel> emprendimientos = <EmprendimientoModel>[].obs;
  final RxList<ServicioModel> servicios = <ServicioModel>[].obs;
  final RxList<EventoModel> eventos = <EventoModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxString searchQuery = ''.obs;
  final Rx<UserModel?> currentUser = Rx<UserModel?>(null);
  final RxBool isUserLoaded = false.obs;

  final RxInt selectedTabIndex = 0.obs;
  final RxInt selectedBottomNavIndex = 0.obs;

  final List<String> tabTitles = [
    'Resumen',
    'Negocios',
    'Servicios',
    'Eventos',
  ];

  @override
  void onInit() {
    super.onInit();
    loadCurrentUser();
  }

  Future<void> loadCurrentUser() async {
    try {
      currentUser.value = await _authRepository.getCurrentUser();
      isUserLoaded.value = true;
    } catch (e) {
      print('Error al cargar usuario: $e');
      isUserLoaded.value = true;
    }
  }

  Future<void> loadEmprendimientos() async {
    try {
      isLoading.value = true;
      final result = await _repository.getEmprendimientos();
      emprendimientos.value = result;
    } catch (e) {
      Get.snackbar(
        'Error',
        'No se pudieron cargar los emprendimientos',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadServicios() async {
    try {
      isLoading.value = true;
      final result = await _repository.getServicios();
      servicios.value = result;
    } catch (e) {
      Get.snackbar(
        'Error',
        'No se pudieron cargar los servicios',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadEventos() async {
    try {
      isLoading.value = true;
      final result = await _repository.getEventos();
      eventos.value = result;
    } catch (e) {
      Get.snackbar(
        'Error',
        'No se pudieron cargar los eventos',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void searchEmprendimientos(String query) {
    searchQuery.value = query;
    if (query.isEmpty) {
      loadEmprendimientos();
    } else {
      _repository.searchEmprendimientos(query).then((result) {
        emprendimientos.value = result;
      }).catchError((error) {
        Get.snackbar(
          'Error',
          'Error al buscar emprendimientos',
          snackPosition: SnackPosition.BOTTOM,
        );
      });
    }
  }

  void searchServicios(String query) {
    searchQuery.value = query;
    if (query.isEmpty) {
      loadServicios();
    } else {
      _repository.searchServicios(query).then((result) {
        servicios.value = result;
      }).catchError((error) {
        Get.snackbar(
          'Error',
          'Error al buscar servicios',
          snackPosition: SnackPosition.BOTTOM,
        );
      });
    }
  }

  void searchEventos(String query) {
    searchQuery.value = query;
    if (query.isEmpty) {
      loadEventos();
    } else {
      _repository.searchEventos(query).then((result) {
        eventos.value = result;
      }).catchError((error) {
        Get.snackbar(
          'Error',
          'Error al buscar eventos',
          snackPosition: SnackPosition.BOTTOM,
        );
      });
    }
  }

  void goToEmprendimientoDetail(String id) {
    Get.toNamed('/emprendimiento/$id');
  }

  void goToServicioDetail(String id) {
    Get.toNamed('/servicio/$id');
  }

  void goToEventoDetail(String id) {
    Get.toNamed('/evento/$id');
  }

  void changeTab(int index) {
    selectedTabIndex.value = index;
  }

  void changeBottomNav(int index) {
    selectedBottomNavIndex.value = index;
  }

  void goToEmprendimientos() {
    // Navigate to emprendimientos page or change tab
    selectedTabIndex.value = 1;
  }

  void goToServicios() {
    // Navigate to servicios page or change tab
    selectedTabIndex.value = 2;
  }

  void goToEventos() {
    // Navigate to eventos page or change tab
    selectedTabIndex.value = 3;
  }
}