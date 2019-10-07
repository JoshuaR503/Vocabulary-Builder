
import 'package:flutter/material.dart';
import 'package:vocabulary_builder/v2/config/colors.dart';
import 'package:vocabulary_builder/v2/models/category.dart';

const List<WordCategory> categories = [
  WordCategory(
    name: "Translator", 
    color: AppColors.lightTeal
  ),
  WordCategory(
    name: "Verbs", 
    color: AppColors.red
  ),
  WordCategory(
    name: "Adjectives", 
    color: AppColors.blue
  ),
  WordCategory(
    name: "Phasal Verbs", 
    color: AppColors.orange
  ),
  WordCategory(
    name: "Idioms", 
    color: AppColors.indigo
  ),
  WordCategory(
    name: "Nouns", 
    color: Colors.amber
  ),
  WordCategory(
    name: "All Words", 
    color: AppColors.purple,
    isSpecial: true
  ),
  WordCategory(
    name: "Favorite Words",
    color: AppColors.brown,
    isSpecial: true
  ),
];
