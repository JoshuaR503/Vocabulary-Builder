import 'package:dio/dio.dart';
import 'package:sembast/sembast.dart';
import 'package:vocabulary_builder/v2/data/database.dart';
import 'package:vocabulary_builder/v2/models/translation.dart';
import 'package:vocabulary_builder/v2/repositories/constants.dart';

class TranslationApiClient {

  static const String STORE_NAME = 'translationsSavedf';
  
  final _store = intMapStoreFactory.store(STORE_NAME);

  Future<Database> get _database async => await VocabularyBuilderDatabase.instance.database;

  final Dio httpClient = Dio();

  Future<String> translate({
    String sl, // Source Language.
    String tl, // Target Language.
    String text // Text to translate.
  }) async {

    final String url = '$kBaseUrl/v1/translate/$sl/$tl/?text=$text';
    final Response<dynamic> response = await this._fetchData(url: url);

    // Handle more status code responses.
    if (response.statusCode != 200) {
      throw Exception('There was an error translating. Please try again.');
    }

    final res = response.data['response'];
    final String translatedText = res['TranslatedText'];

    return translatedText;
  }

  Future<Response> _fetchData({String url}) async {
    final response = await this.httpClient.get(url);
    return response;
  }

  Future<void> insert({Translation translation}) async {

    final data = translation.toMap();

    await _store.add(await _database, data);
  }

  Future<void> delete({Translation translation}) async {

    final Filter filter = Filter.byKey(translation.id);
    final Finder finder = Finder(filter: filter);

    await _store.delete(
      await _database,
      finder: finder
    );
  }

  Future<List<Translation>> fetchTranslations() async {

    final Finder finder = Finder(
      sortOrders: [SortOrder(Field.key, false)]
    );

    final response = await _store.find(
      await _database,
      finder: finder
    );

    return response
    .map((snapshot) {

      final Translation 
      translation = Translation.fromMap(snapshot.value);
      translation.id = snapshot.key;

      print(translation.id);

      return translation;
    }).toList();
  }
}