import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:vocabulary_builder/v2/blocs/routes/bloc.dart';

class RoutesBloc extends Bloc<RoutesEvent, RoutesState> {
  @override
  RoutesState get initialState => RoutesState(route: 'No Route');

  @override
  Stream<RoutesState> mapEventToState( RoutesEvent event ) async* {
    if (event is ChangeRoute) {
      yield RoutesState(route: event.route);
    }
  }
}
