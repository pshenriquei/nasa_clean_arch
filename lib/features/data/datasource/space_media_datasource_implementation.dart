import 'dart:convert';

import 'package:nasa_clean_arch/core/http_client/http_client.dart';
import 'package:nasa_clean_arch/core/usecase/erros/exceptions.dart';
import 'package:nasa_clean_arch/core/utils/converters/date_to_string_converter.dart';
import 'package:nasa_clean_arch/core/utils/keys/nasa_api_keys.dart';
import 'package:nasa_clean_arch/features/data/datasource/endpoints/nasa_endpoints.dart';
import 'package:nasa_clean_arch/features/data/datasource/space_media_datasource.dart';
import 'package:nasa_clean_arch/features/data/models/space_media_model.dart';

class NasaDataSourceImplementation implements ISpaceMediaDataSource {
  final HttpClient client;

  NasaDataSourceImplementation(this.client);

  @override
  Future<SpaceMediaModel> getSpaceMediaFromDate(DateTime date) async {
    final response = await client.get(NasaEndpoints.apod(
        NasaApiKeys.apiKey, DateToStringConverter.convert(date)));
    if (response.statusCode == 200) {
      return SpaceMediaModel.fromJson(jsonDecode(response.data));
    } else {
      throw ServerException();
    }
  }
}
