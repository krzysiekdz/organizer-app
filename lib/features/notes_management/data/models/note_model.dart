import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/note.dart';
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
        return Note.text(
          id: doc.id,
          name: data['name'] as String,
          folderId: data['folderId'] as String?,
          userId: data['userId'] as String,
          createdAt: (data['createdAt'] as Timestamp).toDate(),
          content: data['content'] as String? ?? '',
        );
      case NoteType.todo:
        final tasksList =
            (data['tasks'] as List<dynamic>?)
                ?.map(
                  (task) => TodoTaskModel.fromFirestore(
                    task as Map<String, dynamic>,
                  ),
                )
                .toList() ??
            [];
        return Note.todo(
          id: doc.id,
          name: data['name'] as String,
          folderId: data['folderId'] as String?,
          userId: data['userId'] as String,
          createdAt: (data['createdAt'] as Timestamp).toDate(),
          tasks: tasksList,
        );
      case NoteType.list:
        final itemsList =
            (data['items'] as List<dynamic>?)
                ?.map((item) => item as String)
                .toList() ??
            [];
        return Note.list(
          id: doc.id,
          name: data['name'] as String,
          folderId: data['folderId'] as String?,
          userId: data['userId'] as String,
          createdAt: (data['createdAt'] as Timestamp).toDate(),
          items: itemsList,
        );
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

    return note.map(
      text: (n) => {...baseData, 'content': n.content},
      todo: (n) => {
        ...baseData,
        'tasks': n.tasks
            .map((task) => TodoTaskModel.toFirestore(task))
            .toList(),
      },
      list: (n) => {...baseData, 'items': n.items},
    );
  }
}
