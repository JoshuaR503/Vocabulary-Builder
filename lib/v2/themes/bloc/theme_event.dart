import 'package:equatable/equatable.dart';
import 'package:vocabulary_builder/v2/themes/themes.dart';
import 'package:meta/meta.dart';

abstract class ThemeEvent extends Equatable {
  ThemeEvent([List props = const <dynamic>[]]) : super(props);
}

class ThemeChanged extends ThemeEvent {
  final AppTheme theme;

  ThemeChanged({ @required this.theme }) : super([theme]);

  // TODO: Save to local database.
} 