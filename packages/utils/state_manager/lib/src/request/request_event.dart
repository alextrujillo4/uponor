abstract class RequestEvent {}

class Invoke<T> extends RequestEvent {
  final T params;

  Invoke({required this.params});
}

class Reset extends RequestEvent {}
