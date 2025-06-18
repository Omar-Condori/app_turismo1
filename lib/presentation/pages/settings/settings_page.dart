import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isDarkMode ? const Color(0xFF1A1A1A) : const Color(0xFFF8F9FA),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header con imagen y flecha de regreso
          Stack(
            children: [
              SizedBox(
                width: double.infinity,
                height: 220,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/historia/capachica_antigua.jpg'),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.3),
                          Colors.transparent,
                          Colors.black.withOpacity(0.5),
                        ],
                      ),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                  ),
                ),
              ),
              // Flecha de regreso
              Positioned(
                top: 40,
                left: 16,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.black87),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
              ),
              // Título "More"
              Positioned(
                bottom: 20,
                left: 20,
                child: Text(
                  'More',
                  style: TextStyle(
                    fontSize: 38,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        blurRadius: 8,
                        color: Colors.black.withOpacity(0.7),
                        offset: const Offset(2, 2),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                _buildSectionTitle('Appearance'),
                // Elemento del modo noche/día
                _buildDarkModeToggle(),

                const SizedBox(height: 20),
                _buildSectionTitle('Navigation'),
                _SettingsItem(
                  icon: Icons.home,
                  label: 'Home',
                  color: const Color(0xFF2E7D32),
                  isDarkMode: isDarkMode,
                ),
                _SettingsItem(
                  icon: Icons.card_travel,
                  label: 'Tours',
                  color: const Color(0xFF1976D2),
                  isDarkMode: isDarkMode,
                ),
                _SettingsItem(
                  icon: Icons.calendar_month,
                  label: 'Hotels',
                  color: const Color(0xFF7B1FA2),
                  isDarkMode: isDarkMode,
                ),
                _SettingsItem(
                  icon: Icons.location_on,
                  label: 'Maps',
                  color: const Color(0xFFD32F2F),
                  isDarkMode: isDarkMode,
                ),
                _SettingsItem(
                  icon: Icons.image,
                  label: 'Images',
                  color: const Color(0xFFFF6F00),
                  isDarkMode: isDarkMode,
                ),

                const SizedBox(height: 20),
                _buildSectionTitle('Settings'),
                _SettingsItem(
                  icon: Icons.language,
                  label: 'Language',
                  color: const Color(0xFF388E3C),
                  isDarkMode: isDarkMode,
                ),
                _SettingsItem(
                  icon: Icons.download,
                  label: 'Offline Guide',
                  color: const Color(0xFF5D4037),
                  isDarkMode: isDarkMode,
                ),
                _SettingsItem(
                  icon: Icons.description,
                  label: 'More Visitor\'s Guides!',
                  color: const Color(0xFF303F9F),
                  isDarkMode: isDarkMode,
                ),
                _SettingsItem(
                  icon: Icons.shopping_cart,
                  label: 'Restore Purchases',
                  color: const Color(0xFFF57C00),
                  isDarkMode: isDarkMode,
                ),

                const SizedBox(height: 20),
                _buildSectionTitle('Support'),
                _SettingsItem(
                  icon: Icons.info_outline,
                  label: 'About',
                  color: const Color(0xFF455A64),
                  isDarkMode: isDarkMode,
                ),
                _SettingsItem(
                  icon: Icons.mail_outline,
                  label: 'Contact us',
                  color: const Color(0xFF00796B),
                  isDarkMode: isDarkMode,
                ),

                const SizedBox(height: 20),
                _buildSectionTitle('Account'),
                _SettingsItem(
                  icon: Icons.login,
                  label: 'Login',
                  color: const Color(0xFF1565C0),
                  isLogin: true,
                  isDarkMode: isDarkMode,
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, top: 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildDarkModeToggle() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xFF2A2A2A) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: isDarkMode
                ? Colors.black.withOpacity(0.3)
                : Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isDarkMode
                    ? Colors.orange.withOpacity(0.1)
                    : Colors.blue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                isDarkMode ? Icons.dark_mode : Icons.light_mode,
                size: 24,
                color: isDarkMode ? Colors.orange : Colors.blue,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                isDarkMode ? 'Dark Mode' : 'Light Mode',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: isDarkMode ? Colors.grey[200] : Colors.grey[800],
                ),
              ),
            ),
            // Switch estilo iPhone
            GestureDetector(
              onTap: () {
                setState(() {
                  isDarkMode = !isDarkMode;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 52,
                height: 32,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: isDarkMode ? Colors.green : Colors.grey[300],
                ),
                child: Stack(
                  children: [
                    AnimatedPositioned(
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeIn,
                      top: 2,
                      left: isDarkMode ? 22 : 2,
                      child: Container(
                        width: 28,
                        height: 28,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SettingsItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final bool isLogin;
  final bool isDarkMode;

  const _SettingsItem({
    required this.icon,
    required this.label,
    this.color = Colors.black87,
    this.isLogin = false,
    this.isDarkMode = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xFF2A2A2A) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: isDarkMode
                ? Colors.black.withOpacity(0.3)
                : Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            if (isLogin) {
              // Navegar a la página de login
              Navigator.pushNamed(context, '/login');
              // O si tienes una ruta específica:
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => LoginPage()),
              // );
            } else {
              // Lógica para otros elementos del menú
              print('Tapped on $label');
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    icon,
                    size: 24,
                    color: color,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    label,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: isDarkMode ? Colors.grey[200] : Colors.grey[800],
                    ),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: isDarkMode ? Colors.grey[500] : Colors.grey[400],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}