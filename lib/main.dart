import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gutendex/business_logic/cubit/book_cubit.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'data/provider/gutendex_service.dart';
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

    return RepositoryProvider(
      create: (_) => Gutendex(service: GutendexServiceImp()),
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
