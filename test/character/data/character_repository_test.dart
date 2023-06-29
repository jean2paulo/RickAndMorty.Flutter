import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rick_and_morty/character/data/character_repository.dart';
import 'package:rick_and_morty/character/data/service/character_response.dart';
import 'package:rick_and_morty/character/data/service/character_service_dio.dart';

void main() {
  group('character repository tests', () {
    late CharacterDioService service;
    late CharacterRepository repository;

    setUp(() {
      service = CharacterDioServiceMock();
      repository = CharacterRepositoryImpl(service);
    });

    test(
        'GIVEN a service '
        'WHEN request api data at first page '
        'THEN get api response', () async {
      final mock = CharacterApiResponseMock();
      when(() => service.getCharacters()).thenAnswer((_) async => mock);
      expect(await repository.getCharacters(1), mock);
    });
  });
}

class CharacterDioServiceMock extends Mock implements CharacterDioService {}

class CharacterApiResponseMock extends Mock implements CharacterApiResponse {}
