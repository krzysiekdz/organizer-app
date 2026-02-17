import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo_task.freezed.dart';

@freezed
sealed class TodoTask with _$TodoTask {
  const TodoTask._();

  const factory TodoTask({required String task, required bool isDone}) =
      _TodoTask;
}
