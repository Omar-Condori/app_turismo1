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
              // Top section with glassmorphism tabs - ARREGLADO
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
                                onTap: () => controller.changeTab(index),
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                  margin: const EdgeInsets.symmetric(horizontal: 2),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12, // Reducido de 16 a 12
                                    vertical: 16,   // Aumentado de 14 a 16
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
                                  child: FittedBox( // Agregado FittedBox para ajustar texto
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      controller.tabTitles[index],
                                      style: TextStyle(
                                        color: controller.selectedTabIndex.value == index
                                            ? const Color(0xFF2D3748)
                                            : Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12, // Reducido de 13 a 12
                                      ),
                                      textAlign: TextAlign.center,
                                      maxLines: 1, // Asegurar una sola línea
                                      overflow: TextOverflow.ellipsis, // Truncar si es necesario
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

              // Hero content section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Main title with stunning typography
                    ShaderMask(
                      shaderCallback: (Rect bounds) {
                        return const LinearGradient(
                          colors: [Colors.white, Color(0xFFE2E8F0)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ).createShader(bounds);
                      },
                      child: Text(
                        AppStrings.welcome,
                        style: const TextStyle(
                          fontSize: 42,
                          fontWeight: FontWeight.w900,
                          height: 1.1,
                          letterSpacing: -0.5,
                          color: Colors.white,
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.2),
                          width: 1,
                        ),
                      ),
                      child: Text(
                        AppStrings.discover,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.95),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.2,
                        ),
                      ),
                    ),

                    const SizedBox(height: 48),

                    // Premium action buttons
                    Row(
                      children: [
                        Expanded(
                          child: _buildPremiumButton(
                            'Negocios',
                            Icons.storefront_rounded,
                                () => controller.goToEmprendimientos(),
                            isOutlined: true,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildPremiumButton(
                            AppStrings.servicios,
                            Icons.room_service_rounded,
                                () => controller.goToServicios(),
                            isOutlined: false,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

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
                          Icons.camera_alt_rounded,
                          AppStrings.ar,
                          1,
                          controller.selectedBottomNavIndex.value == 1,
                              () => controller.changeBottomNav(1),
                        ),
                        _buildNavItem(
                          Icons.settings_rounded,
                          AppStrings.settings,
                          2,
                          controller.selectedBottomNavIndex.value == 2,
                              () => controller.changeBottomNav(2),
                        ),
                        _buildNavItem(
                          Icons.person_rounded,
                          'Perfil',
                          3,
                          controller.selectedBottomNavIndex.value == 3,
                              () => Get.toNamed(AppRoutes.LOGIN),
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

  Widget _buildPremiumButton(
      String text,
      IconData icon,
      VoidCallback onPressed, {
        bool isOutlined = false,
      }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        gradient: isOutlined
            ? null
            : const LinearGradient(
          colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: isOutlined
                ? Colors.white.withOpacity(0.1)
                : const Color(0xFF667EEA).withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(25),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(25),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              border: isOutlined
                  ? Border.all(
                color: Colors.white.withOpacity(0.8),
                width: 2,
              )
                  : null,
              gradient: isOutlined
                  ? LinearGradient(
                colors: [
                  Colors.white.withOpacity(0.1),
                  Colors.white.withOpacity(0.05),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
                  : null,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: Colors.white,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  text,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
        ),
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