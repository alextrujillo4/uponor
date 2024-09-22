import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:most_popular/most_popular_package.dart';
import 'package:movie_challenge/common/app_strings.dart';
import 'package:movie_challenge/features/create_movie/bloc/create_movie_bloc.dart';
import 'package:state_manager/state_manager.dart';

import '../../../common/widgets/icon_button_widget.dart';

class MovieForm extends StatefulWidget {
  final IPopularMovie? movie;

  const MovieForm({Key? key, this.movie}) : super(key: key);

  @override
  _MovieFormState createState() => _MovieFormState();
}

class _MovieFormState extends State<MovieForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _overviewController = TextEditingController();
  final TextEditingController _releaseDateController = TextEditingController();
  int _voteCount = 3;
  String _originalLanguage = AppStrings.english;
  List<String> _selectedGenres = [];
  String? _selectedImageUrl;
  DateTime? _selectedReleaseDate;

  final List<Map<String, String>> unsplashImages = [
    {
      'url':
          'https://media.istockphoto.com/id/1141549703/photo/on-the-wings-of-freedom-birds-flying-and-broken-chains-charge-concept.webp?a=1&b=1&s=612x612&w=0&k=20&c=bBtg-T-o2gPMPOp1giAsE8H54N20ERXqfxThkT9YzXo=',
      'name': 'Freedom Birds',
    },
    {
      'url':
          'https://media.istockphoto.com/id/1132930101/photo/leadership-concept-with-paper-airplanes.webp?a=1&b=1&s=612x612&w=0&k=20&c=AJ4cD8iZkCscZdAvisK7Qo3Jq7Xoy-Xx6CxEOLdi1L4=',
      'name': 'Paper Airplanes',
    },
    {
      'url':
          'https://media.istockphoto.com/id/74180472/photo/woman-in-infinity-pool.webp?a=1&b=1&s=612x612&w=0&k=20&c=H2bkHpzoZGiBFscwKW22C8-owy3dP50xg3-nmP1QKoU=',
      'name': 'Infinity Pool',
    },
    {
      'url':
          'https://media.istockphoto.com/id/1137402783/photo/dandelion-in-field-at-sunset-air-and-blowing.webp?a=1&b=1&s=612x612&w=0&k=20&c=CBE6KxHjOctV4vmJD31dEpiFeu9WtDdMtdnnraw6-fI=',
      'name': 'Dandelion Sunset',
    },
    {
      'url':
          'https://media.istockphoto.com/id/2148133417/photo/signs-politics-and-people-at-street-protest-for-empowerment-equality-and-human-rights.webp?a=1&b=1&s=612x612&w=0&k=20&c=pi76Xwibu6smXalIGy_imszV8BdKYJkYPiACCI0WYyc=',
      'name': 'Street Protest',
    },
    {
      'url':
          'https://images.unsplash.com/file-1722962848292-892f2e7827caimage?w=416&dpr=2&auto=format&fit=crop&q=60',
      'name': 'Random Landscape',
    },
    {
      'url':
          'https://media.istockphoto.com/id/184103864/photo/clouds-on-sky.webp?a=1&b=1&s=612x612&w=0&k=20&c=Rns43dSWPSYJG75Ya-fdWj2NoY1yIE5NxzTSl1JDmfM=',
      'name': 'Cloudy Sky',
    },
    {
      'url':
          'https://media.istockphoto.com/id/1265024528/photo/no-better-adventure-buddy.webp?a=1&b=1&s=612x612&w=0&k=20&c=tStWgNSFBAGPyu4gfJfDEjqMPDnvgqWUkIPyZYGS090=',
      'name': 'Adventure Buddy',
    },
    {
      'url':
          'https://media.istockphoto.com/id/1268636389/photo/asian-chinese-mid-adult-woman-helping-her-father-in-the-farm-greenhouse.webp?a=1&b=1&s=612x612&w=0&k=20&c=w54XY-r_F9NAcP05cLUVZWaTjWz0AUqzwx0bFpuwgcQ=',
      'name': 'Farm Greenhouse',
    },
    {
      'url':
          'https://media.istockphoto.com/id/77931645/photo/woman-and-young-girl-outdoors-with-people-in-background.webp?a=1&b=1&s=612x612&w=0&k=20&c=nASPunIXuW72Fyi1yWUPQTdNa32m5jeYxuiso8uJf_A=',
      'name': 'Outdoor Fun',
    },
  ];

  final List<String> availableGenres = [
    AppStrings.action,
    AppStrings.comedy,
    AppStrings.scienceFiction,
    AppStrings.fantasy,
    AppStrings.horror,
    AppStrings.adventure,
    AppStrings.thriller,
    AppStrings.family,
    AppStrings.animation,
    AppStrings.drama
  ];

  @override
  void initState() {
    super.initState();

    if (widget.movie != null) {
      _titleController.text = widget.movie!.title;
      _overviewController.text = widget.movie!.overview;
      _releaseDateController.text = widget.movie!.releaseDate;
      _voteCount = widget.movie!.voteCount;
      _selectedGenres = widget.movie!.genres;
      _selectedImageUrl =
          widget.movie?.posterPath ?? unsplashImages.first['url'];
      _originalLanguage = widget.movie?.originalLanguage ?? AppStrings.english;
    } else {
      _selectedImageUrl = unsplashImages.first['url'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        children: [
          Text(
            AppStrings.selectImage,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          if (_isImageEditable()) _buildImageSelector(),
          const SizedBox(height: 16),
          TextFormField(
            controller: _titleController,
            decoration: InputDecoration(labelText: AppStrings.title),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return AppStrings.enterTitle;
              }
              return null;
            },
          ),
          TextFormField(
            controller: _overviewController,
            decoration: InputDecoration(labelText: AppStrings.overview),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return AppStrings.enterOverview;
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          Text(
            AppStrings.selectGenres,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          _buildGenreSelector(),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            value: _originalLanguage,
            decoration: InputDecoration(labelText: AppStrings.languages),
            items: const [
              DropdownMenuItem(
                  value: AppStrings.english, child: Text(AppStrings.english)),
              DropdownMenuItem(
                  value: AppStrings.spanish, child: Text(AppStrings.spanish)),
            ],
            onChanged: (value) {
              setState(() {
                _originalLanguage = value!;
              });
            },
          ),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime(2100),
              );
              if (pickedDate != null) {
                setState(() {
                  _selectedReleaseDate = pickedDate;
                  _releaseDateController.text =
                      _selectedReleaseDate!.toIso8601String().split('T').first;
                });
              }
            },
            child: AbsorbPointer(
              child: TextFormField(
                controller: _releaseDateController,
                decoration: InputDecoration(labelText: AppStrings.releaseDate),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppStrings.enterReleaseDate;
                  }
                  return null;
                },
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            AppStrings.voteAverage,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          _buildStarSelector(),
          const SizedBox(height: 16),
          widget.movie == null
              ? IconButtonWidget(
                  color: Colors.blueAccent,
                  label: AppStrings.create,
                  icon: const Icon(Icons.new_releases),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final newMovie = PopularMovie(
                        id: widget.movie?.id ??
                            DateTime.now().millisecondsSinceEpoch,
                        title: _titleController.text,
                        genres: _selectedGenres,
                        overview: _overviewController.text,
                        releaseDate: _releaseDateController.text,
                        posterPath: _selectedImageUrl!,
                        voteAverage: _voteCount.toDouble(),
                        voteCount: _voteCount,
                        adult: false,
                        originalLanguage: _originalLanguage,
                        originalTitle: _titleController.text,
                        video: false,
                        backdropPath: null,
                        popularity: 1000,
                      );

                      context.read<CreateMovieBloc>().add(
                          Invoke(params: CreateMovieParam(movie: newMovie)));
                    }
                  },
                )
              : IconButtonWidget(
                  color: Colors.black26,
                  label: AppStrings.save,
                  icon: const Icon(Icons.save),
                  onPressed: () {
                    if (_formKey.currentState?.validate() == true) {
                      final movie = PopularMovie(
                        id: widget.movie?.id ??
                            DateTime.now().millisecondsSinceEpoch,
                        title: _titleController.text,
                        genres: _selectedGenres,
                        overview: _overviewController.text,
                        releaseDate: _releaseDateController.text,
                        posterPath: _selectedImageUrl!,
                        voteAverage: _voteCount.toDouble(),
                        voteCount: _voteCount,
                        adult: false,
                        originalLanguage: _originalLanguage,
                        originalTitle: _titleController.text,
                        video: false,
                        backdropPath: null,
                        popularity: 1000,
                      );

                      context
                          .read<CreateMovieBloc>()
                          .add(Invoke(params: UpdateMovieParam(movie: movie)));
                    }
                  },
                )
        ],
      ),
    );
  }

  bool _isImageEditable() {
    return widget.movie == null ||
        unsplashImages.any((image) => image['url'] == _selectedImageUrl);
  }

  Widget _buildImageSelector() {
    return Wrap(
      spacing: 8.0,
      children: unsplashImages.map((image) {
        final bool isSelected = _selectedImageUrl == image['url'];
        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedImageUrl = image['url'];
            });
          },
          child: Stack(
            children: [
              Card(
                elevation: isSelected ? 8 : 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                clipBehavior: Clip.antiAlias,
                child: SizedBox(
                  height: 100,
                  child: Positioned.fill(
                    child: Image.network(
                      image['url']!,
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                      color: isSelected ? Colors.black.withOpacity(0.4) : null,
                      colorBlendMode: BlendMode.darken,
                    ),
                  ),
                ),
              ),
              if (isSelected)
                const Positioned(
                  top: 0,
                  right: 0,
                  child:
                      Icon(Icons.check_circle, color: Colors.white, size: 24),
                ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildGenreSelector() {
    return Wrap(
      spacing: 8.0,
      children: availableGenres.map((genre) {
        final isSelected = _selectedGenres.contains(genre);
        return ChoiceChip(
          label: Text(genre),
          selected: isSelected,
          onSelected: (selected) {
            setState(() {
              if (selected) {
                _selectedGenres.add(genre);
              } else {
                _selectedGenres.remove(genre);
              }
            });
          },
        );
      }).toList(),
    );
  }

  Widget _buildStarSelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        return IconButton(
          icon: Icon(index < _voteCount ? Icons.star : Icons.star_border,
              color: Colors.amber),
          onPressed: () {
            setState(() {
              _voteCount = index + 1;
            });
          },
        );
      }),
    );
  }
}
