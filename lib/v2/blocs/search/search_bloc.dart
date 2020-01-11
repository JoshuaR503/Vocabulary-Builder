import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:vocabulary_builder/v2/core/network.dart';
import 'package:vocabulary_builder/v2/models/models.dart';
import 'package:vocabulary_builder/v2/repositories/search/search_repository.dart';
import './bloc.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {

  final SearchRepository _searchRepository = SearchRepository();
  final NetworkInfoImpl _networkInfoImpl = NetworkInfoImpl();

  @override
  SearchState get initialState => InitialSearchState();

  @override
  Stream<SearchState> mapEventToState(SearchEvent event) async* {

    if (event is SearchWordsEvent) {
      // Loading State
      yield LoadingSearchState();

      // Ensure that there is Internet Connection.
      final bool isConnected = await _networkInfoImpl.isConnected;

      // Handler when there is no Internet Connection.
      if (!isConnected) {
        yield SearchNoConnectionState();
      }
      
      try {
        // Words response.
        final List<Word> words = await _searchRepository.fetchWords(search: event.query);

        // State handler.
        yield words.isEmpty
        ? EmptySearchState()
        : LoadedSearchState(words: words);

      // Error Handling.
      } catch (e) {
        yield ErrorSearchState(error: e);
      }
    }
  }
}
