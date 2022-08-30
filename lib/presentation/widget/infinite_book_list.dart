import 'package:flutter/material.dart';
import 'package:gutendex/presentation/widget/infinite_book_list_item.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/model/book.dart';
import '../../data/repository/gutendex.dart';

class InfiniteBookList extends StatefulWidget {
  const InfiniteBookList({Key? key}) : super(key: key);

  @override
  State<InfiniteBookList> createState() {
    return _InfiniteBookListState();
  }
}

class _InfiniteBookListState extends State<InfiniteBookList> {
  // 1
  final _pagingController = PagingController<int, Book>(
    // 2
    firstPageKey: 1,
  );

  @override
  void initState() {
    // 3
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await context.read<Gutendex>().getBooks(pageKey);
      final nextPageKey = pageKey + newItems.length;
      _pagingController.appendPage(newItems, nextPageKey);
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  void dispose() {
    // 4
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => Future.sync(
        // 2
        () => _pagingController.refresh(),
      ),
      child: PagedListView.separated(
        pagingController: _pagingController,
        separatorBuilder: (context, index) => const SizedBox(
          height: 16,
        ),
        builderDelegate: PagedChildBuilderDelegate<Book>(
          itemBuilder: (BuildContext _, Book book, int index) {
            return InfiniteBookListItem(book: book);
          },
        ),
      ),
    );
  } 
}
