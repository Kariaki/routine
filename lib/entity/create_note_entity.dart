import 'package:routine/dto/note_dto.dart';

class CreateNoteEntity {
  final String title;
  final List<String> task;

  const CreateNoteEntity({required this.title, required this.task});

  factory CreateNoteEntity.fromJson(Map<String, dynamic> json) {
    return CreateNoteEntity(
      title: json['title'] as String,
      task: List<String>.from(json['task'] as List),
    );
  }

  NoteDto toNoteDto(String id) {
    return NoteDto(
      title: title,
      id: id,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      tasks: List.generate(
        task.length,
        (index) => TaskDto(title: task[index], completed: false, id: index),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {'title': title, 'task': task};
  }
}
