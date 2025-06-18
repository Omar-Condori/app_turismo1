import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
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
                _buildSectionTitle('Navigation'),
                _SettingsItem(
                  icon: Icons.home,
                  label: 'Home',
                  color: const Color(0xFF2E7D32),
                ),
                _SettingsItem(
                  icon: Icons.card_travel,
                  label: 'Tours',
                  color: const Color(0xFF1976D2),
                ),
                _SettingsItem(
                  icon: Icons.calendar_month,
                  label: 'Hotels',
                  color: const Color(0xFF7B1FA2),
                ),
                _SettingsItem(
                  icon: Icons.location_on,
                  label: 'Maps',
                  color: const Color(0xFFD32F2F),
                ),
                _SettingsItem(
                  icon: Icons.image,
                  label: 'Images',
                  color: const Color(0xFFFF6F00),
                ),

                const SizedBox(height: 20),
                _buildSectionTitle('Settings'),
                _SettingsItem(
                  icon: Icons.language,
                  label: 'Language',
                  color: const Color(0xFF388E3C),
                ),
                _SettingsItem(
                  icon: Icons.download,
                  label: 'Offline Guide',
                  color: const Color(0xFF5D4037),
                ),
                _SettingsItem(
                  icon: Icons.description,
                  label: 'More Visitor\'s Guides!',
                  color: const Color(0xFF303F9F),
                ),
                _SettingsItem(
                  icon: Icons.shopping_cart,
                  label: 'Restore Purchases',
                  color: const Color(0xFFF57C00),
                ),

                const SizedBox(height: 20),
                _buildSectionTitle('Support'),
                _SettingsItem(
                  icon: Icons.info_outline,
                  label: 'About',
                  color: const Color(0xFF455A64),
                ),
                _SettingsItem(
                  icon: Icons.mail_outline,
                  label: 'Contact us',
                  color: const Color(0xFF00796B),
                ),

                const SizedBox(height: 20),
                _buildSectionTitle('Account'),
                _SettingsItem(
                  icon: Icons.login,
                  label: 'Login',
                  color: const Color(0xFF1565C0),
                  isLogin: true,
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
          color: Colors.grey[600],
          letterSpacing: 0.5,
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

  const _SettingsItem({
    required this.icon,
    required this.label,
    this.color = Colors.black87,
    this.isLogin = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
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
                      color: Colors.grey[800],
                    ),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Colors.grey[400],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}