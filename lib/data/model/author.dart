import 'dart:convert';

class Author {
  final String name;
  final int birthYear;
  final int deathYear;
  Author({
    required this.name,
    required this.birthYear,
    required this.deathYear,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'name': name});
    result.addAll({'birth_year': birthYear});
    result.addAll({'death_year': deathYear});

    return result;
  }

  factory Author.fromMap(Map<String, dynamic> map) {
    return Author(
      name: map['name'] ?? '',
      birthYear: map['birth_year']?.toInt() ?? 0,
      deathYear: map['death_year']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Author.fromJson(String source) => Author.fromMap(json.decode(source));
}
