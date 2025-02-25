import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:konfio_app_dog/features/home/presentation/blocs/bloc/bloc.dart'
    as bloc;

export 'package:konfio_app_dog/features/home/presentation/blocs/bloc/bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _Body(),
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
                  return ListTile(
                    title: Text(dog.dogModelName ?? ''),
                    subtitle: Text(dog.description ?? ''),
                  );
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
