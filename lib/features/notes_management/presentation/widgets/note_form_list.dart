import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/note.dart';
import '../bloc/note_form/note_form_bloc.dart';

class NoteFormList extends StatefulWidget {
  final String? folderId;
  final int maxNameLength = 80;

  const NoteFormList({super.key, this.folderId});

  @override
  State<NoteFormList> createState() => _NoteFormListState();
}

class _NoteFormListState extends State<NoteFormList> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final List<String> _items = [];
  final _newItemController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _newItemController.dispose();
    super.dispose();
  }

  void _addItem() {
    final text = _newItemController.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _items.add(text);
      _newItemController.clear();
    });
  }

  void _removeItem(int index) {
    setState(() => _items.removeAt(index));
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text.trim();
      final note = Note.list(
        id: '',
        name: name,
        folderId: widget.folderId,
        userId: '',
        createdAt: DateTime.now(),
        items: List.unmodifiable(_items),
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
                hintText: 'List title',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.format_list_bulleted),
              ),
              maxLength: widget.maxNameLength,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter a title';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            Text('Items', style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 8),
            ...List.generate(_items.length, (index) {
              return Card(
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 16,
                    child: Text('${index + 1}'),
                  ),
                  title: Text(_items[index]),
                  trailing: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => _removeItem(index),
                  ),
                ),
              );
            }),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _newItemController,
                    decoration: const InputDecoration(
                      labelText: 'New item',
                      border: OutlineInputBorder(),
                      isDense: true,
                    ),
                    textInputAction: TextInputAction.done,
                    onSubmitted: (_) => _addItem(),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton.filled(
                  onPressed: _addItem,
                  icon: const Icon(Icons.add),
                ),
              ],
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
