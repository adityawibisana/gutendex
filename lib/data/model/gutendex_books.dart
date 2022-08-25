import 'dart:convert';

import 'book.dart';

class GutendexBooks {
  final List<Book> results;
  GutendexBooks({
    required this.results,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'results': results.map((x) => x.toMap()).toList()});

    return result;
  }

  factory GutendexBooks.fromMap(Map<String, dynamic> map) {
    return GutendexBooks(
      results: List<Book>.from(map['results']?.map((x) => Book.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory GutendexBooks.fromJson(String source) =>
      GutendexBooks.fromMap(json.decode(source));
}
