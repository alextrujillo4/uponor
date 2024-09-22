abstract class Failure {
  final String message;
  final StackTrace? stacktrace;

  Failure({required this.message, required this.stacktrace});
}
