// lib/edit_note_page.dart
import 'package:flutter/material.dart';
import 'models/note.dart';

class EditNotePage extends StatefulWidget {
  final Note? existing;
  const EditNotePage({super.key, this.existing});

  @override
  State<EditNotePage> createState() => _EditNotePageState();
}

class _EditNotePageState extends State<EditNotePage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _bodyController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.existing?.title ?? '');
    _bodyController = TextEditingController(text: widget.existing?.body ?? '');
  }

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;

    final title = _titleController.text.trim();
    final body = _bodyController.text.trim();

    final result = widget.existing == null
        ? Note(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            title: title,
            body: body,
          )
        : widget.existing!.copyWith(title: title, body: body);

    Navigator.pop(context, result);
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.existing != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Редактировать заметку' : 'Новая заметка'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: _save,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Заголовок',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _bodyController,
                decoration: const InputDecoration(
                  labelText: 'Текст заметки',
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
                minLines: 6,
                maxLines: null,
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Введите текст' : null,
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: _save,
                  icon: const Icon(Icons.save),
                  label: const Text('Сохранить'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}