import 'package:dartz/dartz.dart';
import 'package:failure/failure_package.dart';

abstract class ErrorHandler {
  Future<Either<Failure, T>> handle<T>(Future<T> Function() operation) async {
    try {
      final result = await operation();
      return Right(result);
    } on Failure catch (e) {
      return Left(e);
    }
  }
}
