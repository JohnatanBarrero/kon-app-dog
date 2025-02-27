part of 'bloc.dart';

abstract class Event extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadInitialEvent extends Event {
  LoadInitialEvent();
}

class ChangedThemeAppEvent extends Event {
   ChangedThemeAppEvent();
}