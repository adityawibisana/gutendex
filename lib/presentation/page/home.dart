import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gutendex/presentation/router/app_router.dart';

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
                    child: InkWell(
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  state.books[index].title,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  state.books[index].authors[0].name,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      onTap: () => {
                        Navigator.of(context).pushNamed(AppRouter.bookDetail,
                            arguments: state.books[index])
                      },
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
