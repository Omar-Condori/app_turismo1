import '../providers/auth_provider.dart';
import '../models/user_model.dart';
import '../../core/services/storage_service.dart';

class AuthRepository {
  final AuthProvider _authProvider;
  final StorageService _storageService = StorageService();

  AuthRepository(this._authProvider);

  Future<UserModel> signInWithEmail(String email, String password) async {
    try {
      final user = await _authProvider.signInWithEmail(email, password);
      await _storageService.saveUser(user);
      return user;
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel> signInWithGoogle() async {
    try {
      final user = await _authProvider.signInWithGoogle();
      await _storageService.saveUser(user);
      return user;
    } catch (e) {
      rethrow;
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
      final user = await _authProvider.signUp(
        name, 
        email, 
        password,
        phone: phone,
        country: country,
        birthDate: birthDate,
        address: address,
        gender: gender,
        preferredLanguage: preferredLanguage,
        fotoPerfil: fotoPerfil,
      );
      await _storageService.saveUser(user);
      return user;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signOut() async {
    try {
      await _authProvider.signOut();
      await _storageService.clearUser();
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel?> getCurrentUser() async {
    return await _storageService.getUser();
  }

  Future<bool> isLoggedIn() async {
    final user = await getCurrentUser();
    return user != null;
  }

  Future<void> saveUser(UserModel user) async {
    try {
      await _storageService.saveUser(user);
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> verifyEmail(String id, String hash) async {
    try {
      final response = await _authProvider.verifyEmail(id, hash);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}