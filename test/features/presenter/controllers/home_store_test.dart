import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nasa_clean_arch/core/usecase/erros/failure.dart';
import 'package:nasa_clean_arch/features/domain/usecases/get_space_media_from_date_usecase.dart';
import 'package:nasa_clean_arch/features/presenter/controllers/home_store.dart';

import '../../../mocks/date_mock.dart';
import '../../../mocks/space_media_entity_mock.dart';

class MockGetSpaceMediaFromDateUseCase extends Mock
    implements GetSpaceMediaFromDateUseCase {}

void main() {
  late HomeStore store;
  late GetSpaceMediaFromDateUseCase mockUseCase;
  final tFailure = ServerFailure();

  setUp(() {
    mockUseCase = MockGetSpaceMediaFromDateUseCase();
    store = HomeStore(mockUseCase);
    registerFallbackValue(DateTime(0, 0, 0));
  });

  test('Should return a SpaceMedia from useCase', () async {
    when(() => mockUseCase(any())).thenAnswer((_) async => Right(tSpaceMedia));
    store.getSpaceMediaFromDate(tDate);
    await store.getSpaceMediaFromDate(tDate);
    store.observer(onState: (state) {
      expect(state, tSpaceMedia);
      verify(() => mockUseCase(tDate)).called(1);
    });
  });

  test('Should return a Failure from the usecase when there is an error', () async {
    when(() => mockUseCase(any())).thenAnswer((_) async => Left(tFailure));
    await store.getSpaceMediaFromDate(tDate);
    store.observer(onError: (error) {
      expect(error, tFailure);
      verify(() => mockUseCase(tDate)).called(1);
    });
  });
}
