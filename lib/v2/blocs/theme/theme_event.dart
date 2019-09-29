import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:meta/meta.dart';

abstract class ThemeEvent extends Equatable {
  ThemeEvent([List props = const <dynamic>[]]) : super(props);
}

class ThemeChanged extends ThemeEvent {
  final String theme;

  ThemeChanged({ @required this.theme }) : super([theme]) {
    this._saveTheme();
  }

  void _saveTheme() async {
    final theme = this.theme.toString();
    final SharedPreferences 
    prefs = await SharedPreferences.getInstance();
    prefs.setString('app_theme', theme);
  }
} 