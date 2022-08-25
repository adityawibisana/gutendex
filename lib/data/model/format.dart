import 'dart:convert';

class Format {
  final String imagejpeg;
  Format({
    required this.imagejpeg,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'image/jpeg': imagejpeg});

    return result;
  }

  factory Format.fromMap(Map<String, dynamic> map) {
    return Format(
      imagejpeg: map['image/jpeg'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Format.fromJson(String source) => Format.fromMap(json.decode(source));
}
