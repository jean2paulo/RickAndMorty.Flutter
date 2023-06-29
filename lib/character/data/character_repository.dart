import 'package:injectable/injectable.dart';
import 'package:rick_and_morty/character/data/service/character_response.dart';
import 'package:rick_and_morty/character/data/service/character_service_dio.dart';

abstract class CharacterRepository {
  Future<CharacterApiResponse> getCharacters(int page);
}

@Injectable(as: CharacterRepository)
class CharacterRepositoryImpl implements CharacterRepository {
  const CharacterRepositoryImpl(this._service);

  final CharacterDioService _service;

  @override
  Future<CharacterApiResponse> getCharacters(int page) {
    return _service.getCharacters(page);
  }
}
