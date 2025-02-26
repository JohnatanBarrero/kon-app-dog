import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:konfio_app_dog/config/colors.dart';
import 'package:konfio_app_dog/features/home/presentation/blocs/bloc/bloc.dart'
    as bloc;
import 'package:konfio_app_dog/features/home/presentation/widgets/card_dog_widget.dart';
import 'package:konfio_app_dog/generated/l10n.dart';

export 'package:konfio_app_dog/features/home/presentation/blocs/bloc/bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          S.current.dogWeLove,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.background,
      ),
      body: const _Body(),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: Modular.get<bloc.Bloc>()..add(bloc.LoadInitialEvent()),
      child: BlocListener<bloc.Bloc, bloc.State>(
        listener: (context, state) {},
        child: BlocBuilder<bloc.Bloc, bloc.State>(
          builder: (context, state) {
            if (state is bloc.InitialState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is bloc.GenericSettingState) {
              return ListView.builder(
                itemCount: state.model.ltsDogModel.length,
                itemBuilder: (context, index) {
                  final dog = state.model.ltsDogModel[index];
                  return CardDogWidget(dog: dog);
                },
              );
            }
            return const Center(
              child: Text('Error'),
            );
          },
        ),
      ),
    );
  }
}
