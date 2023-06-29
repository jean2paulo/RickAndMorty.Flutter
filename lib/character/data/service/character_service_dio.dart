import 'dart:io';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:rick_and_morty/character/data/service/character_response.dart';

abstract class CharacterDioService {
  Future<CharacterApiResponse> getCharacters([int page = 1]);
}

@Injectable(as: CharacterDioService)
class CharacterDioServiceImpl implements CharacterDioService {
  const CharacterDioServiceImpl(this._client);

  final Dio _client;

  @override
  Future<CharacterApiResponse> getCharacters([int page = 1]) async {
    final response = await _client.get(
      'character',
      queryParameters: {'page': '$page'},
    );

    if (response.statusCode == 200) {
      return CharacterApiResponse.fromJson(response.data);
    }

    throw HttpException('Fail to get characters at page $page');
  }
}
