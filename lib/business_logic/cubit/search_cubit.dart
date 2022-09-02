import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../data/model/book.dart';
import '../../data/repository/gutendex.dart';
import 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final StreamController<String> searchController = StreamController<String>();
  final PagingController<int, Book> pagingController;
  final Gutendex gutendex;

  SearchCubit(
    this.pagingController,
    this.gutendex,
  ) : super(SearchInitial(""));

  Future<void> search(String query) async {
    try {
      emit(SearchLoading(query));
      final newItems = await gutendex.searchBooks(query);
      pagingController.itemList = newItems;
      emit(SearchFinished(query));
    } catch (error) {
      pagingController.error = error;
    }
  }

  Future<void> updateSearch(String query) async {
    emit(SearchTypingCompleted(query));
    search(query);
  }
}
