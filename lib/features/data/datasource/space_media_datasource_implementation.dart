import 'dart:convert';

import 'package:nasa_clean_arch/core/usecase/erros/exceptions.dart';
import 'package:nasa_clean_arch/core/utils/converters/date_to_string_converter.dart';
import 'package:nasa_clean_arch/core/utils/keys/nasa_api_keys.dart';
import 'package:nasa_clean_arch/features/data/datasource/endpoints/nasa_endpoints.dart';
import 'package:nasa_clean_arch/features/data/datasource/space_media_datasource.dart';
import 'package:nasa_clean_arch/features/data/models/space_media_model.dart';
import 'package:http/http.dart' as http;

class SpaceMediaDatasouceImplementation implements ISpaceMediaDataSource {

  final DateInputConverter converter;
  final http.Client client;

  SpaceMediaDatasouceImplementation({required this.converter, required this.client});

  @override
  Future<SpaceMediaModel> getSpaceMediaFromDate(DateTime date) async {
    final dateConverted = converter.format(date);
    final response = await client.get(NasaEndpoints.getSpaceMedia('DEMO_KEY',
      dateConverted));
    if (response.statusCode == 200) {
      return SpaceMediaModel.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException();
    }
  }
}
