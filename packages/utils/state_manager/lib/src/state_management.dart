import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_manager/state_manager.dart';

class StateManagement extends Bloc<RequestEvent, RequestState> {
  StateManagement() : super(EMPTY()) {
    on<Reset>(_resetEvent);
  }

  _resetEvent(Reset event, Emitter<RequestState> emit) {
    emit(LOADING());
    emit(EMPTY());
  }
}
