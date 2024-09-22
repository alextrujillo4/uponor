import 'package:dartz/dartz.dart';
import 'package:failure/failure_package.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}
