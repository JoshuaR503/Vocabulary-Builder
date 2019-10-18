import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:vocabulary_builder/v2/models/models.dart';
import 'package:vocabulary_builder/v2/repositories/search/search_repository.dart';
import './bloc.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {

  final SearchRepository _searchRepository = SearchRepository();

  @override
  SearchState get initialState => InitialSearchState();

  @override
  Stream<SearchState> mapEventToState(SearchEvent event) async* {

    if (event is SearchWordsEvent) {
      
      yield LoadingSearchState();

      final List<Word> words = await _searchRepository.fetchWords(search: event.query);

      yield words.length == 0
      ? EmptySearchState()
      : LoadedSearchState(words: words);
    }
  }
}
