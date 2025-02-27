import 'package:bloc/bloc.dart' as bloc;
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:konfio_app_dog/config/main/models/main_model_app.dart';
import 'package:konfio_app_dog/config/prefs/preferences.dart';

part 'event.dart';
part 'state.dart';

class BlocMain extends bloc.Bloc<Event, State> {
  BlocMain() : super(initialState) {
    on<LoadInitialEvent>(_loadInitialEvent);
    on<ChangedThemeAppEvent>(_changedThemeAppEvent);
  }
  static State get initialState => const InitialState(
        MainAppModel(),
      );
  void _loadInitialEvent(LoadInitialEvent event, Emitter<State> emit) {
    emit(
      InitialState(
        state.model.copyWith(
          isDarkThemeApp: Preferences().isdark,
        ),
      ),
    );
  }

  void _changedThemeAppEvent(
      ChangedThemeAppEvent event, Emitter<State> emit) async {
    emit(
      ChangingThemeAppState(state.model),
    );

    try {
      final themeCurrently = Preferences().isdark;
      if (themeCurrently) {
        Preferences().isdark = false;
      } else {
        Preferences().isdark = true;
      }
      emit(
        ChangedThemeAppState(
          state.model.copyWith(isDarkThemeApp: !themeCurrently),
        ),
      );
    } catch (e) {
      emit(
        ErrorChangingThemeState(state.model),
      );
    }
  }
}
