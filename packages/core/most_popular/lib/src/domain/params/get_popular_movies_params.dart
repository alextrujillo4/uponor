import 'package:state_manager/state_manager.dart';

class GetPopularMoviesParams extends Params {
  final bool forceRemote;

  const GetPopularMoviesParams({this.forceRemote = false});
}
