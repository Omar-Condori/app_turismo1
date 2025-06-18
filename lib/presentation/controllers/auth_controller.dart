import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/repositories/auth_repository.dart';
import '../../app/routes/app_routes.dart';
import '../../data/models/user_model.dart';

class AuthController extends GetxController {
  final AuthRepository _authRepository = Get.find();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final countryController = TextEditingController();
  final birthDateController = TextEditingController();
  final addressController = TextEditingController();
  final genderController = TextEditingController();
  final preferredLanguageController = TextEditingController();
  final fotoPerfilController = TextEditingController();

  final RxBool isLoading = false.obs;
  final RxBool isPasswordVisible = false.obs;

  final formKey = GlobalKey<FormState>();
  final registerFormKey = GlobalKey<FormState>();

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    nameController.dispose();
    phoneController.dispose();
    countryController.dispose();
    birthDateController.dispose();
    addressController.dispose();
    genderController.dispose();
    preferredLanguageController.dispose();
    fotoPerfilController.dispose();
    super.onClose();
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  Future<void> signInWithEmail() async {
    if (!formKey.currentState!.validate()) return;

    try {
      isLoading.value = true;
      
      // Verificar credenciales específicas
      if (emailController.text.trim() == 'admin@example.com' && 
          passwordController.text == 'password') {
        // Crear un usuario mock con las credenciales específicas
        final user = UserModel(
          id: '1',
          name: 'Admin',
          email: 'admin@example.com',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );
        
        // Guardar el usuario en el almacenamiento
        await _authRepository.saveUser(user);
        
        // Navegar al home
        Get.offAllNamed(AppRoutes.HOME);
        return;
      }
      
      // Si no son las credenciales específicas, intentar login normal
      final user = await _authRepository.signInWithEmail(
        emailController.text.trim(),
        passwordController.text,
      );
      
      // Verificar el email si tenemos el ID y hash del usuario
      if (user.id != null && user.verificationHash != null) {
        await verifyEmail(user.id!, user.verificationHash!);
      }
      
      Get.offAllNamed(AppRoutes.HOME);
    } catch (e) {
      Get.snackbar('Error', 'Error al iniciar sesión: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      isLoading.value = true;
      await _authRepository.signInWithGoogle();
      Get.offAllNamed(AppRoutes.HOME);
    } catch (e) {
      Get.snackbar('Error', 'Error al iniciar sesión con Google: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signUpWithEmail() async {
    if (!registerFormKey.currentState!.validate()) return;

    try {
      isLoading.value = true;
      await _authRepository.signUp(
        nameController.text.trim(),
        emailController.text.trim(),
        passwordController.text,
        phone: phoneController.text.trim(),
        country: countryController.text.trim(),
        birthDate: birthDateController.text.trim(),
        address: addressController.text.trim(),
        gender: genderController.text.trim(),
        preferredLanguage: preferredLanguageController.text.trim(),
        fotoPerfil: fotoPerfilController.text.trim(),
      );
      Get.snackbar('¡Registro exitoso!', 'Bienvenido/a a la app.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 2),
      );
      await Future.delayed(const Duration(seconds: 2));
      Get.offAllNamed(AppRoutes.HOME);
    } catch (e) {
      Get.snackbar('Error', 'Error al registrarse: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  void goToRegister() {
    Get.toNamed(AppRoutes.REGISTER);
  }

  void goToLogin() {
    Get.back();
  }

  void goToHome() {
    Get.offAllNamed(AppRoutes.HOME);
  }

  Future<void> verifyEmail(String id, String hash) async {
    try {
      isLoading.value = true;
      final response = await _authRepository.verifyEmail(id, hash);
      print('Respuesta de verificación de email: $response');
      Get.snackbar('Éxito', 'Email verificado correctamente');
    } catch (e) {
      print('Error al verificar email: $e');
      Get.snackbar('Error', 'Error al verificar el email: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }
}