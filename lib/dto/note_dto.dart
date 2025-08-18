class NoteDto {
  final String title;
  final String id;
  final List<TaskDto> tasks;
  final DateTime createdAt;
  final DateTime updatedAt;

  NoteDto({
    required this.title,
    required this.id,
    required this.tasks,
    required this.createdAt,
    required this.updatedAt
  });

  factory NoteDto.fromJson(Map<dynamic, dynamic> json) {
    return NoteDto(
      title: json['title'] as String,
      createdAt: DateTime.parse(json['createdAt'] ),
      updatedAt: DateTime.parse(json['createdAt'] ),
      id: json['id'] as String,
      tasks: (json['tasks'] as List<dynamic>)
          .map((task) => TaskDto.fromJson(task as Map<dynamic, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'id': id,
      'tasks': tasks.map((task) => task.toJson()).toList(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}

class TaskDto {
  final String title;
  final bool completed;
  final int id;

  TaskDto({
    required this.title,
     this.completed=false,
    required this.id,
  });

  factory TaskDto.fromJson(Map<dynamic, dynamic> json) {
    return TaskDto(
      title: json['title'] as String,
      completed: json['completed'] as bool,
      id: json['id'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'completed': completed,
      'id': id,
    };
  }
}
