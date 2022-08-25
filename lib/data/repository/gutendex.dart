import 'package:gutendex/data/provider/gutendex_service.dart';

import '../model/book.dart';
import '../model/gutendex_books.dart';

class Gutendex {
  final GutendexService service;
  Gutendex({required this.service});

  Future<List<Book>> getBooks() async {
    final apiResult = await service.getBooks();
    return GutendexBooks.fromJson(apiResult).results;
  }
}
