import 'package:nasa_clean_arch/features/data/models/space_media_model.dart';

abstract class ISpaceMediaDataSource {
  Future<SpaceMediaModel> getSpaceMediaFromDate(DateTime date);
}
