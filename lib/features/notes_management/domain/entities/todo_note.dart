import 'note.dart';
import 'todo_task.dart';

class TodoNote extends Note {
  final List<TodoTask> tasks;

  const TodoNote({
    required super.id,
    required super.name,
    super.folderId,
    required super.userId,
    required super.createdAt,
    required this.tasks,
  }) : super(type: NoteType.todo);

  @override
  List<Object?> get props => [...super.props, tasks];
}

