import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:organizer/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:organizer/core/injection/injection_container.dart' as di;
import '../bloc/folder_bloc.dart';
import 'package:organizer/features/notes_management/domain/repositories/folder_repository.dart';
import '../widgets/folder_form_dialog.dart';
import '../widgets/folders_grid.dart';

class NotesHomePage extends StatelessWidget {
  const NotesHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = (context.read<AuthBloc>().state as AuthAuthenticated).user;

    return BlocProvider(
      create: (context) => FolderBloc(
        folderRepository: di.sl<FolderRepository>(),
        userId: user.id,
        parentId: null,
      )..add(const LoadFoldersByParentId(parentId: null)),
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
          child: BlocBuilder<FolderBloc, FolderState>(
            builder: (context, state) {
              return switch (state) {
                FolderLoading() => _buildLoadingState(context),
                FolderLoaded() => _buildLoadedState(context, state),
                FolderError() => _buildErrorState(context, state),
              };
            },
          ),
        ),
        floatingActionButton: Builder(
          builder: (context) {
            return FloatingActionButton(
              onPressed: () {
                // Get the FolderBloc from the current context and provide it to the dialog
                final folderBloc = context.read<FolderBloc>();
                showDialog(
                  context: context,
                  builder: (dialogContext) => BlocProvider.value(
                    value: folderBloc,
                    child: const FolderFormDialog(parentId: null),
                  ),
                );
              },
              child: const Icon(Icons.add),
            );
          },
        ),
      ),
    );
  }

  Widget _buildLoadingState(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildErrorState(BuildContext context, FolderError state) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 48, color: Colors.red.shade300),
          const SizedBox(height: 16),
          Text(
            'Error loading folders',
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
              context.read<FolderBloc>().add(
                const LoadFoldersByParentId(parentId: null),
              );
            },
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadedState(BuildContext context, FolderLoaded state) {
    final folders = state.folders;

    if (folders.isEmpty) {
      return _buildEmptyState(context);
    }

    return FoldersGrid(folders: folders);
  }

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
