import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:vocabulary_builder/v2/models/word/word.dart';

class WordDatabaseClient {

  Future<void> saveWord({String box, Word data}) async {
    
    print('Store in $box ${data.color}');
  }
  
  Future<dynamic> fetchSavedWords({String box}) async {

    print('Store in $box');
    
  }
}