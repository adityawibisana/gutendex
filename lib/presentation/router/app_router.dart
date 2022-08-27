import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gutendex/data/repository/gutendex.dart';
import 'package:gutendex/presentation/page/book_detail.dart';

import '../../business_logic/cubit/book_cubit.dart';
import '../../data/model/book.dart';
import '../page/home.dart';

class AppRouter {
  static const String bookDetail = '/book-detail';
  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (context) => RepositoryProvider(
            create: (_) => RepositoryProvider.value(value: context.watch<Gutendex>()),
            child: MultiBlocProvider(
              providers: [BlocProvider.value(value: context.read<BookCubit>())],
              child: const Home(),
            ),
          ),
        );

      case bookDetail:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: context.read<BookCubit>()),
            ],
            child: BookDetail(book: routeSettings.arguments as Book),
          ),
        );
    }
    return onGenerateRoute(routeSettings.copyWith(name: '/'));
  }
}
