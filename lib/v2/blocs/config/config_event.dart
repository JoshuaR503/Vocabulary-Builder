import 'package:equatable/equatable.dart';

abstract class ConfigEvent extends Equatable {
  ConfigEvent([List props = const []]) : super(props);
}

class LanguageChangedEvent extends ConfigEvent {
  LanguageChangedEvent({
    this.config,
  }) : super([config]);

  final String config;
}

class LevelChangedEvent extends ConfigEvent {
  LevelChangedEvent({
    this.config,
  }) : super([config]);

  final String config;
}

class SliderSeenEvent extends ConfigEvent {}