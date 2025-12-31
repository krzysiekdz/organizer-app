import 'note.dart';

class TextNote extends Note {
  final String content;

  const TextNote({
    required super.id,
    required super.name,
    super.folderId,
    required super.userId,
    required super.createdAt,
    required this.content,
  }) : super(type: NoteType.text);

  @override
  List<Object?> get props => [...super.props, content];
}

