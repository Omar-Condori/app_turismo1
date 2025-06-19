import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';
import '../../controllers/auth_controller.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
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
  
  // Obtener el controlador de autenticación
  late AuthController authController;

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
  final List<Map<String, String>> generos = [
    {'label': 'Masculino', 'value': 'male'},
    {'label': 'Femenino', 'value': 'female'},
    {'label': 'Otro', 'value': 'other'},
  ];
  final List<String> idiomas = ['Español', 'Inglés', 'Francés', 'Portugués', 'Alemán', 'Italiano', 'Chino', 'Japonés', 'Quechua', 'Aymara'];

  String? paisSeleccionado;
  String? generoSeleccionado;
  String? idiomaSeleccionado;

  File? _pickedImage;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    // Obtener el controlador de autenticación
    authController = Get.find<AuthController>();
  }

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
    authController.togglePasswordVisibility();
  }

  void signUpWithEmail() async {
    if (authController.registerFormKey.currentState!.validate()) {
      try {
        // Actualizar los controladores del AuthController con los valores del formulario
        authController.nameController.text = authController.nameController.text;
        authController.emailController.text = authController.emailController.text;
        authController.passwordController.text = authController.passwordController.text;
        authController.phoneController.text = authController.phoneController.text;
        authController.countryController.text = authController.countryController.text;
        authController.birthDateController.text = authController.birthDateController.text;
        authController.addressController.text = authController.addressController.text;
        authController.genderController.text = authController.genderController.text;
        authController.preferredLanguageController.text = authController.preferredLanguageController.text;
        authController.fotoPerfilController.text = authController.fotoPerfilController.text;
        
        // Llamar al método de registro del controlador
        await authController.signUpWithEmail();
        
        // El controlador ya maneja la navegación y los mensajes
      } catch (e) {
        print('Error en registro: $e');
      }
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

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
    if (image != null) {
      setState(() {
        _pickedImage = File(image.path);
        authController.setSelectedImage(_pickedImage!);
      });
    }
  }

  Future<void> _takePhoto() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 80,
    );
    if (image != null) {
      setState(() {
        _pickedImage = File(image.path);
        authController.setSelectedImage(_pickedImage!);
      });
    }
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
                                  key: authController.registerFormKey,
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
                                        controller: authController.nameController,
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
                                        controller: authController.emailController,
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
                                        controller: authController.passwordController,
                                        hintText: 'Contraseña',
                                        icon: Icons.lock_outline,
                                        obscureText: !authController.isPasswordVisible.value,
                                        suffixIcon: IconButton(
                                          onPressed: togglePasswordVisibility,
                                          icon: Icon(
                                            authController.isPasswordVisible.value
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
                                        controller: authController.confirmPasswordController,
                                        hintText: 'Confirmar contraseña',
                                        icon: Icons.lock_outline,
                                        obscureText: !authController.isPasswordVisible.value,
                                        suffixIcon: IconButton(
                                          onPressed: togglePasswordVisibility,
                                          icon: Icon(
                                            authController.isPasswordVisible.value
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
                                          if (value != authController.passwordController.text) {
                                            return 'Las contraseñas no coinciden';
                                          }
                                          return null;
                                        },
                                      )),

                                      const SizedBox(height: 16),

                                      // Campo de teléfono
                                      _buildModernTextField(
                                        controller: authController.phoneController,
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
                                            authController.countryController.text = value ?? '';
                                          });
                                        },
                                        hintText: 'Selecciona tu país',
                                        icon: Icons.public_outlined,
                                        validator: (value) => value == null || value.isEmpty ? 'Campo requerido' : null,
                                      ),

                                      const SizedBox(height: 16),

                                      // Campo de fecha de nacimiento
                                      _buildModernTextField(
                                        controller: authController.birthDateController,
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
                                            authController.birthDateController.text = "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
                                          }
                                        },
                                        validator: (value) => value == null || value.isEmpty ? 'Campo requerido' : null,
                                      ),

                                      const SizedBox(height: 16),

                                      // Campo de género (dropdown)
                                      _buildModernDropdown<String>(
                                        value: generoSeleccionado,
                                        items: generos.map((g) => DropdownMenuItem(
                                          value: g['value'],
                                          child: Text(g['label']!, style: TextStyle(color: Colors.grey[700])),
                                        )).toList(),
                                        onChanged: (value) {
                                          setState(() {
                                            generoSeleccionado = value;
                                            authController.genderController.text = value ?? '';
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
                                            authController.preferredLanguageController.text = value ?? '';
                                          });
                                        },
                                        hintText: 'Selecciona tu idioma',
                                        icon: Icons.language_outlined,
                                        validator: (value) => value == null || value.isEmpty ? 'Campo requerido' : null,
                                      ),

                                      const SizedBox(height: 16),

                                      // Campo de dirección
                                      _buildModernTextField(
                                        controller: authController.addressController,
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
                                      Row(
                                        children: [
                                          _pickedImage != null
                                              ? CircleAvatar(
                                                  backgroundImage: FileImage(_pickedImage!),
                                                  radius: 28,
                                                )
                                              : CircleAvatar(
                                                  child: Icon(Icons.person, size: 32),
                                                  radius: 28,
                                                ),
                                          SizedBox(width: 12),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    ElevatedButton.icon(
                                                      onPressed: _pickImage,
                                                      icon: Icon(Icons.photo_library),
                                                      label: Text('Galería'),
                                                      style: ElevatedButton.styleFrom(
                                                        backgroundColor: Colors.white,
                                                        foregroundColor: Colors.black,
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(18),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(width: 8),
                                                    ElevatedButton.icon(
                                                      onPressed: _takePhoto,
                                                      icon: Icon(Icons.camera_alt),
                                                      label: Text('Cámara'),
                                                      style: ElevatedButton.styleFrom(
                                                        backgroundColor: Colors.white,
                                                        foregroundColor: Colors.black,
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(18),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 4),
                                                Text(
                                                  _pickedImage != null ? 'Foto seleccionada' : 'Selecciona o toma una foto',
                                                  style: TextStyle(fontSize: 12, color: Colors.white),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 16),

                                      // Botón de crear cuenta
                                      Obx(() => _buildModernButton(
                                        onPressed: authController.isLoading.value
                                            ? null
                                            : signUpWithEmail,
                                        text: authController.isLoading.value
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