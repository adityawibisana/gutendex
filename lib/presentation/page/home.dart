import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gutendex/business_logic/paging_feature.dart';
import 'package:gutendex/presentation/widget/infinite_book_list.dart';

import '../../business_logic/cubit/search_cubit.dart';
import '../../business_logic/cubit/search_state.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final searchTextController = TextEditingController();
    return Material(
      child: SafeArea(
        child: MultiRepositoryProvider(
          providers: [
            RepositoryProvider.value(
              value: context.read<SearchCubit>(),
            ),
            RepositoryProvider.value(
              value: context.read<PagingFeature>(),
            ),
          ],
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: const InputDecoration(
                        label: Text("Search"),
                        prefixIcon: Icon(Icons.search),
                      ),
                      onSubmitted: (s) => {
                        context.read<SearchCubit>().search(s),
                      },
                      controller: searchTextController,
                    ),
                  ),
                  BlocBuilder<SearchCubit, SearchState>(
                    builder: (context, state) {
                      if (state is SearchLoading) {
                        return const CircularProgressIndicator();
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ],
              ),
              BlocListener<SearchCubit, SearchState>(
                listener: (context, state) {
                  searchTextController.text = state.query;
                },
                child: const SizedBox.shrink(),
              ),
              const Expanded(child: InfiniteBookList()),
            ],
          ),
        ),
      ),
    );
  }
}
