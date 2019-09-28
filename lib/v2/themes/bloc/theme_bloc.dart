import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:vocabulary_builder/v2/themes/themes.dart';
import './bloc.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  @override
  ThemeState get initialState => ThemeState(
    themeData: appTheme[AppTheme.Light]
  );

  @override
  Stream<ThemeState> mapEventToState(ThemeEvent event) async* {
    if (event is ThemeChanged) {
      yield ThemeState(themeData: appTheme[event.theme]);
    }
  }
}