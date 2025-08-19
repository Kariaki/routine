import 'package:firebase_database/firebase_database.dart';
import 'package:injectable/injectable.dart';
import 'package:routine/app/note/data/dto/note_dto.dart';
import 'package:routine/core/util/result_wrapper.dart';

abstract class NoteRepository {
  Future<ApiResult<NoteDto>> createNote(NoteDto entity);

  Future<ApiResult<NoteDto>> updateNote(NoteDto dto);

  Future<ApiResult<dynamic>> deleteNoteById(String id);

  Future<ApiResult<List<NoteDto>>> getAllNotes();

  Stream<List<NoteDto>> getAllNoteStream();
}

@LazySingleton(as: NoteRepository)
@Named("memory")
class InMemoryNoteRepository implements NoteRepository {
  final List<NoteDto> _notes = [];
  int _taskIdCounter = 0;

  @override
  Future<ApiResult<NoteDto>> createNote(NoteDto entity) async {
    return ApiResultWrapper.wrap(
      func: () async {
        final note = NoteDto(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          // simple unique id
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          title: entity.title,
          tasks: entity.tasks,
        );

        _notes.add(note);
        return note;
      },
    );
  }

  @override
  Future<ApiResult<NoteDto>> updateNote(NoteDto dto) async {
    return ApiResultWrapper.wrap(
      func: () async {
        final index = _notes.indexWhere((n) => n.id == dto.id);
        if (index == -1) {
          throw Exception('Note with id ${dto.id} not found');
        }
        _notes[index] = dto;
        return dto;
      },
    );
  }

  @override
  Future<ApiResult<dynamic>> deleteNoteById(String id) async {
    _notes.removeWhere((n) => n.id == id);
    return Success(data: null);
  }

  @override
  Future<ApiResult<List<NoteDto>>> getAllNotes() async {
    return Success(data: List.unmodifiable(_notes));
  }

  @override
  Stream<List<NoteDto>> getAllNoteStream() {
    // TODO: implement getAllNoteStream
    throw UnimplementedError();
  }
}

@LazySingleton(as: NoteRepository)
@Named("firebase")
class FirebaseNoteRepository implements NoteRepository {
  final _database = FirebaseDatabase.instance.ref('notes');

  @override
  Future<ApiResult<NoteDto>> createNote(NoteDto dto) =>
      ApiResultWrapper.wrap<NoteDto>(
        func: () async {
          final note = dto.copyWith(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          );
          await _database.child(note.id ?? '').set(note.toJson());
          return note;
        },
      );

  @override
  Future<ApiResult<void>> deleteNoteById(String id) =>
      ApiResultWrapper.wrap(func: () => _database.child(id).remove());

  @override
  Future<ApiResult<List<NoteDto>>> getAllNotes() => ApiResultWrapper.wrap(
    func: () async {
      final snapshot = await _database.get();
      if (!snapshot.exists) {
        return [];
      }
      return snapshot.children.map((snapshot) {
        return NoteDto.fromJson(snapshot.value! as Map<dynamic, dynamic>);
      }).toList();
    },
  );

  @override
  Future<ApiResult<NoteDto>> updateNote(NoteDto dto) => ApiResultWrapper.wrap(
    func: () async {
      await _database
          .child(dto.id ?? '')
          .set(dto.copyWith(updatedAt: DateTime.now()).toJson());
      return dto;
    },
  );

  @override
  Stream<List<NoteDto>> getAllNoteStream() {
    return _database.onValue.map((e) {
      return e.snapshot.children.map((value) {
        return NoteDto.fromJson(Map<dynamic, dynamic>.from(value.value as Map));
      }).toList();
    });
  }
}
