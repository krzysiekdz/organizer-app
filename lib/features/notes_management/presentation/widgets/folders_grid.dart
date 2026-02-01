import 'package:flutter/material.dart';
import 'package:organizer/features/notes_management/domain/entities/folder.dart';
import 'folder_card.dart';

class FoldersGrid extends StatelessWidget {
  const FoldersGrid({super.key, required this.folders});

  final List<Folder> folders;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = constraints.maxWidth ~/ 120;
        const spacing = 8.0;
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
              crossAxisAlignment: WrapCrossAlignment.center,
              children: folders
                  .map(
                    (folder) => SizedBox(
                      width: itemWidth,
                      child: FolderCard(folder: folder),
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
