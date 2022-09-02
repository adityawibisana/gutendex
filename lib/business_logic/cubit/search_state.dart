class SearchState {
  final String query;
  SearchState(
    this.query,
  );
}

class SearchInitial extends SearchState {
  SearchInitial(super.query);
}

class SearchTypingCompleted extends SearchState {
  SearchTypingCompleted(super.query);
}

class SearchLoading extends SearchState {
  SearchLoading(super.query);
}

class SearchFinished extends SearchState {
  SearchFinished(super.query);
}
