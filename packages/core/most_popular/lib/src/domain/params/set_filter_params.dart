import 'package:state_manager/state_manager.dart';

class FilterByGenre extends Params {
  final List<String> selectedFilters;

  const FilterByGenre({required this.selectedFilters});
}
