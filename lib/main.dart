import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gutendex/business_logic/cubit/book_cubit.dart';
import 'package:gutendex/business_logic/cubit/search_cubit.dart';
import 'package:gutendex/data/provider/gutendex_service_web.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:path_provider/path_provider.dart';
import 'business_logic/paging_feature.dart';
import 'data/model/book.dart';
import 'data/repository/gutendex.dart';
import 'presentation/router/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final storage = await HydratedStorage.build(
      storageDirectory: await getApplicationDocumentsDirectory());
  HydratedBlocOverrides.runZoned(
    () => runApp(const App()),
    storage: storage,
  );
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final AppRouter appRouter = AppRouter();
    final gutendexService = GutendexServiceWeb(Dio());
    final gutendex = Gutendex(service: gutendexService);
    final pagingController = PagingController<int, Book>(firstPageKey: 1);
    final pagingFeature =
        PagingFeature(pagingController: pagingController, gutendex: gutendex)
          ..init();

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<Gutendex>(
          create: (_) => gutendex,
        ),
        RepositoryProvider(
          create: (_) => SearchCubit(
            pagingController,
            gutendex,
          ),
        ),
        RepositoryProvider(create: (_) => pagingFeature)
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => BookCubit(
              context.read<Gutendex>(),
              initialState: BookCubitInitialState(),
            ),
          ),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          onGenerateRoute: appRouter.onGenerateRoute,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
        ),
      ),
    );
  }
}
