import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/note.dart';
import '../bloc/note_form/note_form_bloc.dart';

class NoteFormPlain extends StatefulWidget {
  final String? folderId;
  final int maxNameLength = 80;
  final int maxContentLength = 10000;

  const NoteFormPlain({super.key, this.folderId});

  @override
  State<NoteFormPlain> createState() => _NoteFormPlainState();
}

class _NoteFormPlainState extends State<NoteFormPlain> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _contentController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final note = Note.text(
        id: '',
        name: _nameController.text.trim(),
        folderId: widget.folderId,
        userId: '',
        createdAt: DateTime.now(),
        content: _contentController.text,
      );
      context.read<NoteFormBloc>().add(CreateNoteSubmitted(note: note));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Title',
                hintText: 'Note title',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.title),
              ),
              textCapitalization: TextCapitalization.sentences,
              maxLength: widget.maxNameLength,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter a title';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _contentController,
              decoration: const InputDecoration(
                labelText: 'Content',
                hintText: 'Write your note...',
                border: OutlineInputBorder(),
                alignLabelWithHint: true,
              ),
              maxLines: 12,
              maxLength: widget.maxContentLength,
            ),
            const SizedBox(height: 24),
            BlocBuilder<NoteFormBloc, NoteFormState>(
              builder: (context, state) {
                final isLoading = state is NoteFormLoading;
                return FilledButton.icon(
                  onPressed: isLoading ? null : _submit,
                  icon: isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.save),
                  label: const Text('Save'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
