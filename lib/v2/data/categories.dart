
import 'package:vocabulary_builder/v2/config/colors.dart';
import 'package:vocabulary_builder/v2/models/category.dart';

const List<WordCategory> categories = [
  WordCategory(
    name: "All Words", 
    color: AppColors.lightTeal
  ),
  WordCategory(
    name: "Verb", 
    color: AppColors.red
  ),
  WordCategory(
    name: "Adjective", 
    color: AppColors.blue
  ),
  WordCategory(
    name: "Phasal Verb", 
    color: AppColors.orange
  ),
  WordCategory(
    name: "Idiom", 
    color: AppColors.indigo
  ),
  WordCategory(
    name: "Noun", 
    color: AppColors.betterYellow
  ),
  WordCategory(
    name: "Translator", 
    color: AppColors.purple,
    isSpecial: true
  ),
  WordCategory(
    name: "Favorite Words",
    color: AppColors.brown,
    isSpecial: true
  ),
];
