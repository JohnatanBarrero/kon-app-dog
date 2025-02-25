import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:konfio_app_dog/config/api/http_maganer.dart';
import 'package:konfio_app_dog/config/colors.dart';
import 'package:konfio_app_dog/config/module.dart';
import 'package:konfio_app_dog/generated/l10n.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: false,
      builder: (context) => ModularApp(
        module: AppModule(),
        child: const NavigationApp(),
      ),
    ),
  );
}

class NavigationApp extends StatelessWidget {
  const NavigationApp({super.key});

  @override
  Widget build(BuildContext context) {
      Modular.get<HttpManager>().init();
 
    return MaterialApp.router(
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
      title: 'KonfioAppDog',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: GoogleFonts.roboto().fontFamily,
        primaryColor: AppColors.greenPrimary,
      ),
    );
  }
}
