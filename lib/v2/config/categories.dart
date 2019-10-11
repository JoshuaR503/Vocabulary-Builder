
import 'package:vocabulary_builder/v2/config/colors.dart';
import 'package:vocabulary_builder/v2/models/category.dart';

const List<WordCategory> categories = [

  WordCategory(
    name: "Translator",
    routeName: 'translator',
    color: AppColors.teal,
    isSpecial: true
  ),

  WordCategory(
    name: "Verbs", 
    routeName: "Verbs", 
    color: AppColors.red
  ),

  WordCategory(
    name: "Adjectives",
    routeName: "Adjectives",
    color: AppColors.blue
  ),

  WordCategory(
    name: "Phasal Verbs", 
    routeName: "Phasal Verbs",
    color: AppColors.orange
  ),

  WordCategory(
    name: "Idioms", 
    routeName: "Idioms",
    color: AppColors.indigo
  ),
  
  WordCategory(
    name: "Nouns", 
    routeName: "Nouns", 
    color: AppColors.amber
  ),

  WordCategory(
    name: "All Words",
    routeName: "All Words",
    color: AppColors.purple,
  ),
  
  WordCategory(
    name: "Favorite Words",
    routeName: 'saved',
    color: AppColors.brown,
    isSpecial: true
  ),
];
