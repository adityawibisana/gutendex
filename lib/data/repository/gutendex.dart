import 'package:gutendex/data/provider/gutendex_service.dart';

import '../model/book.dart';
import '../model/gutendex_books.dart';

class Gutendex {
  final GutendexService service;
  Gutendex({required this.service});

  Future<List<Book>> getBooks(int page) async {
    final apiResult = await service.getBooks(page);
    return GutendexBooks.fromJson(apiResult).results;
  }

  Future<List<Book>> searchBooks(String searchTerm) async {
    final apiResult = await service.searchBooks(searchTerm);
    return GutendexBooks.fromJson(apiResult).results;
  }
}
