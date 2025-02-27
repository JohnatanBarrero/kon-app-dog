import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:konfio_app_dog/config/main/bloc/bloc.dart' as main_bloc;

class BtnThemeApp extends StatelessWidget {
  const BtnThemeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<main_bloc.BlocMain, main_bloc.State>(
      builder: (context, state) {
        return IconButton(
          icon: Icon(
            !state.model.isDarkThemeApp ? Icons.dark_mode : Icons.light_mode,
            color: Theme.of(context).primaryColor,
          ),
          onPressed: () {
            ReadContext(context).read<main_bloc.BlocMain>().add(
                  main_bloc.ChangedThemeAppEvent(),
                );
          },
          tooltip: state.model.isDarkThemeApp
              ? 'Activar modo claro'
              : 'Activar modo oscuro',
        );
      },
    );
  }
}
