import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/reservas_controller.dart';
import '../../widgets/common/loading_widget.dart';
import '../../widgets/reservas/reserva_card.dart';
import '../../widgets/reservas/empty_reservas_widget.dart';

class MisReservasPage extends StatelessWidget {
  const MisReservasPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ReservasController>();

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: Column(
        children: [
          // Header con imagen y flecha de regreso
          _buildHeader(),
          
          // Contenido principal
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const LoadingWidget();
              }

              if (controller.hasError.value) {
                return _buildErrorWidget(controller);
              }

              if (!controller.tieneReservas) {
                return const EmptyReservasWidget();
              }

              return _buildReservasList(controller);
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: 220,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/historia/capachica_antigua.jpg'),
                fit: BoxFit.cover,
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.3),
                    Colors.transparent,
                    Colors.black.withOpacity(0.5),
                  ],
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
            ),
          ),
        ),
        // Flecha de regreso
        Positioned(
          top: 40,
          left: 16,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.9),
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black87),
              onPressed: () => Get.back(),
            ),
          ),
        ),
        // Título "Mis Reservas"
        Positioned(
          bottom: 20,
          left: 20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Mis Reservas',
                style: TextStyle(
                  fontSize: 38,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      blurRadius: 8,
                      color: Colors.black.withOpacity(0.7),
                      offset: const Offset(2, 2),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Obx(() {
                final controller = Get.find<ReservasController>();
                return Text(
                  '${controller.totalReservas} reserva${controller.totalReservas != 1 ? 's' : ''}',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white.withOpacity(0.9),
                    shadows: [
                      Shadow(
                        blurRadius: 4,
                        color: Colors.black.withOpacity(0.5),
                        offset: const Offset(1, 1),
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildErrorWidget(ReservasController controller) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 80,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              'Error al cargar reservas',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              controller.errorMessage.value,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[500],
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => controller.refrescarReservas(),
              icon: const Icon(Icons.refresh),
              label: const Text('Reintentar'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1976D2),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReservasList(ReservasController controller) {
    return RefreshIndicator(
      onRefresh: () async {
        await controller.cargarMisReservas();
      },
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: controller.reservas.length,
        itemBuilder: (context, index) {
          final reserva = controller.reservas[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: ReservaCard(
              reserva: reserva,
              onCancelar: () => controller.cancelarReserva(reserva.id),
            ),
          );
        },
      ),
    );
  }
} 