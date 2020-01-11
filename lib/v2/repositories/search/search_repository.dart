
import 'package:vocabulary_builder/v2/models/models.dart';
import 'package:vocabulary_builder/v2/repositories/search/search_client.dart';

class SearchRepository {
  final SearchApiClient _client = SearchApiClient();

  Future<List<Word>> fetchWords({String search}) async {
    return await _client.searchWords(search: search);
  }
}