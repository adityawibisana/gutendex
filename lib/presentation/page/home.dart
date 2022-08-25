import 'package:cached_network_image/cached_network_image.dart';
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
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 12,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 1,
                          child: CachedNetworkImage(
                            imageUrl: state.books[index].formats.imagejpeg,
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Flexible(
                          flex: 3,
                          child: Text(
                            state.books[index].title,
                            maxLines: 2,
                          ),
                        ),
                      ],
                    ),
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
