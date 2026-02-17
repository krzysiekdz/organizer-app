import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/note.dart';
import '../bloc/note_form/note_form_bloc.dart';
import '../widgets/note_form_plain.dart';
import '../widgets/note_form_todo.dart';
import '../widgets/note_form_list.dart';

class NoteFormPage extends StatefulWidget {
  final String? folderId;

  const NoteFormPage({super.key, this.folderId});

  @override
  State<NoteFormPage> createState() => _NoteFormPageState();
}

class _NoteFormPageState extends State<NoteFormPage> {
  NoteType? _selectedType;

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
          title: Text(
            _selectedType == null ? 'New Note' : _titleForType(_selectedType!),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              if (_selectedType != null) {
                setState(() => _selectedType = null);
              } else {
                Navigator.of(context).pop();
              }
            },
          ),
        ),
        body: SafeArea(
          child: _selectedType == null
              ? _TypeSelector(
                  onSelect: (type) => setState(() => _selectedType = type),
                )
              : _FormForType(
                  noteType: _selectedType!,
                  folderId: widget.folderId,
                ),
        ),
      ),
    );
  }

  String _titleForType(NoteType type) {
    return switch (type) {
      NoteType.text => 'Plain text note',
      NoteType.todo => 'Todo note',
      NoteType.list => 'List note',
    };
  }
}

class _TypeSelector extends StatelessWidget {
  final ValueChanged<NoteType> onSelect;

  const _TypeSelector({required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Choose note type',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 16),
          _TypeCard(
            icon: Icons.text_snippet_outlined,
            title: 'Plain text',
            subtitle: 'Simple text content',
            onTap: () => onSelect(NoteType.text),
          ),
          const SizedBox(height: 12),
          _TypeCard(
            icon: Icons.check_circle_outline,
            title: 'Todo list',
            subtitle: 'Tasks with checkboxes',
            onTap: () => onSelect(NoteType.todo),
          ),
          const SizedBox(height: 12),
          _TypeCard(
            icon: Icons.format_list_bulleted,
            title: 'List',
            subtitle: 'Bullet list of items',
            onTap: () => onSelect(NoteType.list),
          ),
        ],
      ),
    );
  }
}

class _TypeCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _TypeCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(icon, color: Theme.of(context).colorScheme.primary),
        title: Text(title),
        subtitle: Text(subtitle),
        onTap: onTap,
      ),
    );
  }
}

class _FormForType extends StatelessWidget {
  final NoteType noteType;
  final String? folderId;

  const _FormForType({required this.noteType, this.folderId});

  @override
  Widget build(BuildContext context) {
    return switch (noteType) {
      NoteType.text => NoteFormPlain(folderId: folderId),
      NoteType.todo => NoteFormTodo(folderId: folderId),
      NoteType.list => NoteFormList(folderId: folderId),
    };
  }
}
