import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/home_controller.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../app/routes/app_routes.dart';

class HomePage extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image with parallax effect
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppAssets.capachicaLandscape),
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.high,
                ),
              ),
            ),
          ),

          // Sophisticated gradient overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  const Color(0xFF1A1A2E).withOpacity(0.7),
                  Colors.transparent,
                  Colors.transparent,
                  const Color(0xFF0F0F23).withOpacity(0.9),
                ],
                stops: const [0.0, 0.25, 0.75, 1.0],
              ),
            ),
          ),

          // Radial gradient for depth
          Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: const Alignment(0, -0.3),
                radius: 1.5,
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.3),
                ],
                stops: const [0.3, 1.0],
              ),
            ),
          ),

          // Main content
          Column(
            children: [
              // Top section with glassmorphism tabs
              Container(
                margin: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top + 12,
                  left: 16,
                  right: 16,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.white.withOpacity(0.25),
                          Colors.white.withOpacity(0.1),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.2),
                        width: 1,
                      ),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Obx(() => Row(
                          children: List.generate(
                            controller.tabTitles.length,
                                (index) => Expanded(
                              child: GestureDetector(
                                onTap: () => _onTabSelected(index),
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                  margin: const EdgeInsets.symmetric(horizontal: 2),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 16,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color: controller.selectedTabIndex.value == index
                                        ? Colors.white
                                        : Colors.transparent,
                                    boxShadow: controller.selectedTabIndex.value == index
                                        ? [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        blurRadius: 10,
                                        offset: const Offset(0, 4),
                                      ),
                                    ]
                                        : null,
                                  ),
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      controller.tabTitles[index],
                                      style: TextStyle(
                                        color: controller.selectedTabIndex.value == index
                                            ? const Color(0xFF2D3748)
                                            : Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12,
                                      ),
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )),
                      ),
                    ),
                  ),
                ),
              ),

              const Spacer(),

              // Botones de servicios y planes
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    // Botón de servicios (reducido)
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => Get.toNamed(AppRoutes.SERVICIOS),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: const Color(0xFF2D3748),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 4,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.miscellaneous_services, color: AppColors.primary),
                            const SizedBox(width: 8),
                            Text(
                              'Servicios',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(width: 12),

                    // Botón de planes
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF667EEA).withOpacity(0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: ElevatedButton(
                          onPressed: () => Get.toNamed(AppRoutes.PLANES),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.layers, color: Colors.white),
                              SizedBox(width: 8),
                              Text(
                                'Planes',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Premium bottom navigation
              Container(
                margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  gradient: LinearGradient(
                    colors: [
                      Colors.white.withOpacity(0.15),
                      Colors.white.withOpacity(0.05),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.2),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 30,
                      offset: const Offset(0, 15),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Container(
                    height: 75 + MediaQuery.of(context).padding.bottom,
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).padding.bottom,
                      top: 8,
                    ),
                    child: Obx(() => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildNavItem(
                          Icons.home_rounded,
                          AppStrings.home,
                          0,
                          controller.selectedBottomNavIndex.value == 0,
                              () => controller.changeBottomNav(0),
                        ),
                        _buildNavItem(
                          Icons.photo_library_rounded,
                          'Fotos',
                          1,
                          controller.selectedBottomNavIndex.value == 1,
                              () => controller.changeBottomNav(1),
                        ),
                        _buildNavItem(
                          Icons.settings_rounded,
                          AppStrings.settings,
                          2,
                          controller.selectedBottomNavIndex.value == 2,
                              () => Get.toNamed(AppRoutes.SETTINGS),
                        ),
                        _buildNavItem(
                          Icons.person_rounded,
                          'Perfil',
                          3,
                          controller.selectedBottomNavIndex.value == 3,
                              () => _showProfileBottomSheet(context),
                        ),
                      ],
                    )),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _onTabSelected(int index) {
    print('=== TAB SELECTED ===');
    print('Index seleccionado: $index');
    print('Controller: $controller');
    
    if (index == 0) { // Resumen
      print('Navegando a resumen/municipalidad...');
      controller.loadMunicipalidadInfo();
      Get.toNamed('/municipalidad');
    } else if (index == 1) { // Negocios
      print('Navegando a negocios...');
      controller.loadEmprendimientos();
      Get.toNamed('/emprendimientos');
    } else if (index == 2) { // Servicios
      print('Navegando a servicios...');
      Get.toNamed(AppRoutes.SERVICIOS);
    } else if (index == 3) { // Eventos
      print('Navegando a eventos...');
      controller.loadEventos();
      Get.toNamed('/eventos');
    } else {
      print('Cambiando tab a índice: $index');
      controller.changeTab(index);
    }
  }

  void _showProfileBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white.withOpacity(0.95),
              Colors.white.withOpacity(0.98),
            ],
          ),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
          border: Border.all(
            color: Colors.white.withOpacity(0.3),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: Container(
          padding: EdgeInsets.only(
            top: 20,
            left: 20,
            right: 20,
            bottom: MediaQuery.of(context).padding.bottom + 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle bar
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 20),

              // Logo en lugar del título
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: Image.asset(
                    'assets/icons/img.png', // Cambia esta ruta por la correcta de tu favicon
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      // Widget de respaldo si no se encuentra la imagen
                      return Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xFFFF8A00), Color(0xFFE52E71)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: Icon(
                          Icons.landscape_rounded,
                          color: Colors.white,
                          size: 40,
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 25),

              // Profile options con iconos coloreados
              _buildProfileOption(
                icon: Icons.login_rounded,
                iconColor: Colors.green, // Verde para login
                title: 'Iniciar Sesión',
                subtitle: 'Accede a tu cuenta',
                onTap: () {
                  Navigator.pop(context);
                  Get.toNamed(AppRoutes.LOGIN);
                },
              ),

              _buildProfileOption(
                icon: Icons.bookmark_rounded,
                iconColor: Colors.blue, // Azul para reservas
                title: 'Mis Reservas',
                subtitle: 'Ver reservas activas',
                onTap: () {
                  Navigator.pop(context);
                  // Navegar a reservas
                  Get.toNamed('/reservas');
                },
              ),

              _buildProfileOption(
                icon: Icons.shopping_cart_rounded,
                iconColor: Colors.orange, // Naranja para carrito
                title: 'Carrito',
                subtitle: 'Ver productos seleccionados',
                onTap: () {
                  Navigator.pop(context);
                  // Navegar a carrito
                  Get.toNamed('/carrito');
                },
              ),

              _buildProfileOption(
                icon: Icons.account_circle_rounded,
                iconColor: Colors.purple, // Morado para perfil
                title: 'Mi Perfil',
                subtitle: 'Configurar información personal',
                onTap: () {
                  Navigator.pop(context);
                  // Navegar a perfil
                  Get.toNamed('/perfil');
                },
              ),

              _buildProfileOption(
                icon: Icons.logout_rounded,
                iconColor: Colors.red, // Rojo para logout
                title: 'Cerrar Sesión',
                subtitle: 'Salir de la aplicación',
                isDestructive: true,
                onTap: () {
                  Navigator.pop(context);
                  // Lógica de cerrar sesión
                  _showLogoutDialog(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    Color? iconColor,
    bool isDestructive = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.white.withOpacity(0.7),
              border: Border.all(
                color: Colors.white.withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: (iconColor ?? (isDestructive ? Colors.red : AppColors.primary))
                        .withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    icon,
                    color: iconColor ?? (isDestructive ? Colors.red : AppColors.primary),
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: isDestructive ? Colors.red : const Color(0xFF2D3748),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 16,
                  color: Colors.grey[400],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Text('Cerrar Sesión'),
        content: const Text('¿Estás seguro de que quieres cerrar sesión?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancelar',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Aquí implementar la lógica de cerrar sesión
              // controller.logout();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text(
              'Cerrar Sesión',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(
      IconData icon,
      String label,
      int index,
      bool isSelected,
      VoidCallback onTap,
      ) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: isSelected
              ? Colors.white.withOpacity(0.2)
              : Colors.transparent,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected
                  ? Colors.white
                  : Colors.white.withOpacity(0.6),
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isSelected
                    ? Colors.white
                    : Colors.white.withOpacity(0.6),
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}