import 'package:freezed_annotation/freezed_annotation.dart';
import 'todo_task.dart';

part 'note.freezed.dart';

enum NoteType { text, todo, list }

@freezed
sealed class Note with _$Note {
  const Note._();

  NoteType get type => switch (this) {
    TextNote() => NoteType.text,
    TodoNote() => NoteType.todo,
    ListNote() => NoteType.list,
  };

  const factory Note.text({
    required String id,
    required String name,
    String? folderId,
    required String userId,
    required DateTime createdAt,
    required String content,
  }) = TextNote;

  const factory Note.todo({
    required String id,
    required String name,
    String? folderId,
    required String userId,
    required DateTime createdAt,
    required List<TodoTask> tasks,
  }) = TodoNote;

  const factory Note.list({
    required String id,
    required String name,
    String? folderId,
    required String userId,
    required DateTime createdAt,
    required List<String> items,
  }) = ListNote;
}
