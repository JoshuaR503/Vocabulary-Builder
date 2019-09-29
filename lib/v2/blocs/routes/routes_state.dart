import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class RoutesState extends Equatable {
  final String route;

  RoutesState({@required this.route}) : super([route]);
}
