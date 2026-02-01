import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/folder_bloc.dart';

class FolderFormDialog extends StatefulWidget {
  final String? parentId;
  final int maxLength = 40;

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
        contentPadding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
        content: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: TextFormField(
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: 'Folder Name',
              hintText: 'Enter folder name',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.folder_outlined),
              // Label always floats above to avoid collision with input on small screens
              floatingLabelBehavior: FloatingLabelBehavior.always,
              // Enough vertical space so label and input don't overlap
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 12,
              ),
              isDense: true,
            ),
            autofocus: true,
            // textCapitalization: TextCapitalization.words,
            textInputAction: TextInputAction.done,
            maxLength: widget.maxLength,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter a folder name';
              }
              if (value.trim().isEmpty) {
                return 'Folder name cannot be empty';
              }
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
