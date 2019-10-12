import 'package:meta/meta.dart';

import 'package:vocabulary_builder/v2/models/models.dart';
import 'package:vocabulary_builder/v2/repositories/word/word_db_client.dart';

class WordRepository {

  final WordDatabaseClient client = WordDatabaseClient();

  void fetchWords() async {
    final res = await this.client.fetchSavedWords(box: 'Words');
    print(res);
  }

  void saveWord(Word word) async {
    await this.client.saveWord(box: 'Words', data: word);
  }
}