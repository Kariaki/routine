// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:routine/repositories/note_repository.dart' as _i664;
import 'package:routine/service/secured_storage_service.dart' as _i814;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.lazySingleton<_i814.SecureStorageService>(
      () => _i814.SecureStorageService(),
    );
    gh.lazySingleton<_i664.NoteRepository>(
      () => _i664.InMemoryNoteRepository(),
      instanceName: 'memory',
    );
    gh.lazySingleton<_i664.NoteRepository>(
      () => _i664.FirebaseNoteRepository(),
      instanceName: 'firebase',
    );
    return this;
  }
}
