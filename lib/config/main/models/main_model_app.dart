import 'package:equatable/equatable.dart';

class MainAppModel extends Equatable {
  final bool isDarkThemeApp;

  const MainAppModel({
    this.isDarkThemeApp = true,
  });

  MainAppModel copyWith({
    bool? isDarkThemeApp,
  }) =>
      MainAppModel(
        isDarkThemeApp: isDarkThemeApp ?? this.isDarkThemeApp,
      );

  @override
  List<Object?> get props => [
        isDarkThemeApp,
      ];
}
