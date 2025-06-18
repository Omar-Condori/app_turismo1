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

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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

  // Listas estáticas para selectores
  final List<String> paises = [
    'Perú', 'Argentina', 'Bolivia', 'Brasil', 'Chile', 'Colombia', 'Ecuador', 'España', 'México', 'Estados Unidos', 'Francia', 'Italia', 'Alemania', 'Japón', 'China', 'India', 'Canadá', 'Australia', 'Reino Unido',
  ];
  final List<String> generos = ['Masculino', 'Femenino', 'Otro'];
  final List<String> idiomas = ['Español', 'Inglés', 'Francés', 'Portugués', 'Alemán', 'Italiano', 'Chino', 'Japonés', 'Quechua', 'Aymara'];

  String? paisSeleccionado;
  String? generoSeleccionado;
  String? idiomaSeleccionado;

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
      // Permitir que se ajuste al teclado
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

                      // Espacio vacío donde estaba el botón de login
                      SizedBox(width: 48),
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
                              : MediaQuery.of(context).size.height * 0.08, // Cuando no está visible
                        ),

                        // Formulario de registro
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
                                  key: controller.registerFormKey,
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
                                          'Crear Cuenta',
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
                                        'Únete a nuestra comunidad',
                                        style: TextStyle(
                                          color: Colors.white.withOpacity(0.9),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),

                                      const SizedBox(height: 28),

                                      // Campo de nombre completo
                                      _buildGlassTextField(
                                        controller: controller.nameController,
                                        hintText: 'Nombre completo',
                                        icon: Icons.person_outline,
                                        keyboardType: TextInputType.name,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Campo requerido';
                                          }
                                          return null;
                                        },
                                      ),

                                      const SizedBox(height: 16),

                                      // Campo de email
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

                                      // Campo de contraseña
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

                                      const SizedBox(height: 16),

                                      // Campo de confirmar contraseña
                                      Obx(() => _buildGlassTextField(
                                        controller: controller.confirmPasswordController,
                                        hintText: 'Confirmar contraseña',
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
                                          if (value != controller.passwordController.text) {
                                            return 'Las contraseñas no coinciden';
                                          }
                                          return null;
                                        },
                                      )),

                                      const SizedBox(height: 16),

                                      // Campo de teléfono
                                      _buildGlassTextField(
                                        controller: controller.phoneController,
                                        hintText: 'Teléfono',
                                        icon: Icons.phone_outlined,
                                        keyboardType: TextInputType.phone,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Campo requerido';
                                          }
                                          return null;
                                        },
                                      ),

                                      const SizedBox(height: 16),

                                      // Campo de país (dropdown)
                                      DropdownButtonFormField<String>(
                                        value: paisSeleccionado,
                                        items: paises.map((pais) => DropdownMenuItem(value: pais, child: Text(pais))).toList(),
                                        onChanged: (value) {
                                          setState(() {
                                            paisSeleccionado = value;
                                            controller.countryController.text = value ?? '';
                                          });
                                        },
                                      ),

                                      const SizedBox(height: 16),

                                      // Campo de fecha de nacimiento (date picker)
                                      TextFormField(
                                        controller: controller.birthDateController,
                                        readOnly: true,
                                        onTap: () async {
                                          DateTime? picked = await showDatePicker(
                                            context: context,
                                            initialDate: DateTime(2000),
                                            firstDate: DateTime(1900),
                                            lastDate: DateTime.now(),
                                            locale: const Locale('es', ''),
                                          );
                                          if (picked != null) {
                                            controller.birthDateController.text = "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
                                          }
                                        },
                                        decoration: InputDecoration(
                                          hintText: 'Selecciona tu fecha de nacimiento',
                                          hintStyle: TextStyle(color: Colors.grey[350]),
                                          prefixIcon: Icon(Icons.calendar_today_outlined, color: Colors.white.withOpacity(0.8)),
                                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
                                          filled: true,
                                          fillColor: Colors.white.withOpacity(0.1),
                                        ),
                                        validator: (value) => value == null || value.isEmpty ? 'Campo requerido' : null,
                                      ),

                                      const SizedBox(height: 16),

                                      // Campo de género (dropdown)
                                      DropdownButtonFormField<String>(
                                        value: generoSeleccionado,
                                        items: generos.map((g) => DropdownMenuItem(value: g, child: Text(g))).toList(),
                                        onChanged: (value) {
                                          setState(() {
                                            generoSeleccionado = value;
                                            controller.genderController.text = value ?? '';
                                          });
                                        },
                                        decoration: InputDecoration(
                                          hintText: 'Selecciona tu género',
                                          hintStyle: TextStyle(color: Colors.grey[350]),
                                          prefixIcon: Icon(Icons.person_outline, color: Colors.white.withOpacity(0.8)),
                                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
                                          filled: true,
                                          fillColor: Colors.white.withOpacity(0.1),
                                        ),
                                        validator: (value) => value == null || value.isEmpty ? 'Campo requerido' : null,
                                      ),

                                      const SizedBox(height: 16),

                                      // Campo de idioma preferido (dropdown)
                                      DropdownButtonFormField<String>(
                                        value: idiomaSeleccionado,
                                        items: idiomas.map((idioma) => DropdownMenuItem(value: idioma, child: Text(idioma))).toList(),
                                        onChanged: (value) {
                                          setState(() {
                                            idiomaSeleccionado = value;
                                            controller.preferredLanguageController.text = value ?? '';
                                          });
                                        },
                                        decoration: InputDecoration(
                                          hintText: 'Selecciona tu idioma',
                                          hintStyle: TextStyle(color: Colors.grey[350]),
                                          prefixIcon: Icon(Icons.language_outlined, color: Colors.white.withOpacity(0.8)),
                                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
                                          filled: true,
                                          fillColor: Colors.white.withOpacity(0.1),
                                        ),
                                        validator: (value) => value == null || value.isEmpty ? 'Campo requerido' : null,
                                      ),

                                      const SizedBox(height: 16),

                                      // Campo de dirección
                                      _buildGlassTextField(
                                        controller: controller.addressController,
                                        hintText: 'Dirección',
                                        icon: Icons.location_on_outlined,
                                        keyboardType: TextInputType.streetAddress,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Campo requerido';
                                          }
                                          return null;
                                        },
                                      ),

                                      const SizedBox(height: 16),

                                      // Campo de foto de perfil
                                      _buildGlassTextField(
                                        controller: controller.fotoPerfilController,
                                        hintText: 'Foto de perfil (URL)',
                                        icon: Icons.photo_camera_outlined,
                                        keyboardType: TextInputType.url,
                                        validator: (value) {
                                          // Campo opcional
                                          return null;
                                        },
                                      ),

                                      const SizedBox(height: 24),

                                      // Botón de registrarse
                                      Obx(() => _buildGlassButton(
                                        onPressed: controller.isLoading.value
                                            ? null
                                            : controller.signUpWithEmail,
                                        text: controller.isLoading.value
                                            ? 'Cargando...'
                                            : 'Crear Cuenta',
                                        isPrimary: true,
                                      )),

                                      const SizedBox(height: 16),

                                      // Enlace de login
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            '¿Ya tienes cuenta? ',
                                            style: TextStyle(
                                              color: Colors.white.withOpacity(0.8),
                                              fontSize: 14,
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: controller.goToLogin,
                                            child: Text(
                                              'Iniciar Sesión',
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
            color: Colors.grey[350],
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