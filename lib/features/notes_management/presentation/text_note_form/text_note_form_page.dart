import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../note/bloc/note_form_bloc.dart';
import 'widgets/text_note_form.dart';

/// Page for creating or editing plain text notes only.
/// Not used in navigation yet; provide [NoteFormBloc] when pushing.
class TextNoteFormPage extends StatelessWidget {
  const TextNoteFormPage({super.key, this.folderId});

  final String? folderId;

  @override
  Widget build(BuildContext context) {
    return BlocListener<NoteFormBloc, NoteFormState>(
      listener: (context, state) {
        if (state is NoteFormSuccess) {
          Navigator.of(context).pop();
        }
        if (state is NoteFormError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to save note: ${state.message}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Plain text note'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: SafeArea(child: TextNoteForm(folderId: folderId)),
      ),
    );
  }
}
