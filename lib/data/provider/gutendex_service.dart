import 'package:flutter/services.dart';

abstract class GutendexService {
  Future<String> getBooks() {
    throw UnimplementedError();
  }
}

class GutendexServiceImp implements GutendexService {
  @override
  Future<String> getBooks() {
    return rootBundle.loadString('assets/gutendex_books.json');
  }
}
