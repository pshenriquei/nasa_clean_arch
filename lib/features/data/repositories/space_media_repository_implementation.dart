import 'package:nasa_clean_arch/features/domain/entities/space_media_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:nasa_clean_arch/features/domain/repositories/space_media_repository.dart';

import '../../../core/usecase/erros/exceptions.dart';
import '../../../core/usecase/erros/failure.dart';
import '../datasource/space_media_datasource.dart';

class SpaceMediaRepositoryImplementation implements ISpaceMediaRepository {
  final ISpaceMediaDataSource dataSource;

  SpaceMediaRepositoryImplementation(this.dataSource);

  @override
  Future<Either<Failure, SpaceMediaEntity>> getSpaceMediaFromDate(
      DateTime date) async {
    try {
      final result = await dataSource.getSpaceMediaFromDate(date);
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
