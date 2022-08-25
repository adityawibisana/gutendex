import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/cubit/book_cubit.dart';
import '../page/home.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [BlocProvider.value(value: context.read<BookCubit>())],
            child: const Home(),
          ),
        );
    }
    return onGenerateRoute(routeSettings.copyWith(name: '/'));
  }
}
