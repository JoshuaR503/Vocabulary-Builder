import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:vocabulary_builder/v2/models/word/word.dart';

class WordDatabaseClient {

  final String path;
  
  WordDatabaseClient({
    @required this.path,
  });

  Future<void> saveWord({String box, Word data}) async {

    Hive.init(path);
    
    await Hive
    .box(box)
    .add(data);
  }
  
  Future<dynamic> fetchSavedWords({String box}) async {
    
    Hive.init(path);

    final dynamic data = await Hive.openBox(box);

    print(data);
  }
}