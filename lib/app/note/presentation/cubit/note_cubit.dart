import 'dart:convert';

import 'package:routine/app/note/data/dto/note_dto.dart';
import 'package:routine/app/note/domain/repositories/note_repository.dart';
import 'package:routine/core/util/storage_keys.dart';
import 'package:routine/src/service/secured_storage_service.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/util/base_cubit.dart';
import '../../../../core/util/cubit_state.dart';
import '../../../../src/di/injectable.dart';
import '../../../auth/data/dto/user_dto.dart';

class NoteCubit extends BaseCubit<List<NoteDto>> {
  NoteCubit() : super(InitialState(data: [])) {
    _noteRepository = getIt.get<NoteRepository>(
      instanceName: DependencyNames.firebase.name,
    );
    _storageService = getIt<SecureStorageService>();
  }

  late NoteRepository _noteRepository;
  late SecureStorageService _storageService;

  void fetchNotes() async {
    final userId = await _getUserId();
    if (userId == null) {
      return;
    }
    _noteRepository.getAllNoteStream(userId).listen((result) {
      emit(SuccessState(data: result));
    });
  }

  Future<String?> _getUserId() async {
    final result = await _storageService.get(StorageKeys.userDetails);
    if (result != null) {
      return UserModel.fromJson(jsonDecode(result)).userId;
    }
    return null;
  }

  void saveNote(NoteDto note) async {
    final userId = await _getUserId();
    if (userId == null) {
      return;
    }
    if (note.id == null) {
      _noteRepository.createNote(note, userId);
    } else {
      _noteRepository.updateNote(note, userId);
    }
  }

  void deleteNoteById(String id) async {
    final userId = await _getUserId();
    if (userId == null) {
      return;
    }
    _noteRepository.deleteNoteById(id, userId);
  }
}
