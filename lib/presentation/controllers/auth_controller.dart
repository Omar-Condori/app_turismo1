import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
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
  final Rx<File?> selectedImage = Rx<File?>(null);

  final formKey = GlobalKey<FormState>();
  final registerFormKey = GlobalKey<FormState>();

  // Mapeo de géneros
  final Map<String, String> genderMap = {
    'Masculino': 'male',
    'Femenino': 'female',
    'Otro': 'other'
  };

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

  void setSelectedImage(File image) {
    selectedImage.value = image;
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  // Validar campos requeridos
  bool validateRequiredFields() {
    if (nameController.text.isEmpty) {
      showError('El nombre es requerido');
      return false;
    }
    if (emailController.text.isEmpty) {
      showError('El email es requerido');
      return false;
    }
    if (passwordController.text.isEmpty) {
      showError('La contraseña es requerida');
      return false;
    }
    if (phoneController.text.isEmpty) {
      showError('El teléfono es requerido');
      return false;
    }
    if (countryController.text.isEmpty) {
      showError('El país es requerido');
      return false;
    }
    if (birthDateController.text.isEmpty) {
      showError('La fecha de nacimiento es requerida');
      return false;
    }
    if (genderController.text.isEmpty) {
      showError('El género es requerido');
      return false;
    }
    return true;
  }

  void showError(String message) {
    Get.snackbar(
      'Error',
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      duration: const Duration(seconds: 4),
      icon: const Icon(Icons.error, color: Colors.white),
    );
  }

  Future<void> signInWithEmail() async {
    if (!formKey.currentState!.validate()) return;

    try {
      isLoading.value = true;
      final user = await _authRepository.signInWithEmail(
        emailController.text.trim(),
        passwordController.text,
      );
      
      if (user.id != null && user.verificationHash != null) {
        await verifyEmail(user.id!, user.verificationHash!);
      }
      
      Get.offAllNamed(AppRoutes.HOME);
    } catch (e) {
      showError('Error al iniciar sesión: ${e.toString()}');
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
      showError('Error al iniciar sesión con Google: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signUpWithEmail() async {
    if (!registerFormKey.currentState!.validate()) return;
    if (!validateRequiredFields()) return;

    // Validar que se haya seleccionado una imagen
    if (selectedImage.value == null) {
      showError('Por favor selecciona una foto de perfil');
      return;
    }

    try {
      isLoading.value = true;
      
      // Verificar que el archivo de imagen existe
      final file = File(selectedImage.value!.path);
      if (!await file.exists()) {
        showError('La imagen seleccionada no existe o no es accesible');
        return;
      }

      // Convertir género al formato esperado por el backend
      String backendGender = genderMap[genderController.text] ?? 'other';

      await _authRepository.signUp(
        nameController.text.trim(),
        emailController.text.trim(),
        passwordController.text,
        phone: phoneController.text.trim(),
        country: countryController.text.trim(),
        birthDate: birthDateController.text.trim(),
        address: addressController.text.trim(),
        gender: backendGender,
        preferredLanguage: preferredLanguageController.text.trim(),
        fotoPerfil: selectedImage.value!.path,
      );
      
      Get.snackbar(
        '¡Registro exitoso!', 
        'Tu cuenta ha sido creada correctamente. Por favor inicia sesión.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 4),
        icon: const Icon(Icons.check_circle, color: Colors.white),
      );
      
      clearRegisterForm();
      await Future.delayed(const Duration(seconds: 2));
      Get.offAllNamed(AppRoutes.LOGIN);
    } catch (e) {
      print('Error detallado en el registro: $e');
      showError('Error al registrarse: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  void clearRegisterForm() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    phoneController.clear();
    countryController.clear();
    birthDateController.clear();
    addressController.clear();
    genderController.clear();
    preferredLanguageController.clear();
    fotoPerfilController.clear();
    selectedImage.value = null;
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
      showError('Error al verificar el email: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }
}