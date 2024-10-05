import 'package:flutter/material.dart';
import 'package:cinehub/config/router/app_router.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:cinehub/config/theme/app_theme.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_inappwebview_platform_interface/flutter_inappwebview_platform_interface.dart';

// ignore: non_constant_identifier_names
Future<void> main(dynamic InAppWebViewFlutterPlatform) async {
  // Cargar las variables de entorno
  await dotenv.load(fileName: '.env');

  // Inicializar la configuración de la localización
  await initializeDateFormatting('es_ES');

  // Configurar la implementación concreta de InAppWebViewPlatform
  InAppWebViewPlatform.instance ??= InAppWebViewFlutterPlatform.instance;

  runApp(
    const ProviderScope(child: MainApp())
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      theme: AppTheme().getTheme(),
    );
  }
}