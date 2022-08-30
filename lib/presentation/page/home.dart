import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gutendex/data/repository/gutendex.dart';
import 'package:gutendex/presentation/widget/infinite_book_list.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
