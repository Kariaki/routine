class NoteDto {
  final String title;
  final String? id;
  final List<TaskDto> tasks;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String userId;

  NoteDto({
    this.title = '',
    this.id,
    this.tasks = const [],
    this.createdAt,
    required this.userId,
    this.updatedAt,
  });

  NoteDto copyWith({
    String? title,
    String? id,
    List<TaskDto>? tasks,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? userId
  }) {
    return NoteDto(
      title: title ?? this.title,
      id: id ?? this.id,
      userId: userId??this.userId,
      tasks: tasks ?? this.tasks,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory NoteDto.fromJson(Map<dynamic, dynamic> json) {
    return NoteDto(
      title: json['title'] as String,
      userId: json['userId'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['createdAt']),
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
      'userId':userId,
      'tasks': tasks.map((task) => task.toJson()).toList(),
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}

class TaskDto {
  final String title;
  final bool completed;

  TaskDto({required this.title, this.completed = false, });

  factory TaskDto.fromJson(Map<dynamic, dynamic> json) {
    return TaskDto(
      title: json['title'] as String,
      completed: json['completed'] as bool,
    );
  }

  TaskDto copyWith({String? title, bool? completed, int? id}) {
    return TaskDto(
      title: title ?? this.title,
      completed: completed ?? this.completed,
    );
  }

  Map<String, dynamic> toJson() {
    return {'title': title, 'completed': completed, };
  }
}
