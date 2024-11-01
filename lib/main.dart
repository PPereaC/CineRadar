import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_inappwebview_platform_interface/flutter_inappwebview_platform_interface.dart';

import 'config/router/app_router.dart';
import 'config/theme/app_theme.dart';
import 'presentation/providers/providers.dart';

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

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final appTheme = ref.watch(themeNotifierProvider);

    return MaterialApp.router(
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      theme: AppTheme(selectedColor: appTheme.selectedColor, isDarkmode: appTheme.isDarkmode).getTheme(),
    );
  }
}