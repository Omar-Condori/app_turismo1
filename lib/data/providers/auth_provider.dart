import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/user_model.dart';
import '../../core/constants/api_config.dart';

class AuthProvider {
  final String baseUrl = 'https://api.capachica-tourism.com'; // Cambia por tu API

  Future<UserModel> signInWithEmail(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/signin'),
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
        throw Exception('Error al iniciar sesión');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }

  Future<UserModel> signInWithGoogle() async {
    try {
      // Implementar lógica de Google Sign In
      // Por ahora retornamos un usuario mock
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
      // Crear request multipart/form-data
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('${ApiConfig.baseUrl}/register'),
      );

      // Agregar headers
      request.headers['Accept'] = 'application/json';

      // Agregar campos de texto
      request.fields['name'] = name;
      request.fields['email'] = email;
      request.fields['password'] = password;
      request.fields['password_confirmation'] = password; // Usar la misma contraseña
      
      // Agregar campos opcionales
      if (phone != null && phone.isNotEmpty) {
        request.fields['phone'] = phone;
      }
      if (country != null && country.isNotEmpty) {
        request.fields['country'] = country;
      }
      if (birthDate != null && birthDate.isNotEmpty) {
        request.fields['birth_date'] = birthDate;
      }
      if (address != null && address.isNotEmpty) {
        request.fields['address'] = address;
      }
      if (gender != null && gender.isNotEmpty) {
        request.fields['gender'] = gender;
      }
      if (preferredLanguage != null && preferredLanguage.isNotEmpty) {
        request.fields['preferred_language'] = preferredLanguage;
      }

      // Agregar archivo de foto si existe
      if (fotoPerfil != null && fotoPerfil.isNotEmpty) {
        // Por ahora solo enviamos el nombre del archivo
        // En una implementación real, aquí se enviaría el archivo real
        request.fields['foto_perfil'] = fotoPerfil;
      }

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 201 || response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return UserModel.fromJson(data['user'] ?? data);
      } else {
        final errorData = jsonDecode(response.body);
        throw Exception(errorData['message'] ?? 'Error al registrarse');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }

  Future<void> signOut() async {
    try {
      await http.post(
        Uri.parse('$baseUrl/auth/signout'),
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