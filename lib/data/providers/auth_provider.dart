import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import '../models/user_model.dart';
import '../../core/constants/api_config.dart';

class AuthProvider {
  final String baseUrl = 'https://api.capachica-tourism.com'; // Cambia por tu API

  Future<UserModel> signInWithEmail(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiConfig.baseUrl}/auth/signin'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return UserModel.fromJson(data['user']);
      } else {
        final errorData = jsonDecode(response.body);
        throw Exception(errorData['message'] ?? 'Error al iniciar sesión');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }

  Future<UserModel> signInWithGoogle() async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      return UserModel(
        id: '1',
        name: 'Usuario Google',
        email: 'usuario@gmail.com',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
    } catch (e) {
      throw Exception('Error al iniciar sesión con Google: $e');
    }
  }

  Future<UserModel> signUp(
    String name, 
    String email, 
    String password, {
    String? phone,
    String? country,
    String? birthDate,
    String? address,
    String? gender,
    String? preferredLanguage,
    String? fotoPerfil,
  }) async {
    try {
      // Crear el objeto de datos del usuario
      final userData = {
        'name': name,
        'email': email,
        'password': password,
        'password_confirmation': password,
        'phone': phone,
        'country': country,
        'birth_date': birthDate,
        'address': address,
        'gender': gender,
        'preferred_language': preferredLanguage,
      };

      // Crear request multipart
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('${ApiConfig.baseUrl}/register'),
      );

      // Agregar headers
      request.headers['Accept'] = 'application/json';

      // Agregar campos de texto
      userData.forEach((key, value) {
        if (value != null && value.isNotEmpty) {
          request.fields[key] = value;
        }
      });

      // Agregar archivo de foto si existe
      if (fotoPerfil != null && fotoPerfil.isNotEmpty) {
        final file = File(fotoPerfil);
        if (await file.exists()) {
          request.files.add(
            await http.MultipartFile.fromPath(
              'foto_perfil',
              fotoPerfil,
              filename: 'profile_photo.jpg',
            ),
          );
        }
      }

      // Enviar request
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      // Imprimir respuesta para debug
      print('Respuesta del servidor: ${response.body}');

      if (response.statusCode == 201 || response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['user'] != null) {
          return UserModel.fromJson(data['user']);
        } else {
          throw Exception('Error: La respuesta no contiene datos del usuario');
        }
      } else {
        final errorData = jsonDecode(response.body);
        if (errorData['errors'] != null) {
          // Construir mensaje de error detallado
          String errorMsg = '';
          final errors = errorData['errors'];
          if (errors is Map) {
            errors.forEach((key, value) {
              if (value is List) {
                errorMsg += '${key.toUpperCase()}: ${value.join(', ')}\n';
              } else {
                errorMsg += '${key.toUpperCase()}: $value\n';
              }
            });
          }
          throw Exception(errorMsg.isEmpty ? 'Error de validación' : errorMsg.trim());
        }
        throw Exception(errorData['message'] ?? 'Error al registrarse');
      }
    } catch (e) {
      print('Error detallado en AuthProvider.signUp: $e');
      if (e is Exception) {
        throw e;
      }
      throw Exception('Error de conexión: $e');
    }
  }

  Future<void> signOut() async {
    try {
      await http.post(
        Uri.parse('${ApiConfig.baseUrl}/auth/signout'),
        headers: {'Content-Type': 'application/json'},
      );
    } catch (e) {
      throw Exception('Error al cerrar sesión: $e');
    }
  }

  Future<Map<String, dynamic>> verifyEmail(String id, String hash) async {
    try {
      final response = await http.get(
        Uri.parse('${ApiConfig.baseUrl}/email/verify/$id/$hash'),
        headers: {'Accept': 'application/json'},
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Error al verificar el email: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }
}