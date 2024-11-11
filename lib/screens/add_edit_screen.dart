import 'package:flutter/material.dart';
import 'package:simplenote_app/custom_components/customelevatedbutton.dart';
import 'package:simplenote_app/db/db_helper.dart';
import 'package:simplenote_app/model/notes_model.dart';
import 'package:simplenote_app/screens/home_screen.dart';

class AddEditScreen extends StatefulWidget {
  final Note? note;
  const AddEditScreen({super.key, this.note});

  @override
  State<AddEditScreen> createState() => _AddEditScreenState();
}

class _AddEditScreenState extends State<AddEditScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final DbHelper _dbHelper = DbHelper();

  @override
  void initState() {
    super.initState();
    if (widget.note != null) {
      _titleController.text = widget.note!.title;
      _contentController.text = widget.note!.content;
    }
  }

  Future<void> _saveNote() async {
    if (_formKey.currentState!.validate()) {
      final title = _titleController.text;
      final content = _contentController.text;

      final note = Note(
        id: widget.note?.id,
        title: title,
        content: content,
        date: DateTime.now().toString(),
        dateTime: DateTime.now().toString(),
      );

      if (widget.note == null) {
        await _dbHelper.insertNote(note);
      } else {
        await _dbHelper.updateNote(note);
      }

      showDialog(
        // ignore: use_build_context_synchronously
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Note Saved'),
            actions: <Widget>[
              TextButton(
                child: const Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop(); 
                  Navigator.of(context).pop(); 

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                  );
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 244, 244, 244),
        title: Text(widget.note == null ? 'Add Note' : 'Edit Note'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  hintText: "Title",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter Your Title";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _contentController,
                decoration: InputDecoration(
                  hintText: "Content",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                maxLines: 10,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter Your Content";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              CustomElevatedButton(
                text: 'Save Note',
                onPressed: () {
                  _saveNote();
                  
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
