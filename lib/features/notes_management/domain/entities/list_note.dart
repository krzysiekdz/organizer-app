import 'note.dart';

class ListNote extends Note {
  final List<String> items;

  const ListNote({
    required super.id,
    required super.name,
    super.folderId,
    required super.userId,
    required super.createdAt,
    required this.items,
  }) : super(type: NoteType.list);

  @override
  List<Object?> get props => [...super.props, items];
}

