// Configuración de debug para controlar funcionalidades
class DebugConfig {
  // Habilitar/deshabilitar llamadas a la API
  static const bool enableApiCalls = false;
  
  // Habilitar/deshabilitar logs detallados
  static const bool enableDetailedLogs = true;
  
  // Habilitar/deshabilitar carga de datos de municipalidad
  static const bool enableMunicipalidadLoad = false;
  
  // Habilitar/deshabilitar carga de usuario
  static const bool enableUserLoad = true;
  
  // Timeout para llamadas HTTP (en segundos)
  static const int httpTimeout = 10;
  
  // Mostrar logs de debug
  static void log(String message) {
    if (enableDetailedLogs) {
      print('[DEBUG] $message');
    }
  }
} 