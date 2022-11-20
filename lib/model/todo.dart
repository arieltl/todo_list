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
  final DateTime dueDate;
  final DateTime creationDate;
  final String text;
  final List<String> tagIds;
  final int importance;

  ToDo.fromJson(Map<String, dynamic> json)
      : this(
          title: json['title']! as String,
          description: json['description']! as String,
          dueDate: DateTime.parse(json['dueDate']! as String),
          creationDate: DateTime.parse(json['creationDate']! as String),
          text: json['text']! as String,
          tagIds: (json['tagIds']! as List).cast<String>(),
          importance: json['importance']! as int,
        );

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        'dueDate': dueDate.toIso8601String(),
        'creationDate': creationDate.toIso8601String(),
        'text': text,
        'tagIds': tagIds,
        'importance': importance,
      };
}
