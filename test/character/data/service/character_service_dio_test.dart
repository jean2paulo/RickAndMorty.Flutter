import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rick_and_morty/character/data/service/character_service_dio.dart';

void main() {
  group('character service status ok', () {
    late Dio client;
    late CharacterDioService service;

    setUp(() async {
      client = DioMock();
      service = CharacterDioServiceImpl(client);
    });

    test(
        'GIVEN http client '
        'WHEN request characters at first page '
        'THEN get valid answer', () async {
      //GIVEN
      final response = ResponseMock();
      final dynamic dynamicResponse = {
        'results': [],
        'info': {
          'count': 919,
          'pages': 2,
          'next': null,
          'prev': null,
        }
      };

      //WHEN
      when(() => response.statusCode).thenReturn(200);
      when(() => response.data).thenReturn(dynamicResponse);
      when(() => client.get('character', queryParameters: {'page': '1'}))
          .thenAnswer((_) async => response);

      //THEN
      final result = await service.getCharacters();
      expect(result.info.count, 919);
    });
  });

  group('character service status invalid', () {
    late Dio client;
    late CharacterDioService service;

    setUp(() async {
      client = DioMock();
      service = CharacterDioServiceImpl(client);
    });

    test(
        'GIVEN http client '
        'WHEN request characters at first page '
        'THEN get 404 and exception', () async {
      //GIVEN
      final response = ResponseMock();

      //WHEN
      when(() => response.statusCode).thenReturn(404);
      when(() => client.get('character', queryParameters: {'page': '1'}))
          .thenAnswer((_) async => response);

      //THEN
      expect(() => service.getCharacters(), throwsA(isA<HttpException>()));
    });
  });
}

class DioMock extends Mock implements Dio {}

class ResponseMock extends Mock implements Response<dynamic> {}
