import 'package:flutter/material.dart';
import 'package:organizer/features/notes_management/domain/entities/folder.dart';
import 'package:organizer/features/notes_management/domain/entities/note.dart'
    show Note;
import 'note_card.dart' show NoteCard;
import 'folder_card_alt.dart' show FolderCardAlt;
// import 'folder_card.dart';

class FolderContentGrid extends StatelessWidget {
  const FolderContentGrid({super.key, required this.items});

  final List<dynamic> items;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final divideBy = 100;
        final crossAxisCount = constraints.maxWidth ~/ divideBy;
        const spacing = 4.0;
        const padding = 8.0;
        final width =
            constraints.maxWidth - padding * 2 - spacing * (crossAxisCount - 1);
        final itemWidth = width / crossAxisCount;

        return SingleChildScrollView(
          padding: const EdgeInsets.all(padding),
          child: SizedBox(
            width: constraints.maxWidth,
            child: Wrap(
              spacing: spacing,
              runSpacing: spacing,
              // crossAxisAlignment: WrapCrossAlignment.center,
              children: items
                  .map(
                    (item) => SizedBox(
                      width: itemWidth,
                      child: switch (item) {
                        Folder() => FolderCardAlt(folder: item),
                        Note() => NoteCard(note: item),
                        _ => const SizedBox(width: 64, height: 64),
                      },
                    ),
                  )
                  .toList(),
            ),
          ),
        );
      },
    );
  }
}
