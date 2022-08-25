import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../page/home.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => const Home(),
        );
    }
    return onGenerateRoute(routeSettings.copyWith(name: '/'));
  }
}
