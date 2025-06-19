import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/models/reserva_model.dart';
import '../../data/repositories/reservas_repository.dart';
import '../../core/services/storage_service.dart';

class ReservasController extends GetxController {
  final ReservasRepository _reservasRepository;
  final StorageService _storageService;

  ReservasController(this._reservasRepository, this._storageService);

  // Variables observables
  final RxList<ReservaModel> reservas = <ReservaModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool hasError = false.obs;
  final RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    cargarMisReservas();
  }

  Future<void> cargarMisReservas() async {
    try {
      isLoading.value = true;
      hasError.value = false;
      errorMessage.value = '';

      // Verificar si el usuario está autenticado
      final token = await _storageService.getToken();
      if (token == null) {
        hasError.value = true;
        errorMessage.value = 'Debes iniciar sesión para ver tus reservas';
        isLoading.value = false;
        return;
      }

      final reservasData = await _reservasRepository.getMisReservas();
      reservas.value = reservasData;
      
      print('Reservas cargadas: ${reservas.length}');
    } catch (e) {
      hasError.value = true;
      errorMessage.value = e.toString();
      print('Error al cargar reservas: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> cancelarReserva(int reservaId) async {
    try {
      isLoading.value = true;
      
      final success = await _reservasRepository.cancelarReserva(reservaId);
      
      if (success) {
        // Recargar las reservas después de cancelar
        await cargarMisReservas();
        Get.snackbar(
          'Éxito',
          'Reserva cancelada exitosamente',
          snackPosition: SnackPosition.TOP,
          backgroundColor: const Color(0xFF4CAF50),
          colorText: Colors.white,
        );
      } else {
        Get.snackbar(
          'Error',
          'No se pudo cancelar la reserva',
          snackPosition: SnackPosition.TOP,
          backgroundColor: const Color(0xFFF44336),
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Error al cancelar la reserva: ${e.toString()}',
        snackPosition: SnackPosition.TOP,
        backgroundColor: const Color(0xFFF44336),
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void refrescarReservas() {
    cargarMisReservas();
  }

  // Método para filtrar reservas por estado
  List<ReservaModel> getReservasPorEstado(String estado) {
    return reservas.where((reserva) => 
      reserva.estado.toLowerCase() == estado.toLowerCase()
    ).toList();
  }

  // Método para obtener reservas pendientes
  List<ReservaModel> get reservasPendientes => getReservasPorEstado('pending');

  // Método para obtener reservas confirmadas
  List<ReservaModel> get reservasConfirmadas => getReservasPorEstado('confirmed');

  // Método para obtener reservas canceladas
  List<ReservaModel> get reservasCanceladas => getReservasPorEstado('cancelled');

  // Método para obtener reservas completadas
  List<ReservaModel> get reservasCompletadas => getReservasPorEstado('completed');

  // Método para verificar si hay reservas
  bool get tieneReservas => reservas.isNotEmpty;

  // Método para obtener el total de reservas
  int get totalReservas => reservas.length;
} 