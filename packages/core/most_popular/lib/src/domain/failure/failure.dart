import 'package:failure/failure_package.dart';

class ApiCallFailure extends Failure {
  ApiCallFailure({required super.message, super.stacktrace});
}

class ParseFailure extends Failure {
  ParseFailure({required super.message, super.stacktrace});
}
