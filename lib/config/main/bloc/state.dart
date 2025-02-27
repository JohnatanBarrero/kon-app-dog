part of 'bloc.dart';

@immutable
abstract class State extends Equatable {
  final MainAppModel model;
  const State(this.model);

  @override
  List<Object> get props => [model];
}

class InitialState extends State {
  const InitialState(super.model);
}

class ChangingThemeAppState extends State {
  const ChangingThemeAppState(super.model);
}
class ChangedThemeAppState extends State {
  const ChangedThemeAppState(super.model);
}

class ErrorChangingThemeState extends State {
  const ErrorChangingThemeState(super.model);
}