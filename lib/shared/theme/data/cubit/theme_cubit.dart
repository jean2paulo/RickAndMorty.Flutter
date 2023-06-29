import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:rick_and_morty/shared/theme/application_theme.dart';

import '../app_theme_repository.dart';

@injectable
class ThemeCubit extends Cubit<String> {
  ThemeCubit(this._repository) : super(_repository.theme ?? '');

  final AppThemeRepository _repository;

  void changeTheme(String themeName) {
    _repository.changeTheme(themeName);
    emit(themeName);
  }
}
