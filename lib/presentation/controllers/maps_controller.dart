import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/repositories/tourism_repository.dart';
import 'package:url_launcher/url_launcher.dart';

class MapsController extends GetxController {
  final TourismRepository _repository = Get.find<TourismRepository>();

  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxString mapsUrl = ''.obs;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> loadGoogleMapsUrl() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final url = await _repository.getGoogleMapsUrl();
      
      if (url != null) {
        mapsUrl.value = url;
      } else {
        errorMessage.value = 'No se pudo obtener la URL de Google Maps';
        Get.snackbar(
          'Error',
          'No se pudo obtener la URL de Google Maps',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      errorMessage.value = e.toString();
      Get.snackbar(
        'Error',
        'Error al cargar Google Maps: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> openGoogleMaps() async {
    try {
      isLoading.value = true;
      
      // Primero cargar la URL si no está disponible
      if (mapsUrl.value.isEmpty) {
        await loadGoogleMapsUrl();
      }

      if (mapsUrl.value.isNotEmpty) {
        final Uri uri = Uri.parse(mapsUrl.value);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        } else {
          Get.snackbar(
            'Error',
            'No se pudo abrir Google Maps',
            snackPosition: SnackPosition.BOTTOM,
          );
        }
      } else {
        Get.snackbar(
          'Error',
          'No se pudo obtener la URL de Google Maps',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Error al abrir Google Maps: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void showMapsOptions() {
    Get.bottomSheet(
      Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(top: 12),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              '¿Cómo quieres llegar a Capachica?',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.directions_car, color: Colors.blue),
              title: const Text('En coche'),
              subtitle: const Text('Ruta en automóvil'),
              onTap: () => _openDirections('driving'),
            ),
            ListTile(
              leading: const Icon(Icons.directions_bus, color: Colors.green),
              title: const Text('En transporte público'),
              subtitle: const Text('Ruta en bus'),
              onTap: () => _openDirections('transit'),
            ),
            ListTile(
              leading: const Icon(Icons.directions_walk, color: Colors.orange),
              title: const Text('A pie'),
              subtitle: const Text('Ruta caminando'),
              onTap: () => _openDirections('walking'),
            ),
            ListTile(
              leading: const Icon(Icons.directions_bike, color: Colors.purple),
              title: const Text('En bicicleta'),
              subtitle: const Text('Ruta en bici'),
              onTap: () => _openDirections('bicycling'),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _openDirections(String mode) {
    Get.back(); // Cerrar el bottom sheet
    
    // Coordenadas de Capachica (aproximadas)
    const String destination = '-15.6425000,-69.8330000';
    const String destinationName = 'Capachica, Puno, Perú';
    
    // Crear URL de Google Maps con direcciones
    final String mapsUrl = 'https://www.google.com/maps/dir/?api=1&destination=$destination&travelmode=$mode&destination_place_id=$destinationName';
    
    launchMapsUrl(mapsUrl);
  }

  Future<void> _launchMapsUrl(String url) async {
    try {
      final Uri uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        Get.snackbar(
          'Error',
          'No se pudo abrir Google Maps',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Error al abrir Google Maps: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> launchMapsUrl(String url) async {
    try {
      final Uri uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        Get.snackbar(
          'Error',
          'No se pudo abrir Google Maps',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Error al abrir Google Maps: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
} 