import 'package:flutter/material.dart';

class EmptyReservasWidget extends StatelessWidget {
  const EmptyReservasWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icono ilustrativo
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.calendar_today_outlined,
                size: 60,
                color: Colors.blue[400],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Título
            Text(
              'No tienes reservas',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.grey[700],
              ),
            ),
            
            const SizedBox(height: 12),
            
            // Descripción
            Text(
              'Aún no has realizado ninguna reserva.\nExplora nuestros servicios y reserva tu próxima aventura.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
                height: 1.5,
              ),
            ),
            
            const SizedBox(height: 32),
            
            // Botón para explorar servicios
            ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context).pop(); // Regresar a la página anterior
              },
              icon: const Icon(Icons.explore),
              label: const Text('Explorar Servicios'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1976D2),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 2,
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Información adicional
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.orange.withOpacity(0.3),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    color: Colors.orange[700],
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Para hacer una reserva, primero debes iniciar sesión en tu cuenta.',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.orange[800],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
} 