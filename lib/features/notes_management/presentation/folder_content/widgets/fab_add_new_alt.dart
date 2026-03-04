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
class FabAddNewItemAlt extends StatelessWidget {
  const FabAddNewItemAlt({super.key, required this.userId, this.folderId});

  final String userId;
  final String? folderId;

  static const double _fabBottom = 16.0;
  static const double _fabRight = 16.0;
  // static const double _fabHeight = 56.0;
  // static const double _overlayGap = 16.0;
  static const double _buttonPadding = 16.0;
  static const double _buttonSpacing = 16.0;
  static const int _buttonCount = 4;
  static const int _staggerDelayMs = 100;
  static const int _staggerFadeMs = 100;

  void _showNewItemMenu(BuildContext context) {
    final overlayKey = GlobalKey<_StaggeredButtonOverlayState>();
    showGeneralDialog<void>(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black54,
      barrierLabel: 'Dismiss',
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
      pageBuilder: (dialogContext, animation, secondaryAnimation) {
        return PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, result) {
            if (!didPop) {
              overlayKey.currentState?.closeOverlay();
            }
          },
          child: SafeArea(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned.fill(
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => overlayKey.currentState?.closeOverlay(),
                  ),
                ),
                Positioned(
                  right: _fabRight,
                  // bottom: _fabBottom + _fabHeight + _overlayGap,
                  bottom: _fabBottom,
                  child: _StaggeredButtonOverlay(
                    key: overlayKey,
                    staggerDelayMs: _staggerDelayMs,
                    staggerFadeMs: _staggerFadeMs,
                    buttonCount: _buttonCount,
                    buttonPadding: _buttonPadding,
                    buttonSpacing: _buttonSpacing,
                    onClose: () => Navigator.of(dialogContext).pop(),
                    onOpenFolder: () {
                      Navigator.of(dialogContext).pop();
                      _openFolderForm(context);
                    },
                    onOpenTextNote: () {
                      Navigator.of(dialogContext).pop();
                      _openTextNoteForm(context);
                    },
                    onOpenTodoNote: () {
                      Navigator.of(dialogContext).pop();
                      _openTodoNoteForm(context);
                    },
                    onOpenListNote: () {
                      Navigator.of(dialogContext).pop();
                      _openListNoteForm(context);
                    },
                  ),
                ),
                // Positioned(
                //   right: _fabRight,
                //   bottom: _fabBottom,
                //   child: FloatingActionButton(
                //     heroTag: 'close_overlay',
                //     onPressed: () => overlayKey.currentState?.closeOverlay(),
                //     child: const Icon(Icons.close),
                //   ),
                // ),
              ],
            ),
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
      child: const Icon(Icons.add, size: 30),
    );
  }
}

class _StaggeredButtonOverlay extends StatefulWidget {
  const _StaggeredButtonOverlay({
    super.key,
    required this.staggerDelayMs,
    required this.staggerFadeMs,
    required this.buttonCount,
    required this.buttonPadding,
    required this.buttonSpacing,
    required this.onClose,
    required this.onOpenFolder,
    required this.onOpenTextNote,
    required this.onOpenTodoNote,
    required this.onOpenListNote,
  });

  final int staggerDelayMs;
  final int staggerFadeMs;
  final int buttonCount;
  final double buttonPadding;
  final double buttonSpacing;
  final VoidCallback onClose;
  final VoidCallback onOpenFolder;
  final VoidCallback onOpenTextNote;
  final VoidCallback onOpenTodoNote;
  final VoidCallback onOpenListNote;

  @override
  State<_StaggeredButtonOverlay> createState() =>
      _StaggeredButtonOverlayState();
}

class _StaggeredButtonOverlayState extends State<_StaggeredButtonOverlay>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  int get overlayDurationMs => widget.staggerDelayMs ~/ 2;

  int get totalMs =>
      (widget.staggerDelayMs - overlayDurationMs) * widget.buttonCount +
      widget.staggerFadeMs;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: totalMs),
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void closeOverlay() {
    _controller.reverse().then((value) {
      if (!mounted) return;
      widget.onClose();
    });
  }

  Widget _staggeredEntry(int index, Widget child) {
    final startMs =
        (widget.buttonCount - index) *
        (widget.staggerDelayMs - overlayDurationMs);
    final endMs = startMs + widget.staggerFadeMs;
    final start = startMs / totalMs;
    final end = (endMs / totalMs).clamp(0.0, 1.0);
    final animation = CurvedAnimation(
      parent: _controller,
      curve: Interval(start, end, curve: Curves.easeOut),
    );
    return FadeTransition(
      opacity: animation,
      child: ScaleTransition(
        scale: animation,
        alignment: Alignment.centerRight,
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final p = widget.buttonPadding;
    final s = widget.buttonSpacing;
    return Material(
      color: Colors.transparent,
      elevation: 0,
      child: IntrinsicWidth(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            _staggeredEntry(
              0,
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(padding: EdgeInsets.all(p)),
                onPressed: widget.onOpenFolder,
                icon: const Icon(Icons.folder_outlined, size: 20),
                label: const Text('Folder'),
              ),
            ),
            SizedBox(height: s),
            _staggeredEntry(
              1,
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(padding: EdgeInsets.all(p)),
                onPressed: widget.onOpenTextNote,
                icon: const Icon(Icons.note_outlined, size: 20),
                label: const Text('Text note'),
              ),
            ),
            SizedBox(height: s),
            _staggeredEntry(
              2,
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(padding: EdgeInsets.all(p)),
                onPressed: widget.onOpenTodoNote,
                icon: const Icon(Icons.check_box_outlined, size: 20),
                label: const Text('Todo note'),
              ),
            ),
            SizedBox(height: s),
            _staggeredEntry(
              3,
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(padding: EdgeInsets.all(p)),
                onPressed: widget.onOpenListNote,
                icon: const Icon(Icons.format_list_bulleted, size: 20),
                label: const Text('List note'),
              ),
            ),
            SizedBox(height: s),
            FloatingActionButton(
              heroTag: 'close_overlay',
              onPressed: closeOverlay,
              child: RotationTransition(
                turns: Tween<double>(begin: 0, end: 0.125).animate(
                  CurvedAnimation(
                    parent: _controller,
                    curve: Interval(0, 0.5, curve: Curves.easeIn),
                  ),
                ),
                child: const Icon(Icons.add, size: 30),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
