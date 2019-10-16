
import 'package:vocabulary_builder/v2/models/models.dart';
import 'package:vocabulary_builder/v2/repositories/search/search_client.dart';

class SearchRepository {
  final SearchApiClient _searchApiClient = SearchApiClient();

  Future<List<Word>> fetchWords({String search}) async {
    return await _searchApiClient.searchWords(search: search);
  }

}