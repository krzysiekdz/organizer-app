import '../../domain/entities/todo_task.dart';

class TodoTaskModel {
  TodoTaskModel._();

  static TodoTask fromFirestore(Map<String, dynamic> data) {
    return TodoTask(
      task: data['task'] as String,
      isDone: data['isDone'] as bool,
    );
  }

  static Map<String, dynamic> toFirestore(TodoTask task) {
    return {
      'task': task.task,
      'isDone': task.isDone,
    };
  }
}
