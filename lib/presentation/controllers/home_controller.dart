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
import '../../core/constants/app_colors.dart';
import '../../core/constants/api_config.dart';
import '../../core/constants/debug_config.dart';

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
    DebugConfig.log('HomeController onInit called');
    // Cargar datos de forma asíncrona para evitar bloqueos
    Future.microtask(() {
      if (DebugConfig.enableUserLoad) {
        loadCurrentUser();
      }
      if (DebugConfig.enableMunicipalidadLoad) {
        loadMunicipalidadInfo();
      }
    });
  }

  Future<void> loadCurrentUser() async {
    try {
      DebugConfig.log('Cargando usuario actual...');
      currentUser.value = await _authRepository.getCurrentUser();
      isUserLoaded.value = true;
      DebugConfig.log('Usuario cargado exitosamente');
    } catch (e) {
      DebugConfig.log('Error al cargar usuario: $e');
      isUserLoaded.value = true;
      // No mostrar snackbar para evitar interrupciones
    }
  }

  Future<void> loadDashboardSummary() async {
    try {
      isLoading.value = true;
      print('Iniciando petición al dashboard...');
      
      // Debug: mostrar la URL que se está usando
      ApiConfig.printCurrentUrl();
      
      final response = await http.get(Uri.parse('${ApiConfig.baseUrl}/dashboard/summary'));
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
      final response = await http.get(
        Uri.parse('${ApiConfig.baseUrl}/servicios'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true && data['data'] != null) {
          servicios.value = (data['data']['data'] as List)
              .map((json) => ServicioModel.fromJson(json))
              .toList();
        } else {
          Get.snackbar(
            'Error',
            'No se pudieron cargar los servicios',
            snackPosition: SnackPosition.BOTTOM,
          );
        }
      } else {
        Get.snackbar(
          'Error',
          'No se pudieron cargar los servicios',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      print('Error al cargar servicios: $e');
      Get.snackbar(
        'Error',
        'Error al cargar los servicios: ${e.toString()}',
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

  void goToServicioDetail(int id) {
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
        Get.toNamed('/emprendimientos');
        break;
      case 2: // Servicios
        loadServicios();
        Get.toNamed('/servicios');
        break;
      case 3: // Eventos
        loadEventos();
        Get.toNamed('/eventos');
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
    // Navegar a la página de servicios
    Get.toNamed('/servicios');
    // Cargar los servicios
    loadServicios();
  }

  void goToEventos() {
    // Navigate to eventos page or change tab
    selectedTabIndex.value = 3;
    loadEventos();
    Get.toNamed('/eventos');
  }

  void goToPlanes() {
    // Navigate to planes page
    Get.toNamed('/planes');
  }

  Future<void> loadMunicipalidadInfo() async {
    // Evitar llamadas múltiples si ya está cargando
    if (isLoading.value) {
      print('Ya está cargando, saltando llamada duplicada');
      return;
    }
    
    try {
      isLoading.value = true;
      print('Cargando información de municipalidad...');
      
      // Debug: mostrar la URL que se está usando
      ApiConfig.printCurrentUrl();
      
      final result = await _repository.getMunicipalidad();
      municipalidad.value = result;
      
      if (result != null) {
        print('Información de municipalidad cargada exitosamente');
      } else {
        print('No se encontraron datos válidos en la respuesta');
      }
    } catch (e) {
      print('Error al cargar municipalidad: $e');
      municipalidad.value = null;
      // No mostrar snackbar aquí para evitar interrupciones en la UI
    } finally {
      isLoading.value = false;
    }
  }
}