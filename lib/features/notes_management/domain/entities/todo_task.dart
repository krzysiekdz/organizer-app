import 'package:equatable/equatable.dart';

class TodoTask extends Equatable {
  final String task;
  final bool isDone;

  const TodoTask({
    required this.task,
    required this.isDone,
  });

  @override
  List<Object?> get props => [task, isDone];
}

