
import 'package:vocabulary_builder/v2/config/colors.dart';
import 'package:vocabulary_builder/v2/models/category.dart';

const List<WordCategory> categories = [

  WordCategory(
    name: "Translator",
    routeName: 'translator',
    color: AppColors.teal,
    accentColor: AppColors.tealAccent,
    isSpecial: true
  ),

  WordCategory(
    name: "Verbs", 
    routeName: "Verbs", 
    color: AppColors.red,
    accentColor: AppColors.red,
  ),

  WordCategory(
    name: "Adjectives",
    routeName: "Adjectives",
    color: AppColors.blue,
    accentColor: AppColors.blue
  ),

  WordCategory(
    name: "Phrasal Verbs", 
    routeName: "phrasal_verbs",
    color: AppColors.orange,
    accentColor: AppColors.orange,
  ),

  WordCategory(
    name: "Favorite Words", 
    routeName: "saved",
    color: AppColors.indigo,
    accentColor: AppColors.indigo,
    isSpecial: true
  ),
  
  WordCategory(
    name: "Nouns", 
    routeName: "Nouns", 
    color: AppColors.amber,
    accentColor: AppColors.amberAccent
  ),

  WordCategory(
    name: "All Words",
    routeName: "All Words",
    color: AppColors.purple,
    accentColor: AppColors.purple,
  ),
  
  WordCategory(
    name: "Idioms",
    routeName: 'Idioms',
    color: AppColors.brown,
    accentColor: AppColors.brown,
  ),
];
