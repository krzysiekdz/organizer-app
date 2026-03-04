import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organizer/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:organizer/core/injection/injection_container.dart' as di;
import 'package:organizer/features/notes_management/presentation/folder_content/widgets/fab_add_new_alt.dart'
    show FabAddNewItemAlt;
import 'bloc/folder_bloc.dart';
import 'package:organizer/features/notes_management/domain/repositories/folder_repository.dart';
import 'package:organizer/features/notes_management/domain/repositories/note_repository.dart';
import 'widgets/folder_content_grid.dart';

class NotesHomePage extends StatelessWidget {
  const NotesHomePage({super.key, this.folderId});

  final String? folderId;

  @override
  Widget build(BuildContext context) {
    final user = (context.read<AuthBloc>().state as AuthAuthenticated).user;

    return BlocProvider(
      create: (context) => FolderContentBloc(
        folderRepository: di.sl<FolderRepository>(),
        noteRepository: di.sl<NoteRepository>(),
        userId: user.id,
        folderId: folderId,
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('My Notes'),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                context.read<AuthBloc>().add(const SignOutRequested());
              },
            ),
          ],
        ),
        body: SafeArea(
          child: BlocBuilder<FolderContentBloc, FolderContentState>(
            builder: (context, state) {
              return switch (state) {
                FolderContentLoading() => _buildLoadingState(context),
                FolderContentLoaded() => _buildLoadedState(context, state),
                FolderContentLoadError() => _buildErrorState(context, state),
                FolderContentDeleteError() => SizedBox.shrink(),
              };
            },
          ),
        ),
        floatingActionButton: FabAddNewItemAlt(
          userId: user.id,
          folderId: folderId,
        ),
      ),
    );
  }

  Widget _buildLoadingState(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildErrorState(BuildContext context, FolderContentLoadError state) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 48, color: Colors.red.shade300),
          const SizedBox(height: 16),
          Text(
            'An error occurred',
            style: TextStyle(color: Colors.red.shade700),
          ),
          const SizedBox(height: 8),
          Text(
            state.message,
            style: TextStyle(color: Colors.red.shade500, fontSize: 12),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              context.read<FolderContentBloc>().add(
                const RefreshFolderContent(),
              );
            },
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadedState(BuildContext context, FolderContentLoaded state) {
    final items = state.content;

    if (items.isEmpty) {
      return _buildEmptyState(context);
    }

    return FolderContentGrid(
      items: [...items, null],
    ); //null to placeholder for empty space
  }

  //zrobic jako osobny widget
  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.folder_outlined, size: 64, color: Colors.grey.shade400),
          const SizedBox(height: 16),
          Text(
            'No folders yet',
            style: TextStyle(fontSize: 18, color: Colors.grey.shade600),
          ),
          const SizedBox(height: 8),
          Text(
            'Create your first folder to get started',
            style: TextStyle(fontSize: 14, color: Colors.grey.shade500),
          ),
        ],
      ),
    );
  }
}
