part of 'bloc.dart';

@immutable
abstract class State extends Equatable {
  final Model model;
  const State(this.model);

  @override
  List<Object> get props => [model];
}

class InitialState extends State {
  const InitialState(super.model);
}

class LoadingState extends State {
  const LoadingState(super.model);
}

class LoadedState extends State {
  const LoadedState(super.model);
}

class ErrorState extends State {
  const ErrorState(super.model);
}

class Model extends Equatable {
  final List<DogModel> ltsDogModel;

  const Model({
    this.ltsDogModel = const [],
  });

  Model copyWith({
    List<DogModel>? ltsDogModel,
  }) =>
      Model(
        ltsDogModel: ltsDogModel ?? this.ltsDogModel,
      );

  @override
  List<Object?> get props => [];
}
