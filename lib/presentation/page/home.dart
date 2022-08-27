import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gutendex/data/repository/gutendex.dart';
import 'package:gutendex/presentation/router/app_router.dart';
import 'package:gutendex/presentation/widget/infinite_book_list.dart';

import '../../business_logic/cubit/book_cubit.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<BookCubit>().getBooks();
    return Material(
      child: SafeArea(
        child: RepositoryProvider(
          create: (_) =>
              RepositoryProvider.value(value: context.read<Gutendex>()),
          child: const InfiniteBookList(),
        ),
      ),
    );
  }
}
