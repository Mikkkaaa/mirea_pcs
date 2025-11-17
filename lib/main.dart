// lib/main.dart
import 'package:flutter/material.dart';
import 'models/note.dart';
import 'edit_note_page.dart';

void main() => runApp(const SimpleNotesApp());

class SimpleNotesApp extends StatelessWidget {
  const SimpleNotesApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Simple Notes',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
      home: const NotesPage(),
    );
  }
}

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});
  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final List<Note> _notes = [
    Note(id: '1', title: 'Пример заметки', body: 'Это пример содержимого'),
    Note(id: '2', title: 'Купить молоко', body: 'И хлеб тоже'),
  ];

  String _searchQuery = '';

  List<Note> get _filteredNotes {
    if (_searchQuery.isEmpty) return _notes;
    return _notes
        .where((n) => n.title.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();
  }

  Future<void> _addNote() async {
    final note = await Navigator.push<Note>(
      context,
      MaterialPageRoute(builder: (_) => const EditNotePage()),
    );
    if (note != null) setState(() => _notes.add(note));
  }

  Future<void> _editNote(Note note) async {
    final updated = await Navigator.push<Note>(
      context,
      MaterialPageRoute(builder: (_) => EditNotePage(existing: note)),
    );
    if (updated != null) {
      setState(() {
        final i = _notes.indexWhere((n) => n.id == updated.id);
        if (i != -1) _notes[i] = updated;
      });
    }
  }

  void _deleteNote(Note note) {
    setState(() => _notes.remove(note));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Заметка удалена')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final notes = _filteredNotes;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Simple Notes'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: TextField(
              onChanged: (v) => setState(() => _searchQuery = v),
              decoration: InputDecoration(
                hintText: 'Поиск по заголовку...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNote,
        child: const Icon(Icons.add),
      ),
      body: notes.isEmpty
          ? const Center(child: Text('Нет заметок\nНажмите + для создания'))
          : ListView.builder(
              itemCount: notes.length,
              itemBuilder: (context, i) {
                final note = notes[i];
                return Dismissible(
                  key: ValueKey(note.id),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    child: const Icon(Icons.delete_forever, color: Colors.white, size: 32),
                  ),
                  onDismissed: (_) => _deleteNote(note),
                  child: Card(
                    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    child: ListTile(
                      title: Text(note.title.isEmpty ? '(Без названия)' : note.title),
                      subtitle: Text(note.body, maxLines: 2, overflow: TextOverflow.ellipsis),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                        onPressed: () => _deleteNote(note),
                      ),
                      onTap: () => _editNote(note),
                    ),
                  ),
                );
              },
            ),
    );
  }
}