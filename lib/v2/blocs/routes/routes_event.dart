import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class RoutesEvent extends Equatable {
  RoutesEvent([List props = const<dynamic>[]]) : super(props);
}

class ChangeRoute extends RoutesEvent {
  final String route;

  ChangeRoute({@required this.route}) : super([route]);
}
