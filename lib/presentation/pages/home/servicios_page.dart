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
      appBar: CustomAppBar(
        title: AppStrings.servicios,
        showBackButton: true,
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: CustomSearchBar(
              onChanged: controller.searchServicios,
              hintText: AppStrings.searchServicios,
            ),
          ),

          // Categories
          SizedBox(
            height: 50,
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

          const SizedBox(height: 16),

          // Servicios list
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (controller.servicios.isEmpty) {
                return const Center(
                  child: Text(
                    'No hay servicios disponibles',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                );
              }

              return RefreshIndicator(
                onRefresh: () => controller.loadServicios(),
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
    );
  }

  Widget _buildCategoryChip(String label, bool isSelected) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: ChoiceChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (selected) {
          // TODO: Implement category filtering
        },
        backgroundColor: Colors.grey[200],
        selectedColor: AppColors.primary.withOpacity(0.2),
        labelStyle: TextStyle(
          color: isSelected ? AppColors.primary : Colors.black87,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}
