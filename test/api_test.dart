import 'package:flutter_test/flutter_test.dart';
import 'package:gutendex/data/model/gutendex_books.dart';
import 'package:gutendex/data/provider/gutendex_service.dart';

void main() {
  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
  });
  group('Mock API', () {
    test('Should be able to get parse model from mock API correctly', () async {
      final GutendexService service = GutendexServiceImp();
      final booksJson = await service.getBooks(1);
      final GutendexBooks gb = GutendexBooks.fromJson(booksJson);
      final books = gb.results;
      expect(books[0].title, "Pride and Prejudice");
      expect(books[0].authors[0].name, "Austen, Jane");
      expect(books[0].id, 1342);
    });
  });
}
