import 'package:get/get.dart';
import '../../data/models/emprendimiento_model.dart';
import '../../data/models/servicio_model.dart';
import '../../data/models/evento_model.dart';
import '../../data/models/dashboard_summary_model.dart';
import '../../data/repositories/tourism_repository.dart';
import '../../data/repositories/auth_repository.dart';
import '../../data/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../data/models/municipalidad_model.dart';

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
  final Rx<DashboardSummaryModel?> dashboardSummary = Rx<DashboardSummaryModel?>(null);

  final RxInt selectedTabIndex = 0.obs;
  final RxInt selectedBottomNavIndex = 0.obs;

  final List<String> tabTitles = [
    'Resumen',
    'Negocios',
    'Servicios',
    'Eventos',
  ];

  final municipalidad = Rxn<MunicipalidadModel>();

  final List<String> tabs = [
    'Inicio',
    'Emprendimientos',
    'Servicios',
    'Resumen',
    'Eventos',
  ];

  @override
  void onInit() {
    super.onInit();
    loadCurrentUser();
    loadMunicipalidadInfo();
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

  Future<void> loadDashboardSummary() async {
    try {
      isLoading.value = true;
      print('Iniciando petición al dashboard...');
      final response = await http.get(Uri.parse('http://127.0.0.1:8000/api/dashboard/summary'));
      print('Respuesta recibida: ${response.statusCode}');
      print('Cuerpo de la respuesta: ${response.body}');
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        dashboardSummary.value = DashboardSummaryModel.fromJson(data);
        print('Datos del dashboard cargados: ${dashboardSummary.value}');
      } else {
        print('Error en la respuesta: ${response.statusCode}');
        Get.snackbar(
          'Error',
          'No se pudo cargar el resumen del dashboard: ${response.statusCode}',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      print('Error al cargar el dashboard: $e');
      Get.snackbar(
        'Error',
        'Error al cargar el resumen del dashboard: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadEmprendimientos() async {
    try {
      isLoading.value = true;
      final result = await _repository.getEmprendimientos();
      emprendimientos.value = result;
    } catch (e) {
      print('Error al cargar emprendimientos: $e');
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
      print('Error al cargar servicios: $e');
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
      print('Error al cargar eventos: $e');
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
    switch (index) {
      case 0: // Resumen
        loadMunicipalidadInfo();
        Get.toNamed('/municipalidad');
        break;
      case 1: // Negocios
        loadEmprendimientos();
        break;
      case 2: // Servicios
        loadServicios();
        break;
      case 3: // Eventos
        loadEventos();
        break;
    }
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

  Future<void> loadMunicipalidadInfo() async {
    try {
      isLoading.value = true;
      print('Iniciando petición a la API de municipalidad...');
      
      final response = await http.get(
        Uri.parse('http://127.0.0.1:8000/api/municipalidad'),
      );
      
      print('Código de respuesta: ${response.statusCode}');
      print('Respuesta del servidor: ${response.body}');

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        if (jsonResponse['success'] == true && jsonResponse['data'] != null && jsonResponse['data'].isNotEmpty) {
          municipalidad.value = MunicipalidadModel.fromJson(jsonResponse['data'][0]);
          print('Datos de la municipalidad cargados exitosamente');
        } else {
          print('No se encontraron datos en la respuesta');
        }
      } else {
        print('Error en la petición: ${response.statusCode}');
      }
    } catch (e) {
      print('Error en la petición: $e');
    } finally {
      isLoading.value = false;
    }
  }
}