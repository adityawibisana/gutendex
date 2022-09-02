import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gutendex/presentation/widget/custom_image.dart';

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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomImage(context: context, url: book.formats.imagejpeg),
            Text(book.title, style: const TextStyle(fontSize: 20)),
            const Text("Authors:"),
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
          child: Center(
            child: Text(
              authors[index].name,
              style: const TextStyle(color: Colors.blue),
            ),
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
