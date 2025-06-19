import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';
// import '../../controllers/auth_controller.dart';
// import '../../widgets/common/custom_text_field.dart';
// import '../../widgets/common/custom_button.dart';
// import '../../widgets/auth/social_login_button.dart';
// import '../../../core/constants/app_strings.dart';
// import '../../../core/constants/app_assets.dart';
// import '../../../core/constants/app_colors.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final PageController _pageController = PageController();
  final RxInt _currentPage = 0.obs;
  Timer? _timer;

  // Controllers de ejemplo (reemplaza con tu AuthController)
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final phoneController = TextEditingController();
  final countryController = TextEditingController();
  final birthDateController = TextEditingController();
  final genderController = TextEditingController();
  final preferredLanguageController = TextEditingController();
  final addressController = TextEditingController();
  final fotoPerfilController = TextEditingController();
  final registerFormKey = GlobalKey<FormState>();
  final RxBool isPasswordVisible = false.obs;
  final RxBool isLoading = false.obs;

  // Lista de imágenes para el slider (usando placeholders)
  final List<String> sliderImages = [
    'https://picsum.photos/800/1200?random=1',
    'https://picsum.photos/800/1200?random=2',
    'https://picsum.photos/800/1200?random=3',
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

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void signUpWithEmail() {
    if (registerFormKey.currentState!.validate()) {
      isLoading.value = true;
      // Simular carga
      Future.delayed(Duration(seconds: 2), () {
        isLoading.value = false;
        // Lógica de registro aquí
      });
    }
  }

  void goToHome() {
    // Navegación al home
    Get.offAllNamed('/home');
  }

  void goToLogin() {
    // Navegación al login
    Get.offAllNamed('/login');
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
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
                      image: NetworkImage(sliderImages[index]),
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
                              onTap: goToHome,
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
                                  key: registerFormKey,
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

                                      const SizedBox(height: 32),

                                      // Campo de nombre completo con bordes redondeados
                                      _buildModernTextField(
                                        controller: nameController,
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

                                      // Campo de email con bordes redondeados
                                      _buildModernTextField(
                                        controller: emailController,
                                        hintText: 'usuario@ejemplo.com',
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

                                      // Campo de contraseña con bordes redondeados
                                      Obx(() => _buildModernTextField(
                                        controller: passwordController,
                                        hintText: 'Contraseña',
                                        icon: Icons.lock_outline,
                                        obscureText: !isPasswordVisible.value,
                                        suffixIcon: IconButton(
                                          onPressed: togglePasswordVisibility,
                                          icon: Icon(
                                            isPasswordVisible.value
                                                ? Icons.visibility_outlined
                                                : Icons.visibility_off_outlined,
                                            color: Colors.grey[600],
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
                                      Obx(() => _buildModernTextField(
                                        controller: confirmPasswordController,
                                        hintText: 'Confirmar contraseña',
                                        icon: Icons.lock_outline,
                                        obscureText: !isPasswordVisible.value,
                                        suffixIcon: IconButton(
                                          onPressed: togglePasswordVisibility,
                                          icon: Icon(
                                            isPasswordVisible.value
                                                ? Icons.visibility_outlined
                                                : Icons.visibility_off_outlined,
                                            color: Colors.grey[600],
                                            size: 20,
                                          ),
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Campo requerido';
                                          }
                                          if (value != passwordController.text) {
                                            return 'Las contraseñas no coinciden';
                                          }
                                          return null;
                                        },
                                      )),

                                      const SizedBox(height: 16),

                                      // Campo de teléfono
                                      _buildModernTextField(
                                        controller: phoneController,
                                        hintText: '+51 999 999 999',
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

                                      // Campo de país (dropdown con bordes redondeados)
                                      _buildModernDropdown<String>(
                                        value: paisSeleccionado,
                                        items: paises.map((pais) => DropdownMenuItem(
                                          value: pais,
                                          child: Text(pais, style: TextStyle(color: Colors.grey[700])),
                                        )).toList(),
                                        onChanged: (value) {
                                          setState(() {
                                            paisSeleccionado = value;
                                            countryController.text = value ?? '';
                                          });
                                        },
                                        hintText: 'Selecciona tu país',
                                        icon: Icons.public_outlined,
                                        validator: (value) => value == null || value.isEmpty ? 'Campo requerido' : null,
                                      ),

                                      const SizedBox(height: 16),

                                      // Campo de fecha de nacimiento
                                      _buildModernTextField(
                                        controller: birthDateController,
                                        hintText: 'Fecha de nacimiento',
                                        icon: Icons.calendar_today_outlined,
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
                                            birthDateController.text = "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
                                          }
                                        },
                                        validator: (value) => value == null || value.isEmpty ? 'Campo requerido' : null,
                                      ),

                                      const SizedBox(height: 16),

                                      // Campo de género (dropdown)
                                      _buildModernDropdown<String>(
                                        value: generoSeleccionado,
                                        items: generos.map((g) => DropdownMenuItem(
                                          value: g,
                                          child: Text(g, style: TextStyle(color: Colors.grey[700])),
                                        )).toList(),
                                        onChanged: (value) {
                                          setState(() {
                                            generoSeleccionado = value;
                                            genderController.text = value ?? '';
                                          });
                                        },
                                        hintText: 'Selecciona tu género',
                                        icon: Icons.person_outline,
                                        validator: (value) => value == null || value.isEmpty ? 'Campo requerido' : null,
                                      ),

                                      const SizedBox(height: 16),

                                      // Campo de idioma preferido (dropdown)
                                      _buildModernDropdown<String>(
                                        value: idiomaSeleccionado,
                                        items: idiomas.map((idioma) => DropdownMenuItem(
                                          value: idioma,
                                          child: Text(idioma, style: TextStyle(color: Colors.grey[700])),
                                        )).toList(),
                                        onChanged: (value) {
                                          setState(() {
                                            idiomaSeleccionado = value;
                                            preferredLanguageController.text = value ?? '';
                                          });
                                        },
                                        hintText: 'Selecciona tu idioma',
                                        icon: Icons.language_outlined,
                                        validator: (value) => value == null || value.isEmpty ? 'Campo requerido' : null,
                                      ),

                                      const SizedBox(height: 16),

                                      // Campo de dirección
                                      _buildModernTextField(
                                        controller: addressController,
                                        hintText: 'Av. El Sol 123, Cusco',
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
                                      _buildModernTextField(
                                        controller: fotoPerfilController,
                                        hintText: 'https://ejemplo.com/foto.jpg',
                                        icon: Icons.photo_camera_outlined,
                                        keyboardType: TextInputType.url,
                                        validator: (value) {
                                          // Campo opcional
                                          return null;
                                        },
                                      ),

                                      const SizedBox(height: 24),

                                      // Botón de crear cuenta
                                      Obx(() => _buildModernButton(
                                        onPressed: isLoading.value
                                            ? null
                                            : signUpWithEmail,
                                        text: isLoading.value
                                            ? 'Cargando...'
                                            : 'Crear Cuenta',
                                        isPrimary: true,
                                      )),

                                      const SizedBox(height: 20),

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
                                            onTap: goToLogin,
                                            child: ShaderMask(
                                              shaderCallback: (bounds) => LinearGradient(
                                                colors: [Colors.white, Color(0xFFE2E8F0)],
                                              ).createShader(bounds),
                                              child: Text(
                                                'Iniciar Sesión',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                ),
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

  Widget _buildModernTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    TextInputType? keyboardType,
    bool obscureText = false,
    bool readOnly = false,
    Widget? suffixIcon,
    VoidCallback? onTap,
    String? Function(String?)? validator,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        readOnly: readOnly,
        onTap: onTap,
        validator: validator,
        cursorColor: Color(0xFF6366F1),
        cursorWidth: 2,
        style: TextStyle(
          color: Colors.grey[800],
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.grey[500],
            fontSize: 16,
          ),
          prefixIcon: Container(
            margin: EdgeInsets.only(left: 12, right: 8),
            child: Icon(
              icon,
              color: Colors.grey[600],
              size: 20,
            ),
          ),
          suffixIcon: suffixIcon != null ? Container(
            margin: EdgeInsets.only(right: 12),
            child: suffixIcon,
          ) : null,
          errorStyle: TextStyle(
            color: Color(0xFFEF4444),
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(
              color: Color(0xFF6366F1),
              width: 2,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(
              color: Color(0xFFEF4444),
              width: 2,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(
              color: Color(0xFFEF4444),
              width: 2,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          isDense: true,
        ),
      ),
    );
  }

  Widget _buildModernDropdown<T>({
    required T? value,
    required List<DropdownMenuItem<T>> items,
    required void Function(T?) onChanged,
    required String hintText,
    required IconData icon,
    String? Function(T?)? validator,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: DropdownButtonFormField<T>(
        value: value,
        items: items,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey[500], fontSize: 16),
          prefixIcon: Container(
            margin: EdgeInsets.only(left: 12, right: 8),
            child: Icon(icon, color: Colors.grey[600], size: 20),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(
              color: Color(0xFF6366F1),
              width: 2,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(
              color: Color(0xFFEF4444),
              width: 2,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(
              color: Color(0xFFEF4444),
              width: 2,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          isDense: true,
          errorStyle: TextStyle(
            color: Color(0xFFEF4444),
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        validator: validator,
        dropdownColor: Colors.white,
        style: TextStyle(color: Colors.grey[800], fontSize: 16, fontWeight: FontWeight.w500),
        icon: Icon(Icons.keyboard_arrow_down, color: Colors.grey[600]),
      ),
    );
  }

  Widget _buildModernButton({
    required VoidCallback? onPressed,
    required String text,
    bool isPrimary = false,
  }) {
    return Container(
      width: double.infinity,
      height: 54,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isPrimary
              ? [Color(0xFF6366F1), Color(0xFF8B5CF6)]
              : [
            Colors.white.withOpacity(0.2),
            Colors.white.withOpacity(0.1),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: isPrimary
                ? Color(0xFF6366F1).withOpacity(0.3)
                : Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onPressed,
            child: Container(
              alignment: Alignment.center,
              child: Text(
                text,
                style: TextStyle(
                  color: isPrimary ? Colors.white : Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}