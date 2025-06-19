import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../controllers/home_controller.dart';
import '../../../core/constants/app_colors.dart';
import '../../../data/models/municipalidad_model.dart';
import '../../widgets/common/custom_app_bar.dart';
import '../../widgets/common/loading_widget.dart';

class MunicipalidadPage extends GetView<HomeController> {
  // Sistema de colores renovado
  static const Color primaryBlue = Color(0xFF667EEA);
  static const Color secondaryPurple = Color(0xFF764BA2);
  static const Color accentGold = Color(0xFFFFD700);
  static const Color lightGray = Color(0xFFF8F9FA);
  static const Color darkGray = Color(0xFF2C3E50);
  static const Color softBlue = Color(0xFFEBF5FF);
  static const Color successGreen = Color(0xFF27AE60);
  static const Color warmOrange = Color(0xFFE67E22);
  static const Color gradientStart = Color(0xFF5B6EE2);
  static const Color gradientEnd = Color(0xFF6D4BC2);

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
                title: 'Resumen Municipal',
                showBackButton: true,
                backgroundColor: Colors.transparent,
                titleColor: Colors.white,
                iconColor: Colors.white,
                actions: [
                  IconButton(
                    onPressed: () => controller.loadMunicipalidadInfo(),
                    icon: const Icon(Icons.refresh, color: Colors.white),
                  ),
                ],
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
                  child: Obx(() {
                    // Si está cargando, mostrar loading
                    if (controller.isLoading.value) {
                      return const LoadingWidget();
                    }

                    // Si no está cargando pero no hay datos, mostrar mensaje de error
                    if (controller.municipalidad.value == null) {
                      return _buildErrorState();
                    }

                    final municipalidad = controller.municipalidad.value!;

                    return CustomScrollView(
                      slivers: [
                        SliverToBoxAdapter(
                          child: Column(
                            children: [
                              _buildWelcomeHeader(municipalidad),
                              _buildFraseDestacada(municipalidad),
                              _buildMisionVision(municipalidad),
                              _buildSectionDivider('Acerca de Nosotros', Icons.info_outline),
                              _buildAnimatedCard(_buildDescripcionCard(municipalidad)),
                              _buildSectionDivider('Historia', Icons.bookmark_border),
                              _buildAnimatedCard(_buildHistoriaCard(municipalidad)),
                              _buildSectionDivider('Comunidades', Icons.groups_2_outlined),
                              _buildAnimatedCard(_buildComunidadesCard(municipalidad)),
                              _buildSectionDivider('Contacto', Icons.contact_phone_outlined),
                              _buildAnimatedCard(_buildContactoCard(municipalidad)),
                              _buildSectionDivider('Redes Sociales', Icons.share_outlined),
                              _buildAnimatedCard(_buildRedesSocialesCard(municipalidad)),
                              const SizedBox(height: 32),
                            ],
                          ),
                        ),
                      ],
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 80,
            color: Colors.red[300],
          ),
          const SizedBox(height: 16),
          Text(
            'Error de conexión',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'No se pudo conectar con el servidor. Por favor, verifica tu conexión a internet e inténtalo de nuevo.',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () => controller.loadMunicipalidadInfo(),
            icon: const Icon(Icons.refresh),
            label: const Text('Reintentar'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWelcomeHeader(MunicipalidadModel municipalidad) {
    return _buildAnimatedCard(
      Container(
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.all(28),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.white, softBlue.withOpacity(0.6)],
          ),
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: primaryBlue.withOpacity(0.15),
              blurRadius: 20,
              offset: const Offset(0, 8),
              spreadRadius: 3,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: warmOrange.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Icon(
                    Icons.waving_hand,
                    size: 36,
                    color: warmOrange,
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '¡Bienvenido!',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                          color: darkGray,
                          fontFamily: 'Roboto', // Fuente diferente para el título
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Conoce nuestra institución y lo que hacemos por la comunidad de Capachica.',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey[700],
                          fontWeight: FontWeight.w500,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (municipalidad.fotoBienvenida.isNotEmpty) ...[
              const SizedBox(height: 24),
              ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: Image.network(
                  municipalidad.fotoBienvenida,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 200,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      height: 200,
                      color: Colors.grey[200],
                      child: Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                              : null,
                          valueColor: AlwaysStoppedAnimation<Color>(primaryBlue),
                        ),
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 200,
                    color: Colors.grey[300],
                    child: Icon(Icons.broken_image, size: 50, color: Colors.grey[600]),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildFraseDestacada(MunicipalidadModel municipalidad) {
    return _buildAnimatedCard(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [accentGold, warmOrange],
                ),
                borderRadius: BorderRadius.circular(28),
                boxShadow: [
                  BoxShadow(
                    color: accentGold.withOpacity(0.4),
                    blurRadius: 25,
                    offset: const Offset(0, 10),
                    spreadRadius: 3,
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Icon(
                    Icons.format_quote_rounded,
                    size: 48,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    municipalidad.frase,
                    style: const TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      height: 1.5,
                      fontStyle: FontStyle.italic,
                      fontFamily: 'Merriweather', // Fuente con serifa para citas
                      letterSpacing: 0.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Container(
                    width: 80,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ],
              ),
            ),
            // Decoración en esquina
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(28),
                    bottomLeft: Radius.circular(50),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMisionVision(MunicipalidadModel municipalidad) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 600) {
            // Diseño para pantallas más grandes (web/tablet)
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _buildAnimatedCard(
                    _buildMiniCard(
                      title: 'Misión',
                      content: municipalidad.mision,
                      icon: Icons.flag_outlined,
                      color: primaryBlue,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildAnimatedCard(
                    _buildMiniCard(
                      title: 'Visión',
                      content: municipalidad.vision,
                      icon: Icons.visibility_outlined,
                      color: successGreen,
                    ),
                  ),
                ),
              ],
            );
          } else {
            // Diseño para pantallas pequeñas (móvil)
            return Column(
              children: [
                _buildAnimatedCard(
                  _buildMiniCard(
                    title: 'Misión',
                    content: municipalidad.mision,
                    icon: Icons.flag_outlined,
                    color: primaryBlue,
                  ),
                ),
                const SizedBox(height: 16),
                _buildAnimatedCard(
                  _buildMiniCard(
                    title: 'Visión',
                    content: municipalidad.vision,
                    icon: Icons.visibility_outlined,
                    color: successGreen,
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  Widget _buildMiniCard({
    required String title,
    required String content,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(24),
      constraints: const BoxConstraints(
        minHeight: 200, // Altura mínima para mejor estética
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: color.withOpacity(0.3), width: 1.8),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.12),
            blurRadius: 18,
            offset: const Offset(0, 8),
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: darkGray,
              fontFamily: 'Lato', // Fuente para títulos de cards
            ),
          ),
          const SizedBox(height: 10),
          Text(
            content,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
              height: 1.6,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDescripcionCard(MunicipalidadModel municipalidad) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 8),
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [primaryBlue.withOpacity(0.2), softBlue],
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(Icons.description_outlined, color: primaryBlue, size: 28),
              ),
              const SizedBox(width: 18),
              Text(
                'Descripción',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: darkGray,
                  fontFamily: 'Montserrat',
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            municipalidad.descripcion,
            style: TextStyle(
              fontSize: 16,
              height: 1.7,
              color: Colors.grey[700],
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoriaCard(MunicipalidadModel municipalidad) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white,
            warmOrange.withOpacity(0.08),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: warmOrange.withOpacity(0.15),
            blurRadius: 20,
            offset: const Offset(0, 8),
            spreadRadius: 3,
          ),
        ],
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: warmOrange.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Icon(Icons.history_edu, color: warmOrange, size: 28),
                    ),
                    const SizedBox(width: 18),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Historia de Capachica',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                              color: darkGray,
                              fontFamily: 'Montserrat',
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Nuestras raíces, evolución y legado cultural.',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Text(
                  municipalidad.historiaCapachica,
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.7,
                    color: Colors.grey[700],
                    fontWeight: FontWeight.w400,
                  ),
                ),
                if (municipalidad.fotoHistoria.isNotEmpty) ...[
                  const SizedBox(height: 24),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: Image.network(
                      municipalidad.fotoHistoria,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 200,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          height: 200,
                          color: Colors.grey[200],
                          child: Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                  : null,
                              valueColor: AlwaysStoppedAnimation<Color>(warmOrange),
                            ),
                          ),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) => Container(
                        height: 200,
                        color: Colors.grey[300],
                        child: Icon(Icons.broken_image, size: 50, color: Colors.grey[600]),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
          // Decoración lateral
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            child: Container(
              width: 6,
              decoration: BoxDecoration(
                color: warmOrange.withOpacity(0.7),
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildComunidadesCard(MunicipalidadModel municipalidad) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: successGreen.withOpacity(0.3), width: 1.8),
        boxShadow: [
          BoxShadow(
            color: successGreen.withOpacity(0.12),
            blurRadius: 20,
            offset: const Offset(0, 8),
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: successGreen.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(Icons.location_city_outlined, color: successGreen, size: 28),
              ),
              const SizedBox(width: 18),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Nuestras Comunidades',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: darkGray,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Unidos por el desarrollo y la cultura.',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            municipalidad.comunidades,
            style: TextStyle(
              fontSize: 16,
              height: 1.7,
              color: Colors.grey[700],
              fontWeight: FontWeight.w400,
            ),
          ),
          if (municipalidad.fotoComunidades.isNotEmpty) ...[
            const SizedBox(height: 24),
            ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: Image.network(
                municipalidad.fotoComunidades,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 200,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    height: 200,
                    color: Colors.grey[200],
                    child: Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                            : null,
                        valueColor: AlwaysStoppedAnimation<Color>(successGreen),
                      ),
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 200,
                  color: Colors.grey[300],
                  child: Icon(Icons.broken_image, size: 50, color: Colors.grey[600]),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildContactoCard(MunicipalidadModel municipalidad) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [darkGray.withOpacity(0.95), Colors.black87],
        ),
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 25,
            offset: const Offset(0, 10),
            spreadRadius: 3,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(Icons.contact_mail_outlined, color: Colors.white, size: 28),
              ),
              const SizedBox(width: 18),
              Text(
                'Contáctanos',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  fontFamily: 'Montserrat',
                ),
              ),
            ],
          ),
          const SizedBox(height: 28),
          _buildContactRow(Icons.email_outlined, 'Correo electrónico', municipalidad.correo),
          const SizedBox(height: 20),
          _buildContactRow(Icons.access_time_outlined, 'Horario de atención', municipalidad.horarioDeAtencion),
        ],
      ),
    );
  }

