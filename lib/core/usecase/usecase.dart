import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'erros/failure.dart';

abstract class UseCase<Output, Input> {
  Future<Either<Failure, Output>> call(Input params);
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}
