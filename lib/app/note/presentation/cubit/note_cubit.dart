
import 'package:routine/app/note/data/dto/note_dto.dart';
import 'package:routine/app/note/domain/repositories/note_repository.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/util/base_cubit.dart';
import '../../../../core/util/cubit_state.dart';
import '../../../../src/di/injectable.dart';

class NoteCubit extends BaseCubit<List<NoteDto>> {
  NoteCubit() : super(InitialState(data: [])) {
    _noteRepository = getIt.get<NoteRepository>(
      instanceName: DependencyNames.firebase.name,
    );
  }

  late NoteRepository _noteRepository;

  void fetchNotes() {
    _noteRepository.getAllNoteStream().listen((result) {
      emit(SuccessState(data: result));
    });
  }

  void saveNote(NoteDto note) {
    if (note.id == null) {
      _noteRepository.createNote(note);
    } else {
      _noteRepository.updateNote(note);
    }
  }

  void deleteNoteById(String id) {
    _noteRepository.deleteNoteById(id);
  }
}
