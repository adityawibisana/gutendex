import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../data/model/book.dart';
import '../router/app_router.dart';

class InfiniteBookListItem extends StatelessWidget {
  final Book book;
  const InfiniteBookListItem({Key? key, required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 12,
      ),
      child: InkWell(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: _drawBookImage(context, book.formats.imagejpeg),
            ),
            const SizedBox(
              width: 12,
            ),
            Flexible(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    book.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    book.authors.isNotEmpty ? book.authors[0].name : "",
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
        onTap: () => {
          Navigator.of(context).pushNamed(AppRouter.bookDetail, arguments: book)
        },
      ),
    );
  }

  Widget _drawBookImage(BuildContext context, String url) {
    if (url.isEmpty) {
      url = "https://via.placeholder.com/150";
    }
    return CachedNetworkImage(
      imageUrl: url,
      placeholder: (context, url) => const CircularProgressIndicator(),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}
