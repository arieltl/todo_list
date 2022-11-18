class Tag {
  String name;
  final String id;

  Tag(this.name) : id = "";
  Tag.fromDb(this.name, this.id);
}
