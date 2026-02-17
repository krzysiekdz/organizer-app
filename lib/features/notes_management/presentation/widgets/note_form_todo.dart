import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/note.dart';
import '../../domain/entities/todo_task.dart';
import '../bloc/note_form/note_form_bloc.dart';

class NoteFormTodo extends StatefulWidget {
  final String? folderId;
  final int maxNameLength = 80;

  const NoteFormTodo({super.key, this.folderId});

  @override
  State<NoteFormTodo> createState() => _NoteFormTodoState();
}

class _NoteFormTodoState extends State<NoteFormTodo> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final List<TodoTask> _tasks = [];
  final _newTaskController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _newTaskController.dispose();
    super.dispose();
  }

  void _addTask() {
    final text = _newTaskController.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _tasks.add(TodoTask(task: text, isDone: false));
      _newTaskController.clear();
    });
  }

  void _removeTask(int index) {
    setState(() => _tasks.removeAt(index));
  }

  void _toggleTask(int index) {
    setState(() {
      final t = _tasks[index];
      _tasks[index] = TodoTask(task: t.task, isDone: !t.isDone);
    });
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text.trim();
      final note = Note.todo(
        id: '',
        name: name,
        folderId: widget.folderId,
        userId: '',
        createdAt: DateTime.now(),
        tasks: List.unmodifiable(_tasks),
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
                hintText: 'Todo list title',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.check_circle_outline),
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
            Text('Tasks', style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 8),
            ...List.generate(_tasks.length, (index) {
              final task = _tasks[index];
              return Card(
                child: ListTile(
                  leading: Checkbox(
                    value: task.isDone,
                    onChanged: (_) => _toggleTask(index),
                  ),
                  title: Text(
                    task.task,
                    style: task.isDone
                        ? TextStyle(
                            decoration: TextDecoration.lineThrough,
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurfaceVariant,
                          )
                        : null,
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => _removeTask(index),
                  ),
                ),
              );
            }),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _newTaskController,
                    decoration: const InputDecoration(
                      labelText: 'New task',
                      border: OutlineInputBorder(),
                      isDense: true,
                    ),
                    textInputAction: TextInputAction.done,
                    onSubmitted: (_) => _addTask(),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton.filled(
                  onPressed: _addTask,
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
