import 'package:get/get.dart';
import '../../bindings/planes_binding.dart';
import '../../presentation/pages/home/home_page.dart';
import '../../presentation/pages/home/municipalidad_page.dart';
import '../../presentation/pages/home/planes_page.dart';
import '../../presentation/pages/home/servicios_page.dart';
import '../../presentation/pages/home/emprendimientos_page.dart';
import '../../presentation/pages/auth/login_page.dart';
import '../../presentation/pages/auth/register_page.dart';
import '../../presentation/pages/settings/settings_page.dart';
import '../../presentation/pages/home/eventos_page.dart';
import '../../bindings/auth_binding.dart';
import '../../bindings/home_binding.dart';
import 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.HOME,
      page: () => HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.LOGIN,
      page: () => LoginPage(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.REGISTER,
      page: () => RegisterPage(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.MUNICIPALIDAD,
      page: () => MunicipalidadPage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.SERVICIOS,
      page: () => ServiciosPage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.SETTINGS,
      page: () => const SettingsPage(),
    ),
    GetPage(
      name: AppRoutes.EVENTOS,
      page: () => EventosPage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.PLANES,
      page: () => PlanesPage(),
      binding: PlanesBinding(),
    ),
    GetPage(
      name: AppRoutes.EMPRENDIMIENTOS,
      page: () => EmprendimientosPage(),
      binding: HomeBinding(),
    ),
  ];
}