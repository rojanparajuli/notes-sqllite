class Note {
  final int? id;
  final String text;
  final String? imagePath;

  Note({this.id, required this.text, this.imagePath});

  Map<String, dynamic> toMap() {
    return {'id': id, 'text': text, 'imagePath': imagePath};
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(id: map['id'], text: map['text'], imagePath: map['imagePath']);
  }
}