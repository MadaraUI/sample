// import 'package:flutter/material.dart';
// import 'package:simplenote_app/db/db_helper.dart';
// import 'package:simplenote_app/model/notes_model.dart';
// import 'add_edit_screen.dart';
// import 'view_screen.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   final DbHelper _dbHelper = DbHelper();
//   List<Note> _notes = [];

//   @override
//   void initState() {
//     super.initState();
//     _loadNotes();
//   }

//   Future<void> _loadNotes() async {
//     final notes = await _dbHelper.getNotes();
//     setState(() {
//       _notes = notes;
//     });
//   }

//   String _formatDateTime(String dateTime) {
//     final DateTime dt = DateTime.parse(dateTime);
//     final now = DateTime.now();

//     if (dt.year == now.year && dt.month == now.month && dt.day == now.day) {
//       return 'Today, ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
//     }

//     return '${dt.day}/${dt.month}/${dt.year} ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: const Color.fromARGB(135, 246, 246, 246),
//         title: const Text("All Notes"),
//       ),
//       body: GridView.builder(
//         padding: const EdgeInsets.all(16),
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//           crossAxisSpacing: 16,
//           mainAxisSpacing: 16,
//         ),
//         itemCount: _notes.length,
//         itemBuilder: (context, index) {
//           final note = _notes[index];
//           return GestureDetector(
//             onTap: () async {
//               await Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => ViewScreen(note: note)),
//               );
//               _loadNotes();
//             },
//             child: Container(
//               decoration: BoxDecoration(
//                 color: Colors.blueGrey, // Replace `color` with a specific color value
//                 borderRadius: BorderRadius.circular(16),
//                 boxShadow: const [
//                   BoxShadow(
//                     color: Colors.black54,
//                     blurRadius: 4,
//                     offset: Offset(0, 2),
//                   ),
//                 ],
//               ),
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     note.title,
//                     style: const TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                     ),
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     note.content,
//                     style: const TextStyle(
//                       fontSize: 14,
//                       color: Colors.white70,
//                     ),
//                     maxLines: 4,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                   const Spacer(),
//                   Text(
//                     _formatDateTime(note.dateTime),
//                     style: const TextStyle(
//                       fontSize: 12,
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () async {
//           await Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => const AddEditScreen()),
//           );
//           _loadNotes();
//         },
//         // ignore: sort_child_properties_last
//         child: const Icon(Icons.add),
//         backgroundColor: Colors.yellow,
//         foregroundColor: Colors.black,
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simplenote_app/db/db_helper.dart';
import 'package:simplenote_app/model/notes_model.dart';
import 'package:simplenote_app/theme_provider.dart';
import 'add_edit_screen.dart';
import 'view_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DbHelper _dbHelper = DbHelper();
  List<Note> _notes = [];

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  Future<void> _loadNotes() async {
    final notes = await _dbHelper.getNotes();
    setState(() {
      _notes = notes;
    });
  }

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
    final themeProvider = Provider.of<ThemeProvider>(context); // Access theme provider
    bool isDarkMode = themeProvider.themeMode == ThemeMode.dark; // Determine current theme mode

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 248, 233, 118),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromARGB(134, 145, 144, 144),
        title: const Text("All Notes"),
        actions: [
          // Add the theme toggle switch in the AppBar actions
          Switch(
            value: isDarkMode,
            onChanged: (value) {
              themeProvider.toggleTheme(value);
            },
          ),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: _notes.length,
        itemBuilder: (context, index) {
          final note = _notes[index];
          return GestureDetector(
            onTap: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ViewScreen(note: note)),
              );
              _loadNotes();
            },
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 254, 250, 205), 
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromARGB(136, 159, 159, 159),
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    note.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 38, 38, 38),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    note.content,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color.fromARGB(179, 39, 39, 39),
                    ),
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Spacer(),
                  Text(
                    _formatDateTime(note.dateTime),
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color.fromARGB(255, 62, 62, 62),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddEditScreen()),
          );
          _loadNotes();
        },
        // ignore: sort_child_properties_last
        child: const Icon(Icons.add),
        backgroundColor: Colors.yellow,
        foregroundColor: Colors.black,
      ),
    );
  }
}
