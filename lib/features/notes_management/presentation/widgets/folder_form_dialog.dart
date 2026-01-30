import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/folder_bloc.dart';

class FolderFormDialog extends StatefulWidget {
  final String? parentId;

  const FolderFormDialog({super.key, this.parentId});

  @override
  State<FolderFormDialog> createState() => _FolderFormDialogState();
}

class _FolderFormDialogState extends State<FolderFormDialog> {
  final _formKey = GlobalKey<FormState>();
  // Option 1: Using TextEditingController (current approach)
  // Good when you need to programmatically manipulate the field
  final _nameController = TextEditingController();

  // Option 2: Using state variable (alternative, simpler for single field)
  // String _folderName = '';
  //
  // void _updateFolderName(String value) {
  //   setState(() => _folderName = value);
  // }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text.trim();
      // With state variable: final name = _folderName.trim();

      if (name.isNotEmpty) {
        context.read<FolderBloc>().add(
          CreateFolder(name: name, parentId: widget.parentId),
        );
        // Don't close immediately - let BLoC listener handle it
        // This allows showing loading/error states if needed
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<FolderBloc, FolderState>(
      listener: (context, state) {
        // Close dialog when folders are reloaded (after successful creation)
        if (state is FolderLoaded) {
          Navigator.of(context).pop();
        }
        // Show error snackbar if creation fails
        if (state is FolderError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to create folder: ${state.message}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: AlertDialog(
        title: const Text('Create New Folder'),
        content: Form(
          key: _formKey,
          // Use autovalidateMode for better UX (shows errors as user types)
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: TextFormField(
            controller: _nameController,
            // Alternative with state variable (simpler for single field):
            // value: _folderName,
            // onChanged: _updateFolderName,
            decoration: const InputDecoration(
              labelText: 'Folder Name',
              hintText: 'Enter folder name',
              border: OutlineInputBorder(),
              // Add prefix icon for better UX
              prefixIcon: Icon(Icons.folder_outlined),
            ),
            autofocus: true,
            textCapitalization: TextCapitalization.words,
            // Better keyboard action
            textInputAction: TextInputAction.done,
            // Max length to prevent extremely long names
            maxLength: 20,
            // buildCounter:
            //     (
            //       context, {
            //       required currentLength,
            //       required isFocused,
            //       maxLength,
            //     }) => Text('$currentLength/$maxLength'),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter a folder name';
              }
              // Additional validation: check for whitespace-only names
              if (value.trim().length < 1) {
                return 'Folder name cannot be empty';
              }
              // Optional: check for invalid characters
              if (value.contains('  ')) {
                return 'Folder name cannot contain consecutive spaces';
              }
              return null;
            },
            onFieldSubmitted: (_) => _submit(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          BlocBuilder<FolderBloc, FolderState>(
            builder: (context, state) {
              // Show loading when folders are being reloaded after creation
              final isLoading = state is FolderLoading;
              return ElevatedButton(
                onPressed: isLoading ? null : _submit,
                child: isLoading
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Create'),
              );
            },
          ),
        ],
      ),
    );
  }
}
