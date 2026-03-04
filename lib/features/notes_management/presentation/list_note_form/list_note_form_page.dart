import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../note/bloc/note_form_bloc.dart';
import 'widgets/list_note_form.dart';

/// Page for creating or editing list notes only.
/// Provide [NoteFormBloc] when pushing.
class ListNoteFormPage extends StatelessWidget {
  const ListNoteFormPage({super.key, this.folderId});

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
          title: const Text('List note'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: SafeArea(child: ListNoteForm(folderId: folderId)),
      ),
    );
  }
}
