import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:konfio_app_dog/features/home/presentation/blocs/bloc/bloc.dart'
    as bloc;
import 'package:konfio_app_dog/features/home/presentation/widgets/btn_mode_widget.dart';
import 'package:konfio_app_dog/features/home/presentation/widgets/card_dog_widget.dart';
import 'package:konfio_app_dog/generated/l10n.dart';
import 'package:skeletonizer/skeletonizer.dart';

export 'package:konfio_app_dog/features/home/presentation/blocs/bloc/bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorLight,
      appBar: AppBar(
        actions: const [BtnThemeApp(), SizedBox(width: 10)],
        title: Text(
          S.current.dogWeLove,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColorLight,
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
      child: BlocBuilder<bloc.Bloc, bloc.State>(
        builder: (context, state) {
          if (state is bloc.LoadedState || state is bloc.InitialState) {
            return Skeletonizer(
              enabled: state is bloc.LoadingState,
              child: ListView.builder(
                itemCount: state.model.ltsDogModel.length,
                itemBuilder: (context, index) {
                  final dog = state.model.ltsDogModel[index];
                  return CardDogWidget(dog: dog);
                },
              ),
            );
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Center(
                child: Text(
                  'Dogs We Love',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              SizedBox(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100.0),
                  child: Image.asset('assets/home/dog3.png'),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
