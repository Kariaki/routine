import 'package:firebase_database/firebase_database.dart';
import 'package:injectable/injectable.dart';
import 'package:routine/app/note/data/dto/note_dto.dart';
import 'package:routine/core/util/result_wrapper.dart';

abstract class NoteRepository {
  Future<ApiResult<NoteDto>> createNote(NoteDto entity, String userId);

  Future<ApiResult<NoteDto>> updateNote(NoteDto dto, String userId);

  Future<ApiResult<dynamic>> deleteNoteById(String id, String userId);

  Future<ApiResult<List<NoteDto>>> getAllNotes();

  Stream<List<NoteDto>> getAllNoteStream(String userId);
}

@LazySingleton(as: NoteRepository)
@Named("firebase")
class FirebaseNoteRepository implements NoteRepository {
  final _database = FirebaseDatabase.instance.ref('users');

  @override
  Future<ApiResult<NoteDto>> createNote(NoteDto dto, String userId) =>
      ApiResultWrapper.wrap<NoteDto>(
        func: () async {
          final note = dto.copyWith(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          );
          await _database
              .child(userId)
              .child('notes')
              .child(note.id ?? '')
              .set(note.toJson());
          return note;
        },
      );

  @override
  Future<ApiResult<void>> deleteNoteById(String id, String userId) =>
      ApiResultWrapper.wrap(
        func: () => _database.child(userId).child('notes').child(id).remove(),
      );

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
  Future<ApiResult<NoteDto>> updateNote(NoteDto dto, String userId) =>
      ApiResultWrapper.wrap(
        func: () async {
          await _database
              .child(userId)
              .child('notes')
              .child(dto.id ?? '')
              .set(dto.copyWith(updatedAt: DateTime.now()).toJson());
          return dto;
        },
      );

  @override
  Stream<List<NoteDto>> getAllNoteStream(String userId) {
    return _database.child(userId).child('notes').onValue.map((e) {
      return e.snapshot.children.map((value) {
        return NoteDto.fromJson(Map<dynamic, dynamic>.from(value.value as Map));
      }).toList();
    });
  }
}
