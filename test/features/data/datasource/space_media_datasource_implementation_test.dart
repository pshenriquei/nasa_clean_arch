import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nasa_clean_arch/core/http_client/http_client.dart';
import 'package:nasa_clean_arch/core/usecase/erros/exceptions.dart';
import 'package:nasa_clean_arch/core/utils/converters/date_to_string_converter.dart';
import 'package:nasa_clean_arch/features/data/datasource/space_media_datasource.dart';
import 'package:nasa_clean_arch/features/data/datasource/space_media_datasource_implementation.dart';
import 'package:nasa_clean_arch/features/data/models/space_media_model.dart';

import '../../../mocks/space_media_mock.dart';

class HttpClientMock extends Mock implements HttpClient {}

void main() {
  late ISpaceMediaDataSource dataSource;
  late HttpClient client;

  setUp(() {
    client = HttpClientMock();
    dataSource = NasaDataSourceImplementation(client);
  });

  final tDateTime = DateTime(2022, 06, 15);
  final urlExpected =
      'https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY&date=2022-06-15';
  DateToStringConverter.convert(tDateTime);

  void sucessMock() {
    when(() => client.get(any())).thenAnswer(
        (_) async => HttpResponse(data: spaceMediaMock, statusCode: 200));
  }

  test('Should call the get method  with correct URL ', () async {
    sucessMock();
    await dataSource.getSpaceMediaFromDate(tDateTime);
    verify(() => client.get(urlExpected)).called(1);
  });

  test('Should return SpaceMediaModel when is sucessful', () async {
    sucessMock();
    final tSpaceMediaModelExpected = SpaceMediaModel(
        description: "test description",
        mediaType: "image",
        title: "test title",
        mediaUrl: "https://test.media.url.com");
    final result = await dataSource.getSpaceMediaFromDate(tDateTime);
    expect(result, tSpaceMediaModelExpected);
  });

  test('Should throw a ServerException when the call is unccessful', () async {
    when(() => client.get(any())).thenAnswer((_) async =>
        HttpResponse(data: 'something went wrong', statusCode: 400));
    final result = dataSource.getSpaceMediaFromDate(tDateTime);
    expect(() => result, throwsA(ServerException()));
  });
}
