import '../../domain/entities/todo_task.dart';

class TodoTaskModel extends TodoTask {
  const TodoTaskModel({
    required super.task,
    required super.isDone,
  });

  factory TodoTaskModel.fromFirestore(Map<String, dynamic> data) {
    return TodoTaskModel(
      task: data['task'] as String,
      isDone: data['isDone'] as bool,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'task': task,
      'isDone': isDone,
    };
  }

  factory TodoTaskModel.fromEntity(TodoTask task) {
    return TodoTaskModel(
      task: task.task,
      isDone: task.isDone,
    );
  }
}

