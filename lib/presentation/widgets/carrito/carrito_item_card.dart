import 'package:flutter/material.dart';
import '../../../data/models/carrito_model.dart';

class CarritoItemCard extends StatelessWidget {
  final CarritoItemModel item;
  final Function(int) onActualizarCantidad;
  final VoidCallback onEliminar;

  const CarritoItemCard({
    Key? key,
    required this.item,
    required this.onActualizarCantidad,
    required this.onEliminar,
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
          // Header con imagen y botón eliminar
          _buildHeader(),
          
          // Contenido del item
          _buildContent(),
          
          // Controles de cantidad
          _buildCantidadControls(),
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
          image: item.servicio?.imagenUrl != null
              ? NetworkImage(item.servicio!.imagenUrl!)
              : const AssetImage('assets/images/capachica_view1.jpg') as ImageProvider,
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          // Botón eliminar
          Positioned(
            top: 8,
            right: 8,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.9),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.white, size: 20),
                onPressed: onEliminar,
                padding: const EdgeInsets.all(4),
                constraints: const BoxConstraints(
                  minWidth: 32,
                  minHeight: 32,
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
            item.servicio?.nombre ?? 'Servicio no disponible',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          
          const SizedBox(height: 8),
          
          // Emprendedor
          if (item.servicio?.emprendedor != null)
            Row(
              children: [
                Icon(
                  Icons.business,
                  size: 16,
                  color: Colors.grey[600],
                ),
                const SizedBox(width: 4),
                Text(
                  item.servicio!.emprendedor!.nombre,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          
          const SizedBox(height: 12),
          
          // Precio unitario
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Precio unitario:',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              Text(
                'S/ ${item.precioUnitario}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1976D2),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 8),
          
          // Subtotal
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Subtotal:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700],
                ),
              ),
              Text(
                'S/ ${item.subtotal}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4CAF50),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCantidadControls() {
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Cantidad:',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey[700],
            ),
          ),
          Row(
            children: [
              // Botón disminuir
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: IconButton(
                  icon: const Icon(Icons.remove, size: 20),
                  onPressed: item.cantidad > 1 
                      ? () => onActualizarCantidad(item.cantidad - 1)
                      : null,
                  color: item.cantidad > 1 ? Colors.black87 : Colors.grey[400],
                  padding: const EdgeInsets.all(8),
                  constraints: const BoxConstraints(
                    minWidth: 40,
                    minHeight: 40,
                  ),
                ),
              ),
              
              // Cantidad actual
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: Text(
                  '${item.cantidad}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              
              // Botón aumentar
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF1976D2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: IconButton(
                  icon: const Icon(Icons.add, size: 20, color: Colors.white),
                  onPressed: () => onActualizarCantidad(item.cantidad + 1),
                  padding: const EdgeInsets.all(8),
                  constraints: const BoxConstraints(
                    minWidth: 40,
                    minHeight: 40,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
} 