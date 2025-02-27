import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:konfio_app_dog/config/api/http_maganer.dart';
import 'package:konfio_app_dog/config/colors.dart';
import 'package:konfio_app_dog/config/flavor.dart';
import 'package:konfio_app_dog/config/main/bloc/bloc.dart' as main_bloc;
import 'package:konfio_app_dog/config/module.dart';
import 'package:konfio_app_dog/config/prefs/preferences.dart';
import 'package:konfio_app_dog/generated/l10n.dart';

void devMain() {
  main();
}

void certMain() {
  main();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = Preferences();
  await prefs.initPrefs();
  setFlavorMX();
  runApp(
    ModularApp(
      module: AppModule(),
      child: const NavigationApp(),
    ),
  );
}

class NavigationApp extends StatelessWidget {
  const NavigationApp({super.key});

  @override
  Widget build(BuildContext context) {
    Modular.get<HttpManager>().init();

    final main_bloc.BlocMain mainBloc = Modular.get();
    mainBloc.add(
      main_bloc.LoadInitialEvent(),
    );

    return BlocProvider.value(
      value: Modular.get<main_bloc.BlocMain>(),
      child: BlocBuilder<main_bloc.BlocMain, main_bloc.State>(
        builder: (context, state) {
          return FlavorBanner(
            child: MaterialApp.router(
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
              theme: state.model.isDarkThemeApp
                  ? ThemeData(
                      useMaterial3: true,
                      fontFamily: GoogleFonts.roboto().fontFamily,
                      primaryColor: AppColors.primary,
                      primaryColorDark: AppColors.secondary,
                      primaryColorLight: AppColors.background,
                      shadowColor: Colors.white,
                    )
                  : ThemeData(
                      useMaterial3: true,
                      fontFamily: GoogleFonts.roboto().fontFamily,
                      primaryColor: Colors.white,
                      primaryColorDark: AppColors.primary,
                      primaryColorLight: AppColors.secondary,
                      shadowColor: AppColors.primary,
                    ),
            ),
          );
        },
      ),
    );
  }
}
