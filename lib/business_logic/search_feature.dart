import 'dart:async';

import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../data/model/book.dart';
import '../data/repository/gutendex.dart';

class SearchFeature {
  final StreamController<String> searchController = StreamController<String>();
  final PagingController<int, Book> pagingController;
  final Gutendex gutendex;
  SearchFeature({
    required this.pagingController,
    required this.gutendex,
  });

  Future<void> search(String query) async {
    try {
      final newItems = await gutendex.searchBooks(query);
      pagingController.itemList = newItems;
    } catch (error) {
      pagingController.error = error;
    }
  }
}
