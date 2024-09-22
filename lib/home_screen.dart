import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:most_popular/most_popular_package.dart';
import 'package:movie_challenge/common/extensions.dart';
import 'package:movie_challenge/common/settings_provider.dart';
import 'package:movie_challenge/features/create_movie/page/create_movie_screen.dart';
import 'package:movie_challenge/features/popular_movies/bloc/popular_movies_bloc.dart';
import 'package:provider/provider.dart';
import 'package:state_manager/state_manager.dart';

import 'common/app_strings.dart';
import 'di.dart';
import 'features/popular_movies/page/popular_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void didChangeDependencies() {
    context.read<PopularMoviesBloc>().add(Invoke(
          params: const FilterByGenre(selectedFilters: []),
        ));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<PopularMoviesBloc>()
        ..add(
          Invoke(
            params: const GetPopularMoviesParams(),
          ),
        ),
      child: Consumer<SettingsProvider>(
        builder: (context, settingsProvider, _) => Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            centerTitle: true,
            elevation: 0,
            title: Text(AppStrings.appBarTitle,
                style: Theme.of(context).textTheme.headlineMedium),
            actions: [
              IconButton(
                key: const Key("list_view_btn"),
                onPressed: () {
                  setState(() {
                    settingsProvider.isListView = !settingsProvider.isListView;
                  });
                },
                icon: settingsProvider.isListView
                    ? const Icon(key: Key("grid_on_icon"), Icons.grid_on)
                    : const Icon(key: Key("grid_off_icon"), Icons.grid_off),
              ),
              PopupMenuButton<String>(
                icon: const Icon(key: Key("more_icon"), Icons.more_vert),
                onSelected: (value) {
                  context.read<PopularMoviesBloc>().add(Invoke(
                        params: const GetPopularMoviesParams(forceRemote: true),
                      ));
                },
                itemBuilder: (BuildContext context) {
                  return {'Create mocked elements'}.map((String choice) {
                    return PopupMenuItem<String>(
                      value: choice,
                      child: Text(choice),
                    );
                  }).toList();
                },
              ),
            ],
          ),
          body: Stack(
            children: [
              Image.asset(
                'assets/images/background.JPG',
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
              Center(
                child: ConstrainedBox(
                    constraints: context.isLandscape()
                        ? const BoxConstraints(maxWidth: 600)
                        : const BoxConstraints(),
                    child: const PopularPage(key: Key("popular_page"))),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const CreateMovieScreen(),
                ),
              );
            },
            label: const Row(
              children: [
                Icon(Icons.add),
                Text(AppStrings.newMovie),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
