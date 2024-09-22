import 'package:cache/di.dart' as cache;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:most_popular/di.dart' as most_popular;
import 'package:most_popular/most_popular_package.dart';
import 'package:movie_challenge/common/theme.dart';
import 'package:movie_challenge/di.dart';
import 'package:movie_challenge/features/popular_movies/bloc/popular_movies_bloc.dart';
import 'package:movie_challenge/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:state_manager/state_manager.dart';

import 'common/settings_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await most_popular.init();
  await cache.init();
  await init();

  runApp(MaterialApp(
    theme: appTheme,
    home: MultiBlocProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => sl<SettingsProvider>()),
        BlocProvider(
          create: (_) => sl<PopularMoviesBloc>()
            ..add(
              Invoke(
                params: const GetPopularMoviesParams(),
              ),
            ),
        ),
      ],
      child: const HomeScreen(),
    ),
  ));
}