  Widget _buildContactRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: accentGold, size: 24),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Colors.white.withOpacity(0.85),
                  fontFamily: 'Lato',
                ),
              ),
              const SizedBox(height: 6),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRedesSocialesCard(MunicipalidadModel municipalidad) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 8),
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [primaryBlue.withOpacity(0.2), softBlue],
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(Icons.share_outlined, color: primaryBlue, size: 28),
              ),
              const SizedBox(width: 18),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Síguenos en Redes Sociales',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: darkGray,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Mantente conectado con nuestras últimas noticias y eventos.',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 28),
          Center(
            child: LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth > 500) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _buildSocialMediaButtons(municipalidad),
                  );
                } else {
                  return Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 12.0,
                    runSpacing: 12.0,
                    children: _buildSocialMediaButtons(municipalidad),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildSocialMediaButtons(MunicipalidadModel municipalidad) {
    List<Widget> buttons = [];
    if (municipalidad.redFacebook.isNotEmpty) {
      buttons.add(_buildSocialMediaButton(
        'Facebook',
        Icons.facebook,
        const Color(0xFF1877F2),
        municipalidad.redFacebook,
      ));
    }
    if (municipalidad.redInstagram.isNotEmpty) {
      buttons.add(_buildSocialMediaButton(
        'Instagram',
        Icons.camera_alt_outlined,
        const Color(0xFFE4405F),
        municipalidad.redInstagram,
      ));
    }
    if (municipalidad.redYoutube.isNotEmpty) {
      buttons.add(_buildSocialMediaButton(
        'YouTube',
        Icons.play_circle_outline,
        const Color(0xFFFF0000),
        municipalidad.redYoutube,
      ));
    }
    return buttons;
  }

  Widget _buildSocialMediaButton(String platform, IconData icon, Color color, String url) {
    return InkWell(
      onTap: () => _launchURL(url),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: 80,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        decoration: BoxDecoration(
          color: color.withOpacity(0.10),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withOpacity(0.3), width: 1.2),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.12),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 22),
            const SizedBox(height: 6),
            Text(
              platform,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: darkGray,
                fontFamily: 'Lato',
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionDivider(String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Row(
        children: [
          Expanded(
            child: Divider(
              color: Colors.grey[300],
              thickness: 1,
              indent: 0,
              endIndent: 12,
            ),
          ),
          Icon(icon, color: primaryBlue.withOpacity(0.7), size: 20),
          const SizedBox(width: 8),
          Text(
            title,
            style: TextStyle(
              color: darkGray,
              fontSize: 18,
              fontWeight: FontWeight.w700,
              fontFamily: 'Roboto',
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Divider(
              color: Colors.grey[300],
              thickness: 1,
              indent: 12,
              endIndent: 0,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedCard(Widget child) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOutCubic,
      builder: (context, value, _) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 50 * (1 - value)),
            child: child,
          ),
        );
      },
    );
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      Get.snackbar(
        'Error',
        'No se pudo abrir el enlace: $url',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade600,
        colorText: Colors.white,
        borderRadius: 15,
        margin: const EdgeInsets.all(20),
        duration: const Duration(seconds: 3),
        snackStyle: SnackStyle.FLOATING,
      );
    }
  }
}