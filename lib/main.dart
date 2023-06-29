import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:rick_and_morty/details/presentation/page/details_page.dart';
import 'package:rick_and_morty/home/presentation/page/home_page.dart';
import 'package:rick_and_morty/injection.dart';
import 'package:rick_and_morty/shared/theme/application_theme.dart';
import 'package:rick_and_morty/shared/theme/data/app_theme.dart';

import 'shared/theme/data/cubit/theme_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  //runApp(const RickAndMortyApp());
  runApp(DevicePreview(builder: (_) {
    return const RickAndMortyApp();
  }));
}

class RickAndMortyApp extends StatelessWidget {
  const RickAndMortyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ThemeCubit>(
      create: (_) => GetIt.I.get<ThemeCubit>(),
      child: _App(),
    );
  }
}

final GoRouter _router = GoRouter(routes: <RouteBase>[
  GoRoute(
      path: '/',
      name: 'home',
      builder: ((context, state) => const HomePage()),
      routes: <RouteBase>[
        GoRoute(
            path: 'details/:id',
            name: 'details',
            builder: ((context, state) => DetailsPage(
                  characterId: state.pathParameters['id'] ?? '1',
                ))),
      ]),
]);

class _App extends StatelessWidget {
  const _App();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, String>(
        builder: (_, state) => MaterialApp.router(
              title: 'Flutter Demo',
              routerConfig: _router,
              theme: ApplicationTheme.byName(state)?.themeData,
            ));

    /* MaterialApp(
              title: 'Flutter Demo',
              theme: ApplicationTheme.byName(state)?.themeData,
              home: const HomePage(),
              initialRoute: '/',
              routes: {
                //'/': (context) => const HomePage(),
                '/details': (context) => const DetailsPage()
              },
            )); */
  }
}
