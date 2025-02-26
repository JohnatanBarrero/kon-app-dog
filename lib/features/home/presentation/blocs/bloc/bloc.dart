import 'package:bloc/bloc.dart' as bloc;
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:konfio_app_dog/features/home/domain/usecases/dog_usecase.dart';
import 'package:konfio_app_dog/general_model/dog_model.dart';

part 'event.dart';
part 'state.dart';

class Bloc extends bloc.Bloc<Event, State> {
  DogUseCase? dogUseCase;

  Bloc({required this.dogUseCase}) : super(initialState) {
    on<LoadInitialEvent>(_loadInitialEvent);
  }

  static State get initialState => const InitialState(
        Model(),
      );

  void _loadInitialEvent(LoadInitialEvent event, Emitter<State> emit) async {
    emit(
      LoadingState(state.model),
    );
    try {
      final dogModel = await dogUseCase!.call();
      emit(
        LoadedState(
          state.model.copyWith(
            ltsDogModel: dogModel,
          ),
        ),
      );
    } catch (e) {
      emit(
        ErrorState(state.model),
      );
    }
  }
}
