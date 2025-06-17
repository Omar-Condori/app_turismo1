import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/home_controller.dart';
import '../../widgets/common/custom_app_bar.dart';
import '../../widgets/common/custom_search_bar.dart';
import '../../widgets/emprendimientos/emprendimiento_card.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_colors.dart';

class EmprendimientosPage extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: AppStrings.emprendimientos,
        showBackButton: true,
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: CustomSearchBar(
              onChanged: controller.searchEmprendimientos,
              hintText: AppStrings.searchEmprendimientos,
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
                _buildCategoryChip(AppStrings.restaurants, false),
                _buildCategoryChip(AppStrings.hotels, false),
                _buildCategoryChip(AppStrings.activities, false),
                _buildCategoryChip(AppStrings.souvenirs, false),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Emprendimientos list
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (controller.emprendimientos.isEmpty) {
                return Center(
                  child: Text(
                    AppStrings.noEmprendimientosFound,
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                itemCount: controller.emprendimientos.length,
                itemBuilder: (context, index) {
                  final emprendimiento = controller.emprendimientos[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: EmprendimientoCard(
                      emprendimiento: emprendimiento,
                      onTap: () => controller.goToEmprendimientoDetail(emprendimiento.id),
                    ),
                  );
                },
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
