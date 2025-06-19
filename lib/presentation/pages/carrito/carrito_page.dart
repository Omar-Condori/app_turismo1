import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/carrito_controller.dart';
import '../../widgets/common/loading_widget.dart';
import '../../widgets/carrito/carrito_item_card.dart';
import '../../widgets/carrito/empty_carrito_widget.dart';

class CarritoPage extends StatelessWidget {
  const CarritoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CarritoController>();

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

              if (controller.carritoVacio) {
                return const EmptyCarritoWidget();
              }

              return _buildCarritoContent(controller);
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
        // Título "Carrito"
        Positioned(
          bottom: 20,
          left: 20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Carrito',
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
                final controller = Get.find<CarritoController>();
                return Text(
                  '${controller.totalItems} producto${controller.totalItems != 1 ? 's' : ''}',
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

  Widget _buildErrorWidget(CarritoController controller) {
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
              'Error al cargar carrito',
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
              onPressed: () => controller.refrescarCarrito(),
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

  Widget _buildCarritoContent(CarritoController controller) {
    return Column(
      children: [
        // Lista de productos
        Expanded(
          child: RefreshIndicator(
            onRefresh: () async {
              await controller.cargarCarrito();
            },
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: controller.items.length,
              itemBuilder: (context, index) {
                final item = controller.items[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: CarritoItemCard(
                    item: item,
                    onActualizarCantidad: (cantidad) => 
                        controller.actualizarCantidad(item.id, cantidad),
                    onEliminar: () => controller.eliminarDelCarrito(item.id),
                  ),
                );
              },
            ),
          ),
        ),
        
        // Resumen y botones de acción
        _buildResumenCarrito(controller),
      ],
    );
  }

  Widget _buildResumenCarrito(CarritoController controller) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Resumen de totales
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700],
                ),
              ),
              Obx(() => Text(
                'S/ ${controller.totalCarrito}',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1976D2),
                ),
              )),
            ],
          ),
          
          const SizedBox(height: 20),
          
          // Botones de acción
          Row(
            children: [
              // Botón limpiar carrito
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _showLimpiarCarritoDialog(controller),
                  icon: const Icon(Icons.delete_outline),
                  label: const Text('Limpiar'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFFF44336),
                    side: const BorderSide(color: Color(0xFFF44336)),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              
              const SizedBox(width: 16),
              
              // Botón proceder al pago
              Expanded(
                flex: 2,
                child: ElevatedButton.icon(
                  onPressed: () => _procederAlPago(controller),
                  icon: const Icon(Icons.shopping_cart_checkout),
                  label: const Text('Proceder al Pago'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4CAF50),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showLimpiarCarritoDialog(CarritoController controller) {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Text('Limpiar Carrito'),
        content: const Text('¿Estás seguro de que quieres limpiar todo el carrito?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'Cancelar',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back();
              controller.limpiarCarrito();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFF44336),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text(
              'Limpiar',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  void _procederAlPago(CarritoController controller) {
    // Aquí puedes implementar la navegación al proceso de pago
    Get.snackbar(
      'Proceso de Pago',
      'Funcionalidad de pago en desarrollo',
      snackPosition: SnackPosition.TOP,
      backgroundColor: const Color(0xFF1976D2),
      colorText: Colors.white,
    );
  }
} 