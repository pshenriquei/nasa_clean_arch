import 'package:flutter_triple/flutter_triple.dart';
import 'package:nasa_clean_arch/core/usecase/erros/failure.dart';
import 'package:nasa_clean_arch/features/domain/entities/space_media_entity.dart';
import 'package:nasa_clean_arch/features/domain/usecases/get_space_media_from_date_usecase.dart';

class HomeStore extends NotifierStore<Failure, SpaceMediaEntity> {
  final GetSpaceMediaFromDateUseCase useCase;

  HomeStore(this.useCase) : super(SpaceMediaEntity(description: '', mediaType: '', title: '', mediaUrl: ''));

  getSpaceMediaFromDate(DateTime? date) async {
    // executeEither(() =>
    //     useCase(date) as Future<EitherAdapter<Failure, SpaceMediaEntity>>);
    setLoading(true);
    final result = await useCase(date);
    result.fold((error) => setError(error), (success) => update(success));
    setLoading(false);
  }
}
