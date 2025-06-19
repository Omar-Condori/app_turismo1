import 'dart:io';
import 'package:flutter/foundation.dart';

// Configuración de la API
class ApiConfig {
  // URL base para diferentes entornos
  // Android emulador: 10.0.2.2, iOS simulador: localhost, Web: 127.0.0.1
  static const String baseUrlAndroid = 'http://10.0.2.2:8000/api';
  static const String baseUrlIOS = 'http://localhost:8000/api';
  static const String baseUrlWeb = 'http://127.0.0.1:8000/api';
  
  // Función para obtener la URL base según la plataforma
  static String get baseUrl {
    if (kIsWeb) {
      return baseUrlWeb;
    } else if (Platform.isAndroid) {
      return baseUrlAndroid;
    } else if (Platform.isIOS) {
      return baseUrlIOS;
    } else {
      // Por defecto usar Android (10.0.2.2)
      return baseUrlAndroid;
    }
  }
  
  // Función para debug - mostrar qué URL se está usando
  static void printCurrentUrl() {
    print('API Config - URL actual: [32m${baseUrl}[0m');
  }
} 