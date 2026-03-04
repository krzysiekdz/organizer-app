import 'package:flutter/material.dart';
import 'package:organizer/features/notes_management/domain/entities/folder.dart'
    show Folder;

class FolderCard extends StatelessWidget {
  const FolderCard({super.key, required this.folder});

  final Folder folder;

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
          // TODO: Navigate to folder contents
        },
        borderRadius: BorderRadius.circular(borderRadius),
        child: Padding(
          padding: const EdgeInsets.all(padding),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.folder, size: 48, color: Colors.blue.shade400),
              const SizedBox(height: 4),
              Text(
                folder.name,
                style: const TextStyle(
                  fontSize: 12,
                  // fontWeight: FontWeight.w500,
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
