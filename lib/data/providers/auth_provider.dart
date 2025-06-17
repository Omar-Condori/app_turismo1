import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/user_model.dart';

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

  Future<UserModel> signUp(String name, String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/signup'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': name,
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return UserModel.fromJson(data['user']);
      } else {
        throw Exception('Error al registrarse');
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
        Uri.parse('http://127.0.0.1:8000/api/email/verify/$id/$hash'),
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