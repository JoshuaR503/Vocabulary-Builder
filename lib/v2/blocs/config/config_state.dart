import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class ConfigState extends Equatable {

  ConfigState({
    @required this.hasLanguage,
    @required this.hasLevel
  }) : super([hasLanguage, hasLevel]);

  final bool hasLanguage;
  final bool hasLevel;

}
