import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/maps_controller.dart';
import '../../../core/constants/app_colors.dart';
import '../../widgets/common/custom_app_bar.dart';
import '../../widgets/common/loading_widget.dart';

class MapsPage extends GetView<MapsController> {
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
                title: 'Cómo Llegar',
                showBackButton: true,
                backgroundColor: Colors.transparent,
                titleColor: Colors.white,
                iconColor: Colors.white,
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
                      // Header con imagen
                      Container(
                        height: 200,
                        width: double.infinity,
                        margin: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: const DecorationImage(
                            image: AssetImage('assets/images/capachica_landscape.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.black.withOpacity(0.7),
                              ],
                            ),
                          ),
                          child: const Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.location_on,
                                  size: 48,
                                  color: Colors.white,
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Capachica, Puno',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  'Paraíso Turístico del Lago Titicaca',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white70,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      // Información de ubicación
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              children: [
                                const Row(
                                  children: [
                                    Icon(Icons.info_outline, color: AppColors.primary),
                                    SizedBox(width: 8),
                                    Text(
                                      'Información de Ubicación',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                _buildInfoRow('Región', 'Puno, Perú'),
                                _buildInfoRow('Coordenadas', '-15.6425° S, -69.8330° W'),
                                _buildInfoRow('Altitud', '3,812 m.s.n.m.'),
                                _buildInfoRow('Distancia desde Puno', 'Aproximadamente 45 km'),
                              ],
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Botones de opciones
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            _buildOptionButton(
                              icon: Icons.directions,
                              title: 'Obtener Direcciones',
                              subtitle: 'Abre Google Maps con la ruta',
                              color: Colors.blue,
                              onTap: () => controller.showMapsOptions(),
                            ),
                            const SizedBox(height: 12),
                            _buildOptionButton(
                              icon: Icons.map,
                              title: 'Ver en Google Maps',
                              subtitle: 'Abre la ubicación en el mapa',
                              color: Colors.green,
                              onTap: () => _openGoogleMaps(),
                            ),
                            const SizedBox(height: 12),
                            _buildOptionButton(
                              icon: Icons.location_city,
                              title: 'Información Turística',
                              subtitle: 'Conoce más sobre Capachica',
                              color: Colors.orange,
                              onTap: () => _showTouristInfo(),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Información adicional
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Card(
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Row(
                                    children: [
                                      Icon(Icons.travel_explore, color: AppColors.primary),
                                      SizedBox(width: 8),
                                      Text(
                                        'Consejos de Viaje',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  _buildTip('• La mejor época para visitar es de mayo a octubre'),
                                  _buildTip('• Lleva ropa abrigada, las noches son frías'),
                                  _buildTip('• Respeta las costumbres locales'),
                                  _buildTip('• Lleva efectivo, no hay muchos cajeros'),
                                  _buildTip('• Contrata guías locales para mejor experiencia'),
                                ],
                              ),
                            ),
                          ),
                        ),
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

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOptionButton({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: color.withOpacity(0.1),
          foregroundColor: color,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: color.withOpacity(0.3)),
          ),
          elevation: 0,
        ),
        child: Row(
          children: [
            Icon(icon, size: 24),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: color,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: color.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, size: 16, color: color),
          ],
        ),
      ),
    );
  }

  Widget _buildTip(String tip) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Text(
        tip,
        style: const TextStyle(
          fontSize: 13,
          color: Colors.grey,
        ),
      ),
    );
  }

  void _openGoogleMaps() {
    // Coordenadas de Capachica
    const String destination = '-15.6425000,-69.8330000';
    final String mapsUrl = 'https://www.google.com/maps?q=$destination';
    
    controller.launchMapsUrl(mapsUrl);
  }

  void _showTouristInfo() {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Información Turística',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Capachica es una península ubicada en el Lago Titicaca, conocida por su turismo vivencial y hermosos paisajes. Aquí podrás disfrutar de:',
                style: TextStyle(fontSize: 14),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              _buildInfoItem('🏠', 'Turismo vivencial en comunidades'),
              _buildInfoItem('🚣', 'Paseos en botes tradicionales'),
              _buildInfoItem('🏔️', 'Vistas panorámicas del lago'),
              _buildInfoItem('🍽️', 'Gastronomía local'),
              _buildInfoItem('🎭', 'Cultura y tradiciones'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => Get.back(),
                child: const Text('Cerrar'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoItem(String emoji, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 20)),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
} 