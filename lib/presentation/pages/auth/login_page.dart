import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';
import '../../controllers/auth_controller.dart';
import '../../widgets/common/custom_text_field.dart';
import '../../widgets/common/custom_button.dart';
import '../../widgets/auth/social_login_button.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final PageController _pageController = PageController();
  final RxInt _currentPage = 0.obs;
  Timer? _timer;

  // Obtener el controller
  AuthController get controller => Get.find<AuthController>();

  // Lista de imágenes para el slider
  final List<String> sliderImages = [
    AppAssets.capachicaView1,
    AppAssets.capachicaView2,
    AppAssets.logoCapachica,
  ];

  void _startAutoSlider() {
    _timer = Timer.periodic(Duration(seconds: 4), (timer) {
      if (_currentPage.value < sliderImages.length - 1) {
        _currentPage.value++;
      } else {
        _currentPage.value = 0;
      }

      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage.value,
          duration: Duration(milliseconds: 800),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Iniciar el slider automático
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_timer == null) {
        _startAutoSlider();
      }
    });

    return Scaffold(
      // CAMBIO CRÍTICO: Permitir que se ajuste al teclado
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          // Fondo de pantalla completo con slider
          Positioned.fill(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                _currentPage.value = index;
              },
              itemCount: sliderImages.length,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(sliderImages[index]),
                      fit: BoxFit.cover,
                      filterQuality: FilterQuality.high,
                    ),
                  ),
                );
              },
            ),
          ),

          // Overlay con gradientes sofisticados
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  const Color(0xFF1A1A2E).withOpacity(0.6),
                  Colors.transparent,
                  Colors.transparent,
                  const Color(0xFF0F0F23).withOpacity(0.8),
                ],
                stops: const [0.0, 0.3, 0.7, 1.0],
              ),
            ),
          ),

          // Gradiente radial para profundidad
          Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: const Alignment(0, 0),
                radius: 1.2,
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.2),
                ],
                stops: const [0.4, 1.0],
              ),
            ),
          ),

          // Contenido principal optimizado para teclado
          SafeArea(
            child: Column(
              children: [
                // Header fijo con botón de cerrar e indicadores
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Botón de cerrar con glassmorphism
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.white.withOpacity(0.2),
                              Colors.white.withOpacity(0.1),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.2),
                            width: 1,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: controller.goToHome,
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Icon(
                                  Icons.close_rounded,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      // Indicadores de página
                      Obx(() => Row(
                        children: List.generate(
                          sliderImages.length,
                              (index) => AnimatedContainer(
                            duration: Duration(milliseconds: 300),
                            margin: const EdgeInsets.symmetric(horizontal: 3),
                            width: _currentPage.value == index ? 20 : 8,
                            height: 8,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: _currentPage.value == index
                                  ? Colors.white
                                  : Colors.white.withOpacity(0.4),
                            ),
                          ),
                        ),
                      )),

                      // Espaciado
                      SizedBox(width: 44),
                    ],
                  ),
                ),

                // Contenido scrolleable que se adapta al teclado
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        // Espacio dinámico que se ajusta al teclado
                        SizedBox(
                          height: MediaQuery.of(context).viewInsets.bottom > 0
                              ? 20 // Cuando el teclado está visible
                              : MediaQuery.of(context).size.height * 0.15, // Cuando no está visible
                        ),

                        // Formulario de login
                        Container(
                          constraints: BoxConstraints(
                            maxWidth: 400,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(25),
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.white.withOpacity(0.25),
                                    Colors.white.withOpacity(0.1),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(25),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.2),
                                  width: 1,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 30,
                                    offset: const Offset(0, 15),
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(28),
                                child: Form(
                                  key: controller.formKey,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      // Título con efecto shader
                                      ShaderMask(
                                        shaderCallback: (Rect bounds) {
                                          return const LinearGradient(
                                            colors: [Colors.white, Color(0xFFE2E8F0)],
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                          ).createShader(bounds);
                                        },
                                        child: Text(
                                          'Bienvenido',
                                          style: TextStyle(
                                            fontSize: 32,
                                            fontWeight: FontWeight.w900,
                                            color: Colors.white,
                                            letterSpacing: -0.5,
                                          ),
                                        ),
                                      ),

                                      const SizedBox(height: 8),

                                      Text(
                                        'Inicia sesión para continuar',
                                        style: TextStyle(
                                          color: Colors.white.withOpacity(0.9),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),

                                      const SizedBox(height: 32),

                                      // Campo de email con glassmorphism
                                      _buildGlassTextField(
                                        controller: controller.emailController,
                                        hintText: 'Correo electrónico',
                                        icon: Icons.email_outlined,
                                        keyboardType: TextInputType.emailAddress,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Campo requerido';
                                          }
                                          if (!GetUtils.isEmail(value)) {
                                            return 'Correo inválido';
                                          }
                                          return null;
                                        },
                                      ),

                                      const SizedBox(height: 16),

                                      // Campo de contraseña con glassmorphism y ojo
                                      Obx(() => _buildGlassTextField(
                                        controller: controller.passwordController,
                                        hintText: 'Contraseña',
                                        icon: Icons.lock_outline,
                                        obscureText: !controller.isPasswordVisible.value,
                                        suffixIcon: IconButton(
                                          onPressed: controller.togglePasswordVisibility,
                                          icon: Icon(
                                            controller.isPasswordVisible.value
                                                ? Icons.visibility_outlined
                                                : Icons.visibility_off_outlined,
                                            color: Colors.black87,
                                            size: 20,
                                          ),
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Campo requerido';
                                          }
                                          if (value.length < 6) {
                                            return 'Mínimo 6 caracteres';
                                          }
                                          return null;
                                        },
                                      )),

                                      const SizedBox(height: 24),

                                      // Botón de iniciar sesión
                                      Obx(() => _buildGlassButton(
                                        onPressed: controller.isLoading.value
                                            ? null
                                            : controller.signInWithEmail,
                                        text: controller.isLoading.value
                                            ? 'Cargando...'
                                            : 'Iniciar Sesión',
                                        isPrimary: true,
                                      )),

                                      const SizedBox(height: 16),

                                      // Botón de Google
                                      _buildGlassButton(
                                        onPressed: controller.signInWithGoogle,
                                        text: 'Continuar con Google',
                                        icon: Icons.g_mobiledata_rounded,
                                        isPrimary: false,
                                      ),

                                      const SizedBox(height: 20),

                                      // Enlace de registro
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            '¿No tienes cuenta? ',
                                            style: TextStyle(
                                              color: Colors.white.withOpacity(0.8),
                                              fontSize: 14,
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: controller.goToRegister,
                                            child: Text(
                                              'Regístrate',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                        // Espacio bottom para asegurar scroll completo
                        SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGlassTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    TextInputType? keyboardType,
    bool obscureText = false,
    Widget? suffixIcon,
    String? Function(String?)? validator,
  }) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white.withOpacity(0.2),
            Colors.white.withOpacity(0.1),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Colors.white.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        validator: validator,
        cursorColor: Color(0xFF2C3E50),
        style: TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.white.withOpacity(0.7),
            fontSize: 16,
          ),
          prefixIcon: Icon(
            icon,
            color: Colors.white.withOpacity(0.8),
            size: 20,
          ),
          suffixIcon: suffixIcon,
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: Color(0xFF2C3E50),
              width: 1.5,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: Color(0xFF2C3E50),
              width: 2,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: Color(0xFF2C3E50),
              width: 2,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: Colors.transparent,
              width: 1,
            ),
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 18,
          ),
          isDense: true,
        ),
      ),
    );
  }

  Widget _buildGlassButton({
    required VoidCallback? onPressed,
    required String text,
    IconData? icon,
    bool isPrimary = true,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: isPrimary
            ? const LinearGradient(
          colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        )
            : LinearGradient(
          colors: [
            Colors.white.withOpacity(0.15),
            Colors.white.withOpacity(0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: isPrimary
            ? null
            : Border.all(
          color: Colors.white.withOpacity(0.3),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: isPrimary
                ? const Color(0xFF667EEA).withOpacity(0.3)
                : Colors.white.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(15),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(15),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon != null) ...[
                  Icon(
                    icon,
                    color: Colors.white,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                ],
                Text(
                  text,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }
}