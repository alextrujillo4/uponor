import 'package:most_popular/most_popular_package.dart';
import 'package:state_manager/state_manager.dart';

class UpdateMovieParam extends Params {
  final IPopularMovie movie;

  UpdateMovieParam({required this.movie});
}
