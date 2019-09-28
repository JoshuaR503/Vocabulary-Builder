
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Route extends Equatable {

  final String name;

  Route({
    @required this.name, 
  }) : super([name]);
}
