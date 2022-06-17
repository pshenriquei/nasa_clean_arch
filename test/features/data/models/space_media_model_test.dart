import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:nasa_clean_arch/features/data/models/space_media_model.dart';
import 'package:nasa_clean_arch/features/domain/entities/space_media_entity.dart';

import '../../../mocks/space_media_mock.dart';

void main() {
  final tSpaceMediaModel = SpaceMediaModel(
    description: 'test description',
    mediaType: 'image',
    title: 'test title',
    mediaUrl: 'https://test.media.url.com',
  );

  test('Should be a subclass of SpaceMediaEntity', () {
    expect(tSpaceMediaModel, isA<SpaceMediaEntity>());
  });

  test('Should return a valid model', () {
    final Map<String, dynamic> jsonMap = json.decode(spaceMediaMock);
    final result = SpaceMediaModel.fromJson(jsonMap);
    expect(result, tSpaceMediaModel);
  });

  test('Should return a jsonMap containing the proper data', () {
    final expectedMap = {
      "explanation": "test description",
      "media_type": "image",
      "title": "test title",
      "url": "https://test.media.url.com"
    };
    final result = tSpaceMediaModel.toJson();
    expect(result, expectedMap);
  });
}
