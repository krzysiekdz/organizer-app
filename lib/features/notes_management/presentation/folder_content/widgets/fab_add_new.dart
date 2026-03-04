import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organizer/core/injection/injection_container.dart' as di;
import 'package:organizer/features/notes_management/domain/repositories/folder_repository.dart';
import 'package:organizer/features/notes_management/domain/repositories/note_repository.dart';
import '../../folder_form/bloc/folder_form_bloc.dart';
import '../../folder_form/folder_form_dialog.dart';
import '../../note/bloc/note_form_bloc.dart';
import '../../list_note_form/list_note_form_page.dart';
import '../../text_note_form/text_note_form_page.dart';
import '../../todo_note_form/todo_note_form_page.dart';

/// FAB that opens a modal overlay of options anchored to the bottom-right
/// (above the FAB), with list-tile style buttons.
class FabAddNewItem extends StatelessWidget {
  const FabAddNewItem({super.key, required this.userId, this.folderId});

  final String userId;
  final String? folderId;

  static const double _fabBottom = 16.0;
  static const double _fabRight = 16.0;
  static const double _fabHeight = 56.0;
  static const double _overlayGap = 16.0;
  static const double _buttonPadding = 16.0;
  static const double _buttonSpacing = 16.0;

  void _showNewItemMenu(BuildContext context) {
    showGeneralDialog<void>(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black54,
      barrierLabel: 'Dismiss',
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
      pageBuilder: (dialogContext, animation, secondaryAnimation) {
        return SafeArea(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                right: _fabRight,
                bottom: _fabBottom + _fabHeight + _overlayGap,
                child: Material(
                  color: Colors.transparent,
                  elevation: 0,
                  child: IntrinsicWidth(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(_buttonPadding),
                          ),
                          onPressed: () {
                            Navigator.of(dialogContext).pop();
                            _openFolderForm(context);
                          },
                          icon: const Icon(Icons.folder_outlined, size: 20),
                          label: const Text('Folder'),
                        ),
                        SizedBox(height: _buttonSpacing),
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(_buttonPadding),
                          ),
                          onPressed: () {
                            Navigator.of(dialogContext).pop();
                            _openTextNoteForm(context);
                          },
                          icon: const Icon(Icons.note_outlined, size: 20),
                          label: const Text('Text note'),
                        ),
                        SizedBox(height: _buttonSpacing),
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(_buttonPadding),
                          ),
                          onPressed: () {
                            Navigator.of(dialogContext).pop();
                            _openTodoNoteForm(context);
                          },
                          icon: const Icon(Icons.check_box_outlined, size: 20),
                          label: const Text('Todo note'),
                        ),
                        SizedBox(height: _buttonSpacing),
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(_buttonPadding),
                          ),
                          onPressed: () {
                            Navigator.of(dialogContext).pop();
                            _openListNoteForm(context);
                          },
                          icon: const Icon(
                            Icons.format_list_bulleted,
                            size: 20,
                          ),
                          label: const Text('List note'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                right: _fabRight,
                bottom: _fabBottom,
                child: FloatingActionButton(
                  heroTag: 'close_overlay',
                  onPressed: () => Navigator.of(dialogContext).pop(),
                  child: const Icon(Icons.close),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _openFolderForm(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => BlocProvider(
        create: (context) => FolderFormBloc(
          folderRepository: di.sl<FolderRepository>(),
          userId: userId,
        ),
        child: FolderFormDialog(folderId: folderId),
      ),
    );
  }

  void _openTextNoteForm(BuildContext context) {
    _openNoteForm(context, TextNoteFormPage(folderId: folderId));
  }

  void _openTodoNoteForm(BuildContext context) {
    _openNoteForm(context, TodoNoteFormPage(folderId: folderId));
  }

  void _openListNoteForm(BuildContext context) {
    _openNoteForm(context, ListNoteFormPage(folderId: folderId));
  }

  void _openNoteForm(BuildContext context, Widget noteFormPage) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) => BlocProvider(
          create: (context) => NoteFormBloc(
            noteRepository: di.sl<NoteRepository>(),
            userId: userId,
          ),
          child: noteFormPage,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: '${folderId ?? 'root'}_alt',
      onPressed: () => _showNewItemMenu(context),
      child: const Icon(Icons.add),
    );
  }
}
