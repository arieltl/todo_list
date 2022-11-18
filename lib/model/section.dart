class Section {
  final String id;
  String name;

  Section(this.name) : id = "";
  Section.fromDb(this.id, this.name);
}
