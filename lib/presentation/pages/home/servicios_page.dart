import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/home_controller.dart';
import '../../widgets/common/custom_app_bar.dart';
import '../../widgets/common/custom_search_bar.dart';
import '../../widgets/servicios/servicio_card.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_colors.dart';

class ServiciosPage extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white,
              Colors.grey[50]!,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Custom App Bar
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Get.back(),
                      icon: const Icon(Icons.arrow_back_ios, color: AppColors.primary),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      AppStrings.servicios,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),

              // Search bar with glassmorphism effect
              Container(
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: CustomSearchBar(
                  onChanged: controller.searchServicios,
                  hintText: AppStrings.searchServicios,
                ),
              ),

              // Categories with improved design
              Container(
                height: 60,
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  children: [
                    _buildCategoryChip(AppStrings.all, true),
                    _buildCategoryChip(AppStrings.transportation, false),
                    _buildCategoryChip(AppStrings.guides, false),
                    _buildCategoryChip(AppStrings.tours, false),
                    _buildCategoryChip(AppStrings.other, false),
                  ],
                ),
              ),

              // Servicios list with improved empty state
              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Cargando servicios...',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  if (controller.servicios.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.search_off_rounded,
                            size: 80,
                            color: Colors.grey[400],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'No hay servicios disponibles',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Intenta con otra búsqueda',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[500],
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return RefreshIndicator(
                    onRefresh: () => controller.loadServicios(),
                    color: AppColors.primary,
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      itemCount: controller.servicios.length,
                      itemBuilder: (context, index) {
                        final servicio = controller.servicios[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: ServicioCard(
                            servicio: servicio,
                            onTap: () => controller.goToServicioDetail(servicio.id),
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
    );
  }

  Widget _buildCategoryChip(String label, bool isSelected) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: isSelected ? [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ] : null,
        ),
        child: ChoiceChip(
          label: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black87,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          selected: isSelected,
          onSelected: (selected) {
            // TODO: Implement category filtering
          },
          backgroundColor: Colors.grey[100],
          selectedColor: AppColors.primary,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(
              color: isSelected ? AppColors.primary : Colors.grey[300]!,
              width: 1,
            ),
          ),
        ),
      ),
    );
  }
}
