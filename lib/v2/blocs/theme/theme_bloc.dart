
import 'package:bloc/bloc.dart';
import 'package:vocabulary_builder/v2/blocs/theme/bloc.dart';
import 'package:vocabulary_builder/v2/config/themes/themes.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {

  @override
  ThemeState get initialState => ThemeState(
    themeData: appTheme['Dark']
  );
  
  @override
  Stream<ThemeState> mapEventToState(ThemeEvent event) async* {
    if (event is ThemeChanged) {
      yield ThemeState(themeData: appTheme[event.theme]);
    }
  }
}