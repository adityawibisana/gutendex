import 'dart:convert';

import 'author.dart';
import 'format.dart';

class Book {
  final int id;
  final String title;
  final Format formats;
  final List<Author> authors;
  Book({
    required this.id,
    required this.title,
    required this.formats,
    required this.authors,
  });
  

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'id': id});
    result.addAll({'title': title});
    result.addAll({'formats': formats.toMap()});
    result.addAll({'authors': authors.map((x) => x.toMap()).toList()});
  
    return result;
  }

  factory Book.fromMap(Map<String, dynamic> map) {
    return Book(
      id: map['id']?.toInt() ?? 0,
      title: map['title'] ?? '',
      formats: Format.fromMap(map['formats']),
      authors: List<Author>.from(map['authors']?.map((x) => Author.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Book.fromJson(String source) => Book.fromMap(json.decode(source));
}
