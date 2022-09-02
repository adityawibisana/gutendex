import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'package:gutendex/data/repository/gutendex.dart';

import '../data/model/book.dart';

class PagingFeature {
  final PagingController<int, Book> pagingController;
  final Gutendex gutendex;
  PagingFeature({
    required this.pagingController,
    required this.gutendex,
  });

  init() {
    pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await gutendex.getBooks(pageKey);
      final nextPageKey = pageKey + newItems.length;
      pagingController.appendPage(newItems, nextPageKey);
    } catch (error) {
      pagingController.error = error;
    }
  }
}
