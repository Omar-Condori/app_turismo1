import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/home_controller.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_assets.dart';
import '../../widgets/common/custom_app_bar.dart';
import '../../widgets/common/custom_search_bar.dart';
import '../../widgets/common/loading_widget.dart';
import '../../widgets/servicios/servicio_card.dart';

class ServiciosPage extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF667EEA),
              Color(0xFF764BA2),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // App Bar personalizado
              CustomAppBar(
                title: 'Servicios',
                showBackButton: true,
                backgroundColor: Colors.transparent,
                titleColor: Colors.white,
                iconColor: Colors.white,
              ),

              // Barra de búsqueda
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: CustomSearchBar(
                  hintText: 'Buscar servicios...',
                  onChanged: (value) => controller.searchServicios(value),
                  backgroundColor: Colors.white.withOpacity(0.2),
                  textColor: Colors.white,
                  hintColor: Colors.white70,
                ),
              ),

              // Contenido principal
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(top: 8),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                  ),
                  child: Column(
                    children: [
                      // Header con estadísticas
                      Container(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          children: [
                            Expanded(
                              child: _buildStatCard(
                                icon: Icons.miscellaneous_services,
                                title: 'Total Servicios',
                                value: '${controller.servicios.length}',
                                color: AppColors.primary,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _buildStatCard(
                                icon: Icons.check_circle,
                                title: 'Activos',
                                value: '${controller.servicios.where((s) => s.estado).length}',
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Lista de servicios
                      Expanded(
                        child: Obx(() {
                          if (controller.isLoading.value) {
                            return const LoadingWidget();
                          }

                          if (controller.servicios.isEmpty) {
                            return _buildEmptyState();
                          }

                          return RefreshIndicator(
                            onRefresh: () => controller.loadServicios(),
                            child: ListView.builder(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              itemCount: controller.servicios.length,
                              itemBuilder: (context, index) {
                                final servicio = controller.servicios[index];
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 16),
                                  child: ServicioCard(
                                    servicio: servicio,
                                    onTap: () => _showServicioDetail(servicio),
                                  ),
                                );
                              },
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 32,
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: color.withOpacity(0.8),
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.miscellaneous_services,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'No se encontraron servicios',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Intenta con otra búsqueda o vuelve más tarde',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () => controller.loadServicios(),
            icon: const Icon(Icons.refresh),
            label: const Text('Recargar'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showServicioDetail(servicio) {
    // Navegar a la página de detalles del servicio
    Get.toNamed(
      '/servicio-detalle',
      arguments: {'servicioId': servicio.id},
    );
  }
}