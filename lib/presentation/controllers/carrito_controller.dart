import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/models/carrito_model.dart';
import '../../data/repositories/carrito_repository.dart';
import '../../core/services/storage_service.dart';

class CarritoController extends GetxController {
  final CarritoRepository _carritoRepository;
  final StorageService _storageService;

  CarritoController(this._carritoRepository, this._storageService);

  // Variables observables
  final Rx<CarritoModel?> carrito = Rx<CarritoModel?>(null);
  final RxBool isLoading = false.obs;
  final RxBool hasError = false.obs;
  final RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    cargarCarrito();
  }

  Future<void> cargarCarrito() async {
    try {
      isLoading.value = true;
      hasError.value = false;
      errorMessage.value = '';

      // Verificar si el usuario está autenticado
      final token = await _storageService.getToken();
      if (token == null) {
        hasError.value = true;
        errorMessage.value = 'Debes iniciar sesión para ver tu carrito';
        isLoading.value = false;
        return;
      }

      final carritoData = await _carritoRepository.getCarrito();
      carrito.value = carritoData;
      
      print('Carrito cargado: ${carrito.value?.items.length ?? 0} items');
    } catch (e) {
      hasError.value = true;
      errorMessage.value = e.toString();
      print('Error al cargar carrito: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> agregarAlCarrito(int servicioId, int cantidad) async {
    try {
      isLoading.value = true;
      
      final success = await _carritoRepository.agregarAlCarrito(servicioId, cantidad);
      
      if (success) {
        // Recargar el carrito después de agregar
        await cargarCarrito();
        Get.snackbar(
          'Éxito',
          'Producto agregado al carrito',
          snackPosition: SnackPosition.TOP,
          backgroundColor: const Color(0xFF4CAF50),
          colorText: Colors.white,
        );
      } else {
        Get.snackbar(
          'Error',
          'No se pudo agregar el producto al carrito',
          snackPosition: SnackPosition.TOP,
          backgroundColor: const Color(0xFFF44336),
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Error al agregar al carrito: ${e.toString()}',
        snackPosition: SnackPosition.TOP,
        backgroundColor: const Color(0xFFF44336),
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> actualizarCantidad(int itemId, int cantidad) async {
    try {
      isLoading.value = true;
      
      final success = await _carritoRepository.actualizarCantidad(itemId, cantidad);
      
      if (success) {
        // Recargar el carrito después de actualizar
        await cargarCarrito();
        Get.snackbar(
          'Éxito',
          'Cantidad actualizada',
          snackPosition: SnackPosition.TOP,
          backgroundColor: const Color(0xFF4CAF50),
          colorText: Colors.white,
        );
      } else {
        Get.snackbar(
          'Error',
          'No se pudo actualizar la cantidad',
          snackPosition: SnackPosition.TOP,
          backgroundColor: const Color(0xFFF44336),
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Error al actualizar cantidad: ${e.toString()}',
        snackPosition: SnackPosition.TOP,
        backgroundColor: const Color(0xFFF44336),
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> eliminarDelCarrito(int itemId) async {
    try {
      isLoading.value = true;
      
      final success = await _carritoRepository.eliminarDelCarrito(itemId);
      
      if (success) {
        // Recargar el carrito después de eliminar
        await cargarCarrito();
        Get.snackbar(
          'Éxito',
          'Producto eliminado del carrito',
          snackPosition: SnackPosition.TOP,
          backgroundColor: const Color(0xFF4CAF50),
          colorText: Colors.white,
        );
      } else {
        Get.snackbar(
          'Error',
          'No se pudo eliminar el producto',
          snackPosition: SnackPosition.TOP,
          backgroundColor: const Color(0xFFF44336),
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Error al eliminar del carrito: ${e.toString()}',
        snackPosition: SnackPosition.TOP,
        backgroundColor: const Color(0xFFF44336),
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> limpiarCarrito() async {
    try {
      isLoading.value = true;
      
      final success = await _carritoRepository.limpiarCarrito();
      
      if (success) {
        // Recargar el carrito después de limpiar
        await cargarCarrito();
        Get.snackbar(
          'Éxito',
          'Carrito limpiado',
          snackPosition: SnackPosition.TOP,
          backgroundColor: const Color(0xFF4CAF50),
          colorText: Colors.white,
        );
      } else {
        Get.snackbar(
          'Error',
          'No se pudo limpiar el carrito',
          snackPosition: SnackPosition.TOP,
          backgroundColor: const Color(0xFFF44336),
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Error al limpiar carrito: ${e.toString()}',
        snackPosition: SnackPosition.TOP,
        backgroundColor: const Color(0xFFF44336),
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void refrescarCarrito() {
    cargarCarrito();
  }

  // Método para verificar si el carrito está vacío
  bool get carritoVacio => carrito.value?.estaVacio ?? true;

  // Método para obtener el total de items
  int get totalItems => carrito.value?.cantidadItems ?? 0;

  // Método para obtener el total del carrito
  String get totalCarrito => carrito.value?.total ?? '0.00';

  // Método para obtener la lista de items
  List<CarritoItemModel> get items => carrito.value?.items ?? [];

  // Método para obtener el total como double
  double get totalDouble => carrito.value?.totalDouble ?? 0.0;
} 