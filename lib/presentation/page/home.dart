import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gutendex/business_logic/paging_feature.dart';
import 'package:gutendex/presentation/widget/infinite_book_list.dart';

import '../../business_logic/search_feature.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: MultiRepositoryProvider(
          providers: [
            RepositoryProvider.value(
              value: context.read<SearchFeature>(),
            ),
            RepositoryProvider.value(
              value: context.read<PagingFeature>(),
            ),
          ],
          child: Column(
            children: [
              TextField(
                decoration: const InputDecoration(
                  label: Text("Search"),
                  prefixIcon: Icon(Icons.search),
                ),
                onSubmitted: (s) => {
                  context.read<SearchFeature>().search(s),
                },
              ),
              const Expanded(child: InfiniteBookList()),
            ],
          ),
        ),
      ),
    );
  }
}
