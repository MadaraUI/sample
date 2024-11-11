class Note {
  final int? id;
  late final String title;
  late final String content;
  final String dateTime;

  Note({
    this.id,
    required this.title,
    required this.content,
    required this.dateTime, required String date,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'dateTime': dateTime,
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'],
      title: map['title'],
      content: map['content'],
      dateTime: map['dateTime'], date: '',
    );
  }
}
