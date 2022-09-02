class SearchState {}

class SearchInitial extends SearchState {}

class SearchTypingCompleted extends SearchState {
  final String query;
  SearchTypingCompleted(this.query);
}
