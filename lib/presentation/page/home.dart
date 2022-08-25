import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/cubit/book_cubit.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<BookCubit>().getBooks();
    return Material(
      child: SafeArea(
        child: BlocBuilder<BookCubit, BookCubitState>(
          builder: (_, state) {
            if (state is BookCubitLoadedState) {
              return ListView.builder(
                itemBuilder: (BuildContext _, int index) {
                  return ListTile(
                    title: Text(state.books[index].title),
                  );
                },
                itemCount: state.books.length,
              );
            }
            return const Text("Loading");
          },
        ),
      ),
    );
  }
}
