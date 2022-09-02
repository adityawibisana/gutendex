import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gutendex/presentation/widget/infinite_book_list_item.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../business_logic/paging_feature.dart';
import '../../data/model/book.dart';

class InfiniteBookList extends StatefulWidget {
  const InfiniteBookList({Key? key}) : super(key: key);

  @override
  State<InfiniteBookList> createState() {
    return _InfiniteBookListState();
  }
}

class _InfiniteBookListState extends State<InfiniteBookList> {
  // 1
  late PagingController<int, Book> _pagingController;

  @override
  void initState() {
    _pagingController = context.read<PagingFeature>().pagingController;
    super.initState();
  }

  @override
  void dispose() {
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
