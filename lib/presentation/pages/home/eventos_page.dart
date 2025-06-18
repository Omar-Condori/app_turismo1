import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/home_controller.dart';
import '../../widgets/common/custom_app_bar.dart';
import '../../widgets/common/custom_search_bar.dart';
import '../../widgets/eventos/evento_card.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_colors.dart';

class EventosPage extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    controller.loadEventos();
    return Scaffold(
      appBar: CustomAppBar(
        title: AppStrings.eventos,
        showBackButton: true,
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: CustomSearchBar(
              onChanged: controller.searchEventos,
              hintText: AppStrings.searchEventos,
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
                _buildCategoryChip(AppStrings.upcoming, false),
                _buildCategoryChip(AppStrings.ongoing, false),
                _buildCategoryChip(AppStrings.past, false),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Eventos list
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (controller.eventos.isEmpty) {
                return Center(
                  child: Text(
                    AppStrings.noEventosFound,
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                itemCount: controller.eventos.length,
                itemBuilder: (context, index) {
                  final evento = controller.eventos[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: EventoCard(
                      evento: evento,
                      onTap: () => controller.goToEventoDetail(evento.id),
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
