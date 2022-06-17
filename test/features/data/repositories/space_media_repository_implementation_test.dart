import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nasa_clean_arch/core/erros/exceptions.dart';
import 'package:nasa_clean_arch/core/erros/failure.dart';
import 'package:nasa_clean_arch/features/data/datasource/space_media_datasource.dart';
import 'package:nasa_clean_arch/features/data/models/space_media_model.dart';
import 'package:nasa_clean_arch/features/data/repositories/space_media_repository_implementation.dart';

class MockSpaceMediaDataSource extends Mock implements ISpaceMediaDataSource {}

void main() {
  late SpaceMediaRepositoryImplementation repository;
  late ISpaceMediaDataSource dataSource;

  setUp(() {
    dataSource = MockSpaceMediaDataSource();
    repository = SpaceMediaRepositoryImplementation(dataSource);
  });

  final tSpaceMediaModel = SpaceMediaModel(
    description: 'test description',
    mediaType: 'image',
    title: 'test title',
    mediaUrl: 'https://test.media.url.com',
  );

  final tDate = DateTime(2022, 06, 15);

  test('Should return SpaceMediaModel when calls the DataSource', () async {
    when(() => dataSource.getSpaceMediaFromDate(any()))
        .thenAnswer((_) async => tSpaceMediaModel);
    final result = await repository.getSpaceMediaFromDate(tDate);
    expect(result, Right(tSpaceMediaModel));
    verify(() => dataSource.getSpaceMediaFromDate(tDate)).called(1);
  });

  test(
      'Should return a server failure when the call to dateSource is unsucessful',
      () async {
    when(() => dataSource.getSpaceMediaFromDate(any()))
        .thenThrow(ServerException());
    final result = await repository.getSpaceMediaFromDate(tDate);
    expect(result, Left(ServerFailure()));
    verify(() => dataSource.getSpaceMediaFromDate(tDate)).called(1);
  });
}
