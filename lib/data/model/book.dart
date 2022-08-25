import 'dart:convert';

import 'format.dart';

class Book {
  final int id;
  final String title;
  final Format formats;
  Book({
    required this.id,
    required this.title,
    required this.formats,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'id': id});
    result.addAll({'title': title});
    result.addAll({'formats': formats.toMap()});
  
    return result;
  }

  factory Book.fromMap(Map<String, dynamic> map) {
    return Book(
      id: map['id']?.toInt() ?? 0,
      title: map['title'] ?? '',
      formats: Format.fromMap(map['formats']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Book.fromJson(String source) => Book.fromMap(json.decode(source));
}
