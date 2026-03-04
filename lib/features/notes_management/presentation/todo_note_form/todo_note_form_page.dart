import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../note/bloc/note_form_bloc.dart';
import 'widgets/note_form_todo.dart';

/// Page for creating or editing todo notes only.
/// Provide [NoteFormBloc] when pushing.
class TodoNoteFormPage extends StatelessWidget {
  const TodoNoteFormPage({super.key, this.folderId});

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
          title: const Text('Todo note'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: SafeArea(child: NoteFormTodo(folderId: folderId)),
      ),
    );
  }
}
