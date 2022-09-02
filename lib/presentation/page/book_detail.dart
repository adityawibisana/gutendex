import 'package:flutter/material.dart';

import '../../data/model/book.dart';

class BookDetail extends StatelessWidget {
  final Book book;
  const BookDetail({
    Key? key,
    required this.book,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Column(
          children: [
            Text(book.title),
            InkWell(
              child: Text(book.authors.isNotEmpty ? book.authors[0].name : ""),
              onTap: () => {
                Navigator.of(context).pop(),
              },
            ),
          ],
        ),
      ),
    );
  }
}
