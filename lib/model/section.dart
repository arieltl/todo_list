class Section {
  final String name;

  Section(this.name);
  Section.fromJson(Map<String, dynamic> json) : this(json["name"]! as String);

  Map<String, dynamic> toJson() => {"name": name};
}
