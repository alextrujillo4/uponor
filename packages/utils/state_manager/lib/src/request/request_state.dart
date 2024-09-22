import 'package:failure/failure_package.dart';

abstract class RequestState {}

class EMPTY extends RequestState {}

class LOADING extends RequestState {
  final String message;

  LOADING({this.message = "Cargando"});
}

class SUCCESS<T> extends RequestState {
  final T data;

  SUCCESS({required this.data});
}

class ERROR extends RequestState {
  final Failure failure;

  ERROR({required this.failure});
}
