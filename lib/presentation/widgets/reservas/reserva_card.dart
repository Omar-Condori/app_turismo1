import 'package:flutter/material.dart';
import '../../../data/models/reserva_model.dart';

class ReservaCard extends StatelessWidget {
  final ReservaModel reserva;
  final VoidCallback? onCancelar;

  const ReservaCard({
    Key? key,
    required this.reserva,
    this.onCancelar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header con imagen y estado
          _buildHeader(),
          
          // Contenido de la reserva
          _buildContent(),
          
          // Acciones
          if (_puedeCancelar) _buildActions(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        image: DecorationImage(
          image: reserva.servicio?.imagenUrl != null
              ? NetworkImage(reserva.servicio!.imagenUrl!)
              : const AssetImage('assets/images/capachica_view1.jpg') as ImageProvider,
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          // Overlay para el estado
          Positioned(
            top: 12,
            right: 12,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: _getEstadoColor().withOpacity(0.9),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                reserva.estadoEspanol,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Nombre del servicio
          Text(
            reserva.servicio?.nombre ?? 'Servicio no disponible',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          
          const SizedBox(height: 8),
          
          // Emprendedor
          if (reserva.servicio?.emprendedor != null)
            Row(
              children: [
                Icon(
                  Icons.business,
                  size: 16,
                  color: Colors.grey[600],
                ),
                const SizedBox(width: 4),
                Text(
                  reserva.servicio!.emprendedor!.nombre,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          
          const SizedBox(height: 12),
          
          // Detalles de la reserva
          _buildDetailRow(
            Icons.calendar_today,
            'Fecha',
            reserva.fechaReserva,
          ),
          
          const SizedBox(height: 8),
          
          _buildDetailRow(
            Icons.access_time,
            'Hora',
            reserva.horaReserva,
          ),
          
          const SizedBox(height: 8),
          
          _buildDetailRow(
            Icons.people,
            'Personas',
            '${reserva.cantidadPersonas}',
          ),
          
          const SizedBox(height: 8),
          
          _buildDetailRow(
            Icons.attach_money,
            'Precio',
            'S/ ${reserva.servicio?.precioReferencial ?? '0.00'}',
          ),
          
          // Observaciones
          if (reserva.observaciones != null && reserva.observaciones!.isNotEmpty) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Colors.blue.withOpacity(0.3),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.note,
                        size: 16,
                        color: Colors.blue[700],
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Observaciones',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[700],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    reserva.observaciones!,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.blue[800],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: Colors.grey[600],
        ),
        const SizedBox(width: 8),
        Text(
          '$label: ',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  Widget _buildActions() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton.icon(
              onPressed: onCancelar,
              icon: const Icon(Icons.cancel, size: 18),
              label: const Text('Cancelar Reserva'),
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFFF44336),
                side: const BorderSide(color: Color(0xFFF44336)),
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getEstadoColor() {
    switch (reserva.estado.toLowerCase()) {
      case 'pending':
        return const Color(0xFFFFA000); // Naranja
      case 'confirmed':
        return const Color(0xFF4CAF50); // Verde
      case 'cancelled':
        return const Color(0xFFF44336); // Rojo
      case 'completed':
        return const Color(0xFF2196F3); // Azul
      default:
        return const Color(0xFF757575); // Gris
    }
  }

  bool get _puedeCancelar {
    return reserva.estado.toLowerCase() == 'pending' || 
           reserva.estado.toLowerCase() == 'confirmed';
  }
} 