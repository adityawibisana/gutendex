import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gutendex/presentation/widget/infinite_book_list_item.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../business_logic/paging_feature.dart';
import '../../business_logic/search_feature.dart';
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
  late PagingController<int, Book> _pagingController;
  late StreamSubscription<String> searchSubscription;

  @override
  void initState() {
    _pagingController = context.read<PagingFeature>().pagingController;

    searchSubscription = context
        .read<SearchFeature>()
        .searchController
        .stream
        .listen((searchTerm) {
      _search(searchTerm);
    });

    super.initState();
  }

  Future<void> _search(String query) async {
    try {
      final newItems = await context.read<Gutendex>().searchBooks(query);
      _pagingController.itemList = newItems;
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  void dispose() {
    searchSubscription.cancel();
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
