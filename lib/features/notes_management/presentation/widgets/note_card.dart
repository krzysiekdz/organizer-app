import 'package:flutter/material.dart';
import 'package:organizer/features/notes_management/domain/entities/note.dart'
    show Note, NoteType;

class NoteCard extends StatelessWidget {
  const NoteCard({super.key, required this.note});

  final Note note;

  IconData get _icon {
    return switch (note.type) {
      NoteType.text => Icons.text_snippet_outlined,
      NoteType.todo => Icons.check_circle_outline,
      NoteType.list => Icons.format_list_bulleted,
    };
  }

  Color get _iconColor {
    return switch (note.type) {
      NoteType.text => Colors.amber.shade600,
      NoteType.todo => Colors.green.shade600,
      NoteType.list => Colors.purple.shade600,
    };
  }

  @override
  Widget build(BuildContext context) {
    const borderRadius = 12.0;
    const padding = 4.0;
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: InkWell(
        onTap: () {
          // TODO: Navigate to note detail / edit
        },
        borderRadius: BorderRadius.circular(borderRadius),
        child: Padding(
          padding: const EdgeInsets.all(padding),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(_icon, size: 48, color: _iconColor),
              const SizedBox(height: 4),
              Text(
                note.name,
                style: const TextStyle(
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
