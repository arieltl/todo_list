class ToDo {
  ToDo(
      {required this.title,
      required this.description,
      required this.tagIds,
      required this.dueDate,
      required this.creationDate,
      required this.text,
      required this.importance});

  final String title;
  final String description;
  final DateTime? dueDate;
  final DateTime creationDate;
  final String text;
  final List<String> tagIds;
  final int importance;

  ToDo.fromJson(Map<String, dynamic> json)
      : this(
          title: json['title']! as String,
          description: json['description']! as String,
          dueDate: json['dueDate'] != null ? DateTime.fromMillisecondsSinceEpoch(json['dueDate']! as int) : null,
          creationDate: DateTime.fromMillisecondsSinceEpoch(json['creationDate']! as int),
          text: json['text']! as String,
          tagIds: (json['tagIds']! as List).cast<String>(),
          importance: json['importance']! as int,
        );

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        'dueDate': dueDate?.millisecondsSinceEpoch,
        'creationDate': creationDate.microsecondsSinceEpoch,
        'text': text,
        'tagIds': tagIds,
        'importance': importance,
      };
}
