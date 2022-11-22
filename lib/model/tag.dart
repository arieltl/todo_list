class Tag {
  Tag({required this.name});

  final String name;

  Tag.fromJson(Map<String, dynamic> json) : this(name: json['name']! as String);

  Map<String, dynamic> toJson() => {'name': name};
}