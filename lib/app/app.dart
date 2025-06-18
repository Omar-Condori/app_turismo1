import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'routes/app_pages.dart';
import 'routes/app_routes.dart';
import '../core/themes/app_theme.dart';

class CapachicaTourismApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Turismo Capachica',
      theme: AppTheme.lightTheme,
      initialRoute: AppRoutes.LOGIN,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('es', ''), // Español
        Locale('en', ''), // Inglés
        Locale('fr', ''), // Francés
        Locale('pt', ''), // Portugués
        Locale('de', ''), // Alemán
        Locale('it', ''), // Italiano
        Locale('zh', ''), // Chino
        Locale('ja', ''), // Japonés
        Locale('qu', ''), // Quechua
        Locale('ay', ''), // Aymara
      ],
    );
  }
}