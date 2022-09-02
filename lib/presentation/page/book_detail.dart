import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/cubit/search_cubit.dart';
import '../../data/model/author.dart';
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
            Expanded(child: _drawAuthors(book.authors)),
          ],
        ),
      ),
    );
  }

  Widget _drawAuthors(List<Author> authors) {
    if (authors.isEmpty) {
      return const SizedBox.shrink();
    }

    return ListView.builder(
      itemCount: authors.length,
      itemBuilder: (context, index) {
        return InkWell(
          child: Text(
            authors[index].name,
            style: const TextStyle(color: Colors.blue),
          ),
          onTap: () => {
            context.read<SearchCubit>().updateSearch(authors[index].name),
            Navigator.of(context).pop(),
          },
        );
      },
    );
  }
}
