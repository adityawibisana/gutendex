import 'package:flutter/services.dart';

abstract class GutendexService {
  Future<String> getBooks(int page) {
    throw UnimplementedError();
  }
}

class GutendexServiceImp implements GutendexService {
  @override
  Future<String> getBooks(int page) {
    return rootBundle.loadString('assets/gutendex_books.json');
  }
}
