import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:path/path.dart';
import 'package:simplenote_app/db/db_helper.dart';
import 'package:simplenote_app/model/notes_model.dart';
import 'package:simplenote_app/screens/add_edit_screen.dart';

class ViewScreen extends StatelessWidget {
  final Note note;

  // ignore: use_key_in_widget_constructors
  ViewScreen({required this.note});

  final DbHelper _dbHelper = DbHelper();

  // ignore: unused_element
  String _formatDateTime(String dateTime) {
    final DateTime dt = DateTime.parse(dateTime);
    final now = DateTime.now();

    if (dt.year == now.year && dt.month == now.month && dt.day == now.day) {
      return 'Today, ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
    }

    return '${dt.day}/${dt.month}/${dt.year} ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        actions: [
          IconButton(
            onPressed: () => _showEditDialog(context),
            icon: const Icon(
              Icons.edit,
              color: Color.fromARGB(90, 0, 0, 0),
            ),
          ),
          IconButton(
            onPressed: () => _showDeleteDialog(context),
            icon: const Icon(
              Icons.delete,
              color: Color.fromARGB(90, 0, 0, 0),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    note.title,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),

                  const SizedBox(height: 12),
                    Row(
                    children:[
                      const Icon(Icons.access_time,
                      size:16,
                      color: Colors.black,
                      ),

                      const SizedBox(width: 8),
                  Text(
                    _formatDateTime(note.dateTime),
                    style: const TextStyle(
                      fontSize:14,
                      color: Colors.black,
                      fontWeight:FontWeight.w500,
                    ),
                  ),
                    ]
                  )
                ],
                
                
              )
            ),


            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32),
                  )
                ),

                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child:Text(
                    note.content,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      height:1.6,
                      letterSpacing: 0.2,
                    ),
                  )

                )
              ))
          ],
        ),
      ),
    );
  }

  Future<void> _showEditDialog(BuildContext context) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Text("Edit Note"),
        content: const Text("Do you want to edit this note?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text("Ok"),
          ),
        ],
      ),
    );

    if (confirm == true) {
      await Navigator.push(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(
          builder: (context) => AddEditScreen(
            note: note,
          ),
        ),
      );
    }
  }

  Future<void> _showDeleteDialog(BuildContext context) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Text("Delete Note"),
        content: const Text("Are you sure you want to delete this note?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context,false),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context,true),
            child: const Text("Delete"),
          ),
        ],
      ),
    );

    if (confirm == true) {
      await _dbHelper.deleteNote(note.id!);
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    }
  }
}
