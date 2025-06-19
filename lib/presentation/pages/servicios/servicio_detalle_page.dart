import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/servicio_detalle_controller.dart';
import '../../../core/constants/app_colors.dart';
import '../../../data/models/servicio_detalle_model.dart';
import '../../widgets/common/custom_app_bar.dart';
import '../../widgets/common/loading_widget.dart';

class ServicioDetallePage extends GetView<ServicioDetalleController> {
  final int servicioId;

  ServicioDetallePage({required this.servicioId});

  @override
  Widget build(BuildContext context) {
    // Cargar datos al inicializar la página
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.loadServicioDetalle(servicioId);
    });

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
                title: 'Detalles del Servicio',
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
                  child: Obx(() {
                    if (controller.isLoading.value) {
                      return const LoadingWidget();
                    }

                    if (controller.hasError) {
                      return _buildErrorState();
                    }

                    if (!controller.hasData) {
                      return _buildEmptyState();
                    }

                    return _buildContent();
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    final servicio = controller.servicioDetalle.value!;
    
    return RefreshIndicator(
      onRefresh: () => controller.loadServicioDetalle(servicioId),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header con información principal
            _buildHeader(servicio),
            const SizedBox(height: 24),

            // Información de precio
            _buildPrecioCard(servicio),
            const SizedBox(height: 16),

            // Información de ubicación
            _buildUbicacionCard(servicio),
            const SizedBox(height: 16),

            // Información de disponibilidad
            _buildDisponibilidadCard(),
            const SizedBox(height: 16),

            // Información del emprendedor
            if (servicio.emprendedor != null) ...[
              _buildEmprendedorCard(servicio.emprendedor!),
              const SizedBox(height: 16),
            ],

            // Información de la categoría
            if (servicio.categoria != null) ...[
              _buildCategoriaCard(servicio.categoria!),
              const SizedBox(height: 16),
            ],

            // Botones de acción
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(ServicioDetalleModel servicio) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primary.withOpacity(0.1), AppColors.primary.withOpacity(0.05)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primary.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.miscellaneous_services,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      servicio.nombre,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: servicio.estado ? Colors.green : Colors.red,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        servicio.estado ? 'Activo' : 'Inactivo',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            servicio.descripcion,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black54,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPrecioCard(ServicioDetalleModel servicio) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.green.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(
            Icons.attach_money,
            color: Colors.green[700],
            size: 24,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Precio Referencial',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.green[700],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  'S/. ${servicio.precioReferencial}',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.green[700],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUbicacionCard(ServicioDetalleModel servicio) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.location_on,
                color: Colors.blue[700],
                size: 24,
              ),
              const SizedBox(width: 12),
              Text(
                'Ubicación',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.blue[700],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            servicio.ubicacionReferencia,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
          if (servicio.ubicacion != null) ...[
            const SizedBox(height: 8),
            Text(
              'Coordenadas: ${servicio.ubicacion!.latitud}, ${servicio.ubicacion!.longitud}',
              style: const TextStyle(
                fontSize: 12,
                color: Colors.black54,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildDisponibilidadCard() {
    return Obx(() {
      final disponibilidad = controller.disponibilidad.value;
      
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.orange.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.orange.withOpacity(0.3)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.schedule,
                  color: Colors.orange[700],
                  size: 24,
                ),
                const SizedBox(width: 12),
                Text(
                  'Disponibilidad',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.orange[700],
                  ),
                ),
                if (controller.isLoadingDisponibilidad.value) ...[
                  const SizedBox(width: 8),
                  const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 12),
            if (disponibilidad != null) ...[
              Row(
                children: [
                  Icon(
                    disponibilidad.disponible ? Icons.check_circle : Icons.cancel,
                    color: disponibilidad.disponible ? Colors.green : Colors.red,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    disponibilidad.disponible ? 'Disponible' : 'No disponible',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: disponibilidad.disponible ? Colors.green : Colors.red,
                    ),
                  ),
                ],
              ),
              if (disponibilidad.horario != null) ...[
                const SizedBox(height: 8),
                Text(
                  'Horario: ${disponibilidad.horario}',
                  style: const TextStyle(fontSize: 14, color: Colors.black87),
                ),
              ],
              if (disponibilidad.diasDisponibles != null) ...[
                const SizedBox(height: 4),
                Text(
                  'Días: ${disponibilidad.diasDisponibles}',
                  style: const TextStyle(fontSize: 14, color: Colors.black87),
                ),
              ],
              if (disponibilidad.notas != null) ...[
                const SizedBox(height: 8),
                Text(
                  'Notas: ${disponibilidad.notas}',
                  style: const TextStyle(fontSize: 12, color: Colors.black54),
                ),
              ],
            ] else ...[
              Text(
                'Información no disponible',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ],
        ),
      );
    });
  }

  Widget _buildEmprendedorCard(EmprendedorDetalleModel emprendedor) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.purple.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.purple.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.business,
                color: Colors.purple[700],
                size: 24,
              ),
              const SizedBox(width: 12),
              Text(
                'Emprendedor',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.purple[700],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            emprendedor.nombre,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            emprendedor.descripcion,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(Icons.phone, size: 16, color: Colors.grey[600]),
              const SizedBox(width: 8),
              Text(
                emprendedor.telefono,
                style: const TextStyle(fontSize: 14, color: Colors.black87),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(Icons.email, size: 16, color: Colors.grey[600]),
              const SizedBox(width: 8),
              Text(
                emprendedor.email,
                style: const TextStyle(fontSize: 14, color: Colors.black87),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCategoriaCard(CategoriaDetalleModel categoria) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.teal.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.teal.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.category,
                color: Colors.teal[700],
                size: 24,
              ),
              const SizedBox(width: 12),
              Text(
                'Categoría',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.teal[700],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            categoria.nombre,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            categoria.descripcion,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () {
              // Aquí puedes implementar la funcionalidad para contactar
              Get.snackbar(
                'Contacto',
                'Funcionalidad de contacto en desarrollo',
                snackPosition: SnackPosition.BOTTOM,
              );
            },
            icon: const Icon(Icons.phone),
            label: const Text('Contactar'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () {
              // Aquí puedes implementar la funcionalidad para ver en mapa
              Get.snackbar(
                'Mapa',
                'Funcionalidad de mapa en desarrollo',
                snackPosition: SnackPosition.BOTTOM,
              );
            },
            icon: const Icon(Icons.map),
            label: const Text('Ver en Mapa'),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.primary,
              side: BorderSide(color: AppColors.primary),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ],
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
            color: Colors.red[400],
          ),
          const SizedBox(height: 16),
          Text(
            'Error al cargar los detalles',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.red[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            controller.errorMessage.value,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                onPressed: () => controller.loadServicioDetalle(servicioId),
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
              ElevatedButton.icon(
                onPressed: () => _loadMockData(),
                icon: const Icon(Icons.bug_report),
                label: const Text('Debug'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _loadMockData() {
    // Crear datos mock para testing
    final mockServicio = ServicioDetalleModel(
      id: servicioId,
      nombre: 'Servicio de Prueba',
      descripcion: 'Este es un servicio de prueba para verificar que la navegación funciona correctamente.',
      precioReferencial: '50.00',
      ubicacionReferencia: 'Capachica, Puno',
      estado: true,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      ubicacion: UbicacionModel(
        latitud: -15.8402,
        longitud: -70.0219,
        direccion: 'Capachica, Puno, Perú',
        referencia: 'Cerca de la plaza principal',
      ),
      disponibilidad: DisponibilidadModel(
        disponible: true,
        horario: '8:00 AM - 6:00 PM',
        diasDisponibles: 'Lunes a Domingo',
        notas: 'Disponible todo el año',
      ),
      emprendedor: EmprendedorDetalleModel(
        id: 1,
        nombre: 'Juan Pérez',
        descripcion: 'Emprendedor local con 5 años de experiencia',
        telefono: '+51 999 123 456',
        email: 'juan.perez@example.com',
        sitioWeb: 'www.juanperez.com',
        redesSociales: '@juanperez',
      ),
      categoria: CategoriaDetalleModel(
        id: 1,
        nombre: 'Turismo',
        descripcion: 'Servicios turísticos y recreativos',
        icono: 'tourism_icon',
      ),
    );

    controller.servicioDetalle.value = mockServicio;
    controller.ubicacion.value = mockServicio.ubicacion;
    controller.disponibilidad.value = mockServicio.disponibilidad;
    controller.emprendedor.value = mockServicio.emprendedor;
    controller.categoria.value = mockServicio.categoria;
    controller.errorMessage.value = '';
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.miscellaneous_services,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'No se encontraron detalles',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Los detalles del servicio no están disponibles',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
} 