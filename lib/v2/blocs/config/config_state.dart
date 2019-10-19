import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class ConfigState extends Equatable {

  ConfigState({
    @required this.isFirstTime,
    @required this.hasLanguage,
    @required this.hasLevel
  }) : super([isFirstTime, hasLanguage, hasLevel]);

  final bool isFirstTime;
  final bool hasLanguage;
  final bool hasLevel;

}
