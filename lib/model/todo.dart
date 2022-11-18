class ToDo {
  final String id;
  DateTime dueDate;
  DateTime creationDate;
  String text;
  List<String> tagIds;
  int importance;

  ToDo(this.id, this.dueDate, this.creationDate, this.text, this.tagIds,
      this.importance);
}