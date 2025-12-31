import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/note.dart';
import '../../domain/entities/text_note.dart';
import '../../domain/entities/todo_note.dart';
import '../../domain/entities/list_note.dart';
import 'todo_task_model.dart';

abstract class NoteModel {
  static Note fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    final typeString = data['type'] as String;
    final noteType = NoteType.values.firstWhere(
      (e) => e.name == typeString,
      orElse: () => NoteType.text,
    );

    switch (noteType) {
      case NoteType.text:
        return TextNoteModel.fromFirestore(doc);
      case NoteType.todo:
        return TodoNoteModel.fromFirestore(doc);
      case NoteType.list:
        return ListNoteModel.fromFirestore(doc);
    }
  }

  static Map<String, dynamic> toFirestore(Note note) {
    final baseData = {
      'name': note.name,
      'folderId': note.folderId,
      'userId': note.userId,
      'type': note.type.name,
      'createdAt': Timestamp.fromDate(note.createdAt),
    };

    if (note is TextNote) {
      baseData['content'] = note.content;
    } else if (note is TodoNote) {
      baseData['tasks'] = note.tasks
          .map((task) => TodoTaskModel.fromEntity(task).toFirestore())
          .toList();
    } else if (note is ListNote) {
      baseData['items'] = note.items;
    }

    return baseData;
  }
}

class TextNoteModel extends TextNote {
  const TextNoteModel({
    required super.id,
    required super.name,
    super.folderId,
    required super.userId,
    required super.createdAt,
    required super.content,
  });

  factory TextNoteModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return TextNoteModel(
      id: doc.id,
      name: data['name'] as String,
      folderId: data['folderId'] as String?,
      userId: data['userId'] as String,
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      content: data['content'] as String? ?? '',
    );
  }

  factory TextNoteModel.fromEntity(TextNote note) {
    return TextNoteModel(
      id: note.id,
      name: note.name,
      folderId: note.folderId,
      userId: note.userId,
      createdAt: note.createdAt,
      content: note.content,
    );
  }
}

class TodoNoteModel extends TodoNote {
  const TodoNoteModel({
    required super.id,
    required super.name,
    super.folderId,
    required super.userId,
    required super.createdAt,
    required super.tasks,
  });

  factory TodoNoteModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    final tasksList = (data['tasks'] as List<dynamic>?)
            ?.map((task) => TodoTaskModel.fromFirestore(task as Map<String, dynamic>))
            .toList() ??
        [];
    return TodoNoteModel(
      id: doc.id,
      name: data['name'] as String,
      folderId: data['folderId'] as String?,
      userId: data['userId'] as String,
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      tasks: tasksList,
    );
  }

  factory TodoNoteModel.fromEntity(TodoNote note) {
    return TodoNoteModel(
      id: note.id,
      name: note.name,
      folderId: note.folderId,
      userId: note.userId,
      createdAt: note.createdAt,
      tasks: note.tasks,
    );
  }
}

class ListNoteModel extends ListNote {
  const ListNoteModel({
    required super.id,
    required super.name,
    super.folderId,
    required super.userId,
    required super.createdAt,
    required super.items,
  });

  factory ListNoteModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    final itemsList = (data['items'] as List<dynamic>?)
            ?.map((item) => item as String)
            .toList() ??
        [];
    return ListNoteModel(
      id: doc.id,
      name: data['name'] as String,
      folderId: data['folderId'] as String?,
      userId: data['userId'] as String,
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      items: itemsList,
    );
  }

  factory ListNoteModel.fromEntity(ListNote note) {
    return ListNoteModel(
      id: note.id,
      name: note.name,
      folderId: note.folderId,
      userId: note.userId,
      createdAt: note.createdAt,
      items: note.items,
    );
  }
}

